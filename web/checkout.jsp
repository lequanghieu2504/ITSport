<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>

    <!-- ✅ jQuery chỉ 1 bản -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- ✅ Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>

    <style>
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .product-info {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
        }
        .total-section {
            background-color: #fff;
            border: 2px solid #007bff;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="/common/header.jsp"/>

<div class="container my-5">
    <div class="row">
        <div class="col-md-8">
            <h3>Thông tin thanh toán</h3>

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="processCheckout"/>

                <!-- Địa chỉ giao hàng -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5>Địa chỉ giao hàng</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty userAddresses}">
                                <c:forEach var="address" items="${userAddresses}" varStatus="status">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="addressId"
                                               value="${address.addressId}" id="address${status.index}"
                                               ${status.first ? 'checked' : ''}>
                                        <label class="form-check-label" for="address${status.index}">
                                            <strong>${address.recipientName}</strong><br>
                                            ${address.street}, ${address.city}<br>
                                            Điện thoại: ${address.phone}
                                        </label>
                                    </div>
                                    <hr>
                                </c:forEach>
                                <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#addAddressModal">
                                    Thêm địa chỉ mới
                                </button>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning">
                                    Bạn chưa có địa chỉ giao hàng.
                                    <a href="#" class="alert-link" data-toggle="modal" data-target="#addAddressModal">
                                        Thêm địa chỉ mới
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5>Phương thức thanh toán</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod"
                                   value="COD" id="cod" checked>
                            <label class="form-check-label" for="cod">
                                Thanh toán khi nhận hàng (COD)
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod"
                                   value="BANK_TRANSFER" id="bank">
                            <label class="form-check-label" for="bank">
                                Chuyển khoản ngân hàng
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod"
                                   value="CREDIT_CARD" id="credit">
                            <label class="form-check-label" for="credit">
                                Thẻ tín dụng
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Nút đặt hàng -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary btn-lg">
                        Đặt hàng ngay
                    </button>
                    <a href="MainController?action=viewDetailProduct&pid=${buyNowInfo.productId}"
                       class="btn btn-secondary btn-lg ml-2">
                        Quay lại
                    </a>
                </div>
            </form>
        </div>

        <!-- Tóm tắt đơn hàng -->
        <div class="col-md-4">
            <div class="order-summary">
                <h4>Tóm tắt đơn hàng</h4>

                <div class="product-info">
                    <h6>${buyNowInfo.productName}</h6>
                    <p class="text-muted mb-1">
                        <c:if test="${not empty buyNowInfo.color}">
                            Màu: ${buyNowInfo.color}
                        </c:if>
                        <c:if test="${not empty buyNowInfo.size}">
                            | Size: ${buyNowInfo.size}
                        </c:if>
                    </p>
                    <p class="mb-1">
                        Số lượng: ${buyNowInfo.quantity}
                    </p>
                    <p class="mb-0">
                        Giá: <fmt:formatNumber value="${buyNowInfo.price}" type="currency" currencySymbol="₫"/>
                    </p>
                </div>

                <div class="total-section">
                    <div class="d-flex justify-content-between">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${buyNowInfo.totalPrice}" type="currency" currencySymbol="₫"/></span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>Phí vận chuyển:</span>
                        <span>Miễn phí</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <strong>Tổng cộng:</strong>
                        <strong class="text-danger">
                            <fmt:formatNumber value="${buyNowInfo.totalPrice}" type="currency" currencySymbol="₫"/>
                        </strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Thêm Địa Chỉ -->
<div class="modal fade" id="addAddressModal" tabindex="-1" role="dialog" aria-labelledby="addAddressModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="addAddress"/>

                <div class="modal-header">
                    <h5 class="modal-title" id="addAddressModalLabel">Thêm địa chỉ mới</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label>Họ tên người nhận</label>
                        <input type="text" class="form-control" name="recipientName" required>
                    </div>

                    <div class="form-group">
                        <label>Tỉnh/Thành phố</label>
                        <select id="provinceSelect" class="form-control" required></select>
                    </div>

                    <div class="form-group">
                        <label>Quận/Huyện</label>
                        <select id="districtSelect" class="form-control" required></select>
                    </div>

                    <div class="form-group">
                        <label>Phường/Xã</label>
                        <select id="wardSelect" class="form-control" name="city" required></select>
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ chi tiết</label>
                        <input type="text" class="form-control" name="street" required>
                    </div>

                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="tel" class="form-control" name="phone" required>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu địa chỉ</button>
                </div>

            </form>
        </div>
    </div>
</div>

<!-- ✅ Script load JSON -->
<script>
    let provinces = [];

    $(document).ready(function () {
        const url = '${pageContext.request.contextPath}/assets/VietNam.json';
        console.log("Load JSON:", url);

        $.getJSON(url, function (data) {
            provinces = data;
            loadProvinces();
        });

        function loadProvinces() {
            $('#provinceSelect').empty().append('<option value="">-- Chọn Tỉnh/TP --</option>');
            provinces.forEach(function (province) {
                $('#provinceSelect').append(`<option value="${province.name}">${province.name}</option>`);
            });
        }

        $('#provinceSelect').on('change', function () {
            const selectedProvince = $(this).val();
            const provinceData = provinces.find(p => p.name === selectedProvince);

            $('#districtSelect').empty().append('<option value="">-- Chọn Quận/Huyện --</option>');
            $('#wardSelect').empty().append('<option value="">-- Chọn Phường/Xã --</option>');

            if (provinceData) {
                provinceData.Districts.forEach(function (district) {
                    $('#districtSelect').append(`<option value="${district.name}">${district.name}</option>`);
                });
            }
        });

        $('#districtSelect').on('change', function () {
            const selectedProvince = $('#provinceSelect').val();
            const selectedDistrict = $(this).val();
            const provinceData = provinces.find(p => p.name === selectedProvince);
            const districtData = provinceData.Districts.find(d => d.name === selectedDistrict);

            $('#wardSelect').empty().append('<option value="">-- Chọn Phường/Xã --</option>');
            if (districtData) {
                districtData.Wards.forEach(function (ward) {
                    $('#wardSelect').append(`<option value="${ward.name}">${ward.name}</option>`);
                });
            }
        });
    });
</script>

<!-- ✅ Popper & Bootstrap JS (sau jQuery & script) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<jsp:include page="/common/footer.jsp"/>

</body>
</html>
