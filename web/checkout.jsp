<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>

        <!-- ✅ jQuery -->
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
                                    <c:when test="${not empty userBuyingInfoDTOs}">
                                        <c:forEach var="userBuyingInfo" items="${userBuyingInfoDTOs}" varStatus="status">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="selectedAddress"
                                                       value="${userBuyingInfo.userBuyingInforId}"  
                                                id="address${status.index}"
                                                ${status.first ? 'checked' : ''}>
                                                <label class="form-check-label" for="address${status.index}">
                                                    <div style="margin-bottom: 5px;">
                                                        <strong>${userBuyingInfo.recipientName} (+84) ${userBuyingInfo.phone}</strong>
                                                    </div>
                                                    <div style="color: #666;">
                                                        ${userBuyingInfo.street}, ${userBuyingInfo.ward}, ${userBuyingInfo.district}, ${userBuyingInfo.province}
                                                    </div>
                                                </label>
                                                <div style="margin-top: 8px;">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary" 
                                                            style="border: 1px solid #ccc; color: #666; padding: 2px 8px; font-size: 12px;">
                                                        Thay Đổi
                                                    </button>
                                                </div>
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
                        <input type="hidden" name="action" value="addUserBuyingInfor"/>

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

                            <select id="provinceSelect" name="province" class="form-control" required>
                                <option value="" selected>Chọn tỉnh thành</option>
                            </select>

                            <select id="districtSelect" name="district" class="form-control" required>
                                <option value="" selected>Chọn quận huyện</option>
                            </select>


                            <div class="form-group">
                                <label>Phường/Xã</label>
                                <select id="wardSelect" class="form-control" name="ward" required>
                                    <option value="" selected>Chọn phường xã</option>
                                </select>
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

        <!-- ✅ SCRIPT địa chỉ chuẩn Axios -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
            const citis = document.getElementById("provinceSelect");
            const district = document.getElementById("districtSelect");
            const wards = document.getElementById("wardSelect");

            const Parameter = {
                url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                method: "GET",
                responseType: "application/json",
            };

            axios(Parameter).then(function (result) {
                renderCity(result.data);
            });

            function renderCity(data) {
                for (const x of data) {
                    const opt = document.createElement('option');
                    opt.value = x.Name;
                    opt.text = x.Name;
                    opt.setAttribute('data-id', x.Id);
                    citis.options.add(opt);
                }

                citis.onchange = function () {
                    district.length = 1;
                    wards.length = 1;

                    if (this.options[this.selectedIndex].dataset.id !== "") {
                        const result = data.filter(n => n.Id === this.options[this.selectedIndex].dataset.id);
                        for (const k of result[0].Districts) {
                            const opt = document.createElement('option');
                            opt.value = k.Name;
                            opt.text = k.Name;
                            opt.setAttribute('data-id', k.Id);
                            district.options.add(opt);
                        }
                    }
                };

                district.onchange = function () {
                    wards.length = 1;
                    const dataCity = data.filter(n => n.Id === citis.options[citis.selectedIndex].dataset.id);

                    if (this.options[this.selectedIndex].dataset.id !== "") {
                        const dataWards = dataCity[0].Districts.filter(n => n.Id === this.options[this.selectedIndex].dataset.id)[0].Wards;
                        for (const w of dataWards) {
                            const opt = document.createElement('option');
                            opt.value = w.Name;
                            opt.text = w.Name;
                            opt.setAttribute('data-id', w.Id);
                            wards.options.add(opt);
                        }
                    }
                };
            }
        </script>

        <!-- ✅ Popper & Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

        <jsp:include page="/common/footer.jsp"/>

    </body>
</html>
