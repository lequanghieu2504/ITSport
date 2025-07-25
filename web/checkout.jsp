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
            .address-item {
                border: 1px solid #dee2e6;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                position: relative;
            }
            .address-actions {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            .address-actions .btn {
                margin-left: 5px;
                padding: 3px 8px;
                font-size: 12px;
            }
            .address-info {
                margin-right: 80px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="/common/header.jsp"/>

        <div class="container my-5">
            <div class="row">
                <div class="col-md-8">
                    <h3>Thông tin thanh toán</h3>

                    <c:choose>
                        <c:when test="${not empty sessionScope.cartInfos}">
                            <%-- Chỉ tính tổng (ẩn) --%>
                            <c:set var="cartTotal" value="0"/>
                            <c:forEach var="item" items="${sessionScope.cartInfos}">
                                <c:set var="cartTotal" value="${cartTotal + (item.price * item.quantity)}"/>
                            </c:forEach>

                            <c:set var="totalBill" value="${cartTotal}" />
                        </c:when>
                        <c:when test="${not empty buyNowInfo}">
                            <c:set var="totalBill" value="${buyNowInfo.totalPrice}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="totalBill" value="0" />
                        </c:otherwise>
                    </c:choose>

                    <form id="checkoutForm" action="MainController" method="post">
                        <input type="hidden" name="action" value="checkout"/>
                        <input type="hidden" name="totalBill" id="totalBillField" value="${totalBill}"/>

                        <!-- ✅ THÊM CÁC TRƯỜNG HIDDEN CHO THÔNG TIN SẢN PHẨM -->
                        <!-- Nếu mua ngay -->
                        <c:if test="${not empty buyNowInfo}">
                            <input type="hidden" name="productId" value="${buyNowInfo.productId}"/>
                            <input type="hidden" name="variantId" value="${buyNowInfo.variantId}"/>
                            <input type="hidden" name="quantity" value="${buyNowInfo.quantity}"/>
                            <input type="hidden" name="priceEach" value="${buyNowInfo.price}"/>

                        </c:if>

                        <!-- Nếu thanh toán giỏ hàng -->
                        <c:if test="${not empty sessionScope.cartInfos}">
                            <c:forEach var="item" items="${sessionScope.cartInfos}">
                                <input type="hidden" name="productId"  value="${item.productId}"/>
                                <input type="hidden" name="variantId"  value="${item.variantId}"/>
                                <input type="hidden" name="quantity"   value="${item.quantity}"/>
                                <input type="hidden" name="priceEach"  value="${item.price}"/>
                                <input type="hidden" name="StrCartItemId"  value="${item.cartItemId}"/>
                            </c:forEach>
                        </c:if>

                        <!-- Địa chỉ giao hàng -->
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5>Địa chỉ giao hàng</h5>
                                <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addAddressModal">
                                    <i class="fas fa-plus"></i> Thêm địa chỉ mới
                                </button>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty userBuyingInfoDTOs}">
                                        <c:forEach var="address" items="${userBuyingInfoDTOs}" varStatus="status">
                                            <div class="address-item" id="addressItem${address.userBuyingInforId}">
                                                <div class="address-actions">
                                                    <button type="button" class="btn btn-warning btn-sm" 
                                                            onclick="editAddress(${address.userBuyingInforId}, '${address.recipientName}', '${address.province}', '${address.district}', '${address.ward}', '${address.street}', '${address.phone}')"
                                                            data-toggle="modal" data-target="#editAddressModal">
                                                        <i class="fas fa-edit"></i> Sửa
                                                    </button>
                                                    <button type="button" class="btn btn-danger btn-sm" 
                                                            onclick="deleteAddress(${address.userBuyingInforId})">
                                                        <i class="fas fa-trash"></i> Xóa
                                                    </button>
                                                </div>

                                                <div class="address-info">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="selectedAddress"
                                                               value="${address.userBuyingInforId}" id="address${status.index}"
                                                               ${status.first ? 'checked' : ''}>
                                                        <label class="form-check-label" for="address${status.index}">
                                                            <div style="margin-bottom: 5px;">
                                                                <strong>${address.recipientName} (+84) ${address.phone}</strong>
                                                            </div>
                                                            <div style="color: #666;">
                                                                ${address.street}, ${address.ward}, ${address.district}, ${address.province}
                                                            </div>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
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
                                           value="VNPAY" id="VNPAY">
                                    <label class="form-check-label" for="bank">
                                        Chuyển khoản ngân hàng
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Nút đặt hàng -->
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Đặt hàng ngay
                            </button>
                            <a href="javascript:history.back()" class="btn btn-secondary btn-lg ml-2">
                                Quay lại
                            </a>

                        </div>
                    </form>
                </div>

                <!-- Tóm tắt đơn hàng -->
                <div class="col-md-4">
                    <div class="order-summary">
                        <h4>Tóm tắt đơn hàng</h4>

                        <!-- Luồng cart -->
                        <c:if test="${not empty sessionScope.cartInfos}">
                            <c:set var="cartTotal" value="0"/>
                            <c:forEach var="item" items="${sessionScope.cartInfos}">
                                <div class="product-info">
                                    <h6>${item.productName}</h6>
                                    <p class="text-muted mb-1">${item.color} | ${item.size}</p>
                                    <p class="mb-1">${item.quantity} x 
                                        <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/>
                                    </p>
                                </div>
                                <c:set var="cartTotal" value="${cartTotal + item.totalPrice}"/>
                            </c:forEach>
                            <div class="total-section">
                                <div class="d-flex justify-content-between">
                                    <span>Tạm tính:</span>
                                    <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/></span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span>Phí vận chuyển:</span>
                                    <span>Miễn phí</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Tổng cộng:</strong>
                                    <strong class="text-danger">
                                        <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/>
                                    </strong>
                                </div>
                            </div>
                        </c:if>

                        <!-- Luồng buyNow -->
                        <c:if test="${not empty buyNowInfo}">
                            <div class="product-info">
                                <h6>${buyNowInfo.productName}</h6>
                                <p class="text-muted mb-1">
                                    <c:if test="${not empty buyNowInfo.color}">Màu: ${buyNowInfo.color}</c:if>
                                    <c:if test="${not empty buyNowInfo.size}">| Size: ${buyNowInfo.size}</c:if>
                                    </p>
                                    <p class="mb-1">Số lượng: ${buyNowInfo.quantity}</p>
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
                        </c:if>

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
                            <div class="form-group">
                                <label>Thành Phố</label>
                                <select id="provinceSelect" name="province" class="form-control" required>
                                    <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Quận Huyện</label>
                                <select id="districtSelect" name="district" class="form-control" required>
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div>

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

        <!-- Modal Sửa Địa Chỉ -->
        <div class="modal fade" id="editAddressModal" tabindex="-1" role="dialog" aria-labelledby="editAddressModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="updateUserBuyingInfor"/>
                        <input type="hidden" name="userBuyingInforId" id="editAddressId"/>

                        <div class="modal-header">
                            <h5 class="modal-title" id="editAddressModalLabel">Sửa địa chỉ</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="form-group">
                                <label>Họ tên người nhận</label>
                                <input type="text" class="form-control" name="recipientName" id="editRecipientName" required>
                            </div>
                            <div class="form-group">
                                <label>Thành Phố</label>
                                <select id="editProvinceSelect" name="province" class="form-control" required>
                                    <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Quận Huyện</label>
                                <select id="editDistrictSelect" name="district" class="form-control" required>
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Phường/Xã</label>
                                <select id="editWardSelect" class="form-control" name="ward" required>
                                    <option value="" selected>Chọn phường xã</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Địa chỉ chi tiết</label>
                                <input type="text" class="form-control" name="street" id="editStreet" required>
                            </div>

                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="tel" class="form-control" name="phone" id="editPhone" required>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ✅ Font Awesome cho icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!-- ✅ SCRIPT địa chỉ chuẩn Axios -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
                                                                let addressData = null;

                                                                // Khởi tạo dữ liệu địa chỉ cho cả 2 modal
                                                                const Parameter = {
                                                                    url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                                                    method: "GET",
                                                                    responseType: "application/json",
                                                                };

                                                                axios(Parameter).then(function (result) {
                                                                    addressData = result.data;
                                                                    renderCity(result.data, 'provinceSelect', 'districtSelect', 'wardSelect');
                                                                    renderCity(result.data, 'editProvinceSelect', 'editDistrictSelect', 'editWardSelect');
                                                                });

                                                                function renderCity(data, provinceId, districtId, wardId) {
                                                                    const citis = document.getElementById(provinceId);
                                                                    const district = document.getElementById(districtId);
                                                                    const wards = document.getElementById(wardId);

                                                                    // Clear existing options
                                                                    citis.length = 1;
                                                                    district.length = 1;
                                                                    wards.length = 1;

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

                                                                // Hàm xóa địa chỉ
                                                                function deleteAddress(addressId) {
                                                                    if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) {
                                                                        // Tạo form tạm thời để gửi request xóa
                                                                        const form = document.createElement('form');
                                                                        form.method = 'POST';
                                                                        form.action = 'MainController';

                                                                        const actionInput = document.createElement('input');
                                                                        actionInput.type = 'hidden';
                                                                        actionInput.name = 'action';
                                                                        actionInput.value = 'deleteUserBuyingInfor';

                                                                        const idInput = document.createElement('input');
                                                                        idInput.type = 'hidden';
                                                                        idInput.name = 'userBuyingInforId';
                                                                        idInput.value = addressId;

                                                                        form.appendChild(actionInput);
                                                                        form.appendChild(idInput);
                                                                        document.body.appendChild(form);
                                                                        form.submit();
                                                                    }
                                                                }

                                                                // Hàm sửa địa chỉ - load dữ liệu trực tiếp từ tham số
                                                                function editAddress(addressId, recipientName, province, district, ward, street, phone) {
                                                                    document.getElementById('editAddressId').value = addressId;
                                                                    document.getElementById('editRecipientName').value = recipientName;
                                                                    document.getElementById('editStreet').value = street;
                                                                    document.getElementById('editPhone').value = phone;

                                                                    // Set selected values cho province, district, ward
                                                                    setTimeout(() => {
                                                                        setSelectedLocation(province, district, ward);
                                                                    }, 100);
                                                                }

                                                                // Hàm để set giá trị đã chọn cho province, district, ward
                                                                function setSelectedLocation(provinceName, districtName, wardName) {
                                                                    const provinceSelect = document.getElementById('editProvinceSelect');
                                                                    const districtSelect = document.getElementById('editDistrictSelect');
                                                                    const wardSelect = document.getElementById('editWardSelect');

                                                                    // Set province
                                                                    for (let i = 0; i < provinceSelect.options.length; i++) {
                                                                        if (provinceSelect.options[i].value === provinceName) {
                                                                            provinceSelect.selectedIndex = i;
                                                                            provinceSelect.onchange(); // Trigger change event
                                                                            break;
                                                                        }
                                                                    }

                                                                    // Set district after province is set
                                                                    setTimeout(() => {
                                                                        for (let i = 0; i < districtSelect.options.length; i++) {
                                                                            if (districtSelect.options[i].value === districtName) {
                                                                                districtSelect.selectedIndex = i;
                                                                                districtSelect.onchange(); // Trigger change event
                                                                                break;
                                                                            }
                                                                        }

                                                                        // Set ward after district is set
                                                                        setTimeout(() => {
                                                                            for (let i = 0; i < wardSelect.options.length; i++) {
                                                                                if (wardSelect.options[i].value === wardName) {
                                                                                    wardSelect.selectedIndex = i;
                                                                                    break;
                                                                                }
                                                                            }
                                                                        }, 100);
                                                                    }, 100);
                                                                }
        </script>

        <!-- ✅ Popper & Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

        <jsp:include page="/common/footer.jsp"/>
        <jsp:include page="/common/popup.jsp" />


        <!-- Thêm một input ẩn để truyền tổng tiền vào JS -->
        <script>
                                                                const checkoutForm = document.getElementById('checkoutForm'); // gán id cho form của bạn

                                                                checkoutForm.addEventListener('submit', function (e) {
                                                                    const method = document.querySelector('input[name="paymentMethod"]:checked').value;
                                                                    if (method === 'VNPAY') {
                                                                        e.preventDefault();

                                                                        console.log('[JS] original totalBill:', document.getElementById('totalBillField').value);
                                                                        // 1) Tạo form mới
                                                                        const vnpayForm = document.createElement('form');
                                                                        vnpayForm.method = 'post';
                                                                        vnpayForm.action = `${pageContext.request.contextPath}/payment`;

                                                                        // 2) Copy tất cả các input/select/textarea từ form gốc vào form mới
                                                                        Array.from(checkoutForm.elements).forEach(el => {
                                                                            // Chỉ clone các trường có name
                                                                            if (el.name) {
                                                                                const clone = document.createElement('input');
                                                                                clone.type = 'hidden';
                                                                                clone.name = el.name;
                                                                                clone.value = el.value;
                                                                                vnpayForm.appendChild(clone);
                                                                            }
                                                                        });

                                                                        // 3) Append và submit
                                                                        document.body.appendChild(vnpayForm);
                                                                        vnpayForm.submit();
                                                                    }
                                                                    // COD thì cứ gửi form gốc về MainController?action=checkout
                                                                });
        </script>



    </body>
</html>