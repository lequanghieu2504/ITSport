<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css"/>
    </head>
    <body>

        <jsp:include page="/common/header.jsp"/>

        <main class="flex-grow-1">
            <div class="cart-wrapper py-5">
                <h2 class="cart-title">GIỎ HÀNG CỦA BẠN</h2>

                <c:choose>
                    <c:when test="${empty listCartItem}">
                        <p class="empty-message">Giỏ hàng của bạn đang trống.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="cart-container">
                            <c:forEach var="item" items="${listCartItem}" varStatus="status">
                                <div class="cart-item row align-items-center gx-2 gy-3" id="cart-item-${status.index}">
                                    <!-- Checkbox -->
                                    <div class="col-1 text-center">
                                        <input type="checkbox" class="form-check-input checkout-checkbox" checked>
                                    </div>

                                    <!-- Hình ảnh -->
                                    <div class="col-2">
                                        <img src="${pageContext.request.contextPath}/${item.product.img_url}" 
                                             alt="${item.product.product_name}" 
                                             class="product-img"/>
                                    </div>

                                    <!-- Tên sản phẩm và biến thể -->
                                    <div class="col-3">
                                        <div class="product-name">${item.product.product_name}</div>
                                        <c:if test="${not empty item.variant}">
                                            <div class="text-muted small">
                                                Size: ${item.variant.size} | Màu: ${item.variant.color}
                                            </div>
                                        </c:if>
                                    </div>

                                    <!-- Giá -->
                                    <div class="col-2">
                                        <div class="product-price" data-price="${item.product.price}">${item.product.price}₫</div>
                                    </div>

                                    <!-- Số lượng -->
                                    <div class="col-2">
                                        <div class="input-group quantity-group">
                                            <button type="button" class="btn btn-outline-secondary btn-sm btn-qty-minus">-</button>
                                            <input type="number" 
                                                   class="form-control text-center quantity-input" 
                                                   name="quantity" 
                                                   value="${item.quantity}" 
                                                   min="1"
                                                   data-product-id="${item.product.product_id}" 
                                                   data-variant-id="${not empty item.variant ? item.variant.product_variant_id : ''}"/>

                                            <button type="button" class="btn btn-outline-secondary btn-sm btn-qty-plus">+</button>
                                        </div>
                                    </div>

                                    <!-- Xóa -->
                                    <div class="col-2 text-end">
                                        <form action="MainController" method="post">
                                            <input type="hidden" name="action" value="removeFromCart"/>
                                            <input type="hidden" name="product_id" value="${item.product.product_id}"/>
                                            <input type="hidden" name="variant_id" value="${item.variant.product_variant_id}"/>
                                            <button class="btn btn-outline-secondary btn-sm mt-2 mt-md-0">
                                                <i class="fas fa-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Tổng tiền -->
                            <div class="cart-summary">
                                Tổng cộng: <span id="cart-total">0₫</span>
                            </div>

                            <!-- Thanh toán -->
                            <form action="BuyingController" method="post" class="text-end mt-3" id="checkout-form">
                                <input type="hidden" name="action" value="cartCheckout"/>
                                <c:forEach var="item" items="${listCartItem}" varStatus="status">
                                    <div class="hidden-inputs" id="hidden-${status.index}">
                                        <input type="hidden" name="StrProductId" value="${item.product.product_id}"/>
                                        <input type="hidden" name="StrColor"     value="${item.variant.color}"/>
                                        <input type="hidden" name="StrSize"      value="${item.variant.size}"/>
                                        <input type="hidden" name="StrQuantity"  value="${item.quantity}"/>
                                    </div>
                                </c:forEach>
                                <button type="submit" class="btn btn-success">Thanh toán</button>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <jsp:include page="/common/footer.jsp"/>
        <jsp:include page="/common/popup.jsp" />


        <!-- Script tính lại total và lọc item đã chọn -->
        <script>
            function updateCartTotal() {
                let total = 0;
                const items = document.querySelectorAll('.cart-item');
                items.forEach((item, index) => {
                    const checkbox = item.querySelector('.checkout-checkbox');
                    const price = parseInt(item.querySelector('.product-price').dataset.price);
                    const quantity = parseInt(item.querySelector('.quantity-input').value);
                    if (checkbox.checked) {
                        total += price * quantity;
                    }
                });
                document.getElementById('cart-total').textContent = total.toLocaleString('vi-VN') + '₫';
            }

            // Tính lại khi tick/bỏ tick hoặc thay đổi số lượng
            const checkboxes = document.querySelectorAll('.checkout-checkbox');
            checkboxes.forEach(cb => cb.addEventListener('change', updateCartTotal));
            const quantities = document.querySelectorAll('.quantity-input');
            quantities.forEach(qty => qty.addEventListener('input', updateCartTotal));

            updateCartTotal(); // Tính lúc load

            // Xử lý submit: chỉ gửi sản phẩm được tick
            const form = document.getElementById('checkout-form');
            form.addEventListener('submit', function (e) {
                const checkboxes = document.querySelectorAll('.checkout-checkbox');
                checkboxes.forEach((checkbox, index) => {
                    const hiddenInputs = document.getElementById('hidden-' + index);
                    if (!checkbox.checked) {
                        hiddenInputs.remove();
                    }
                });
            });

            function updateCartTotal() {
                let total = 0;
                const items = document.querySelectorAll('.cart-item');
                items.forEach((item) => {
                    const checkbox = item.querySelector('.checkout-checkbox');
                    const price = parseInt(item.querySelector('.product-price').dataset.price);
                    const quantity = parseInt(item.querySelector('.quantity-input').value);
                    if (checkbox.checked) {
                        total += price * quantity;
                    }
                });
                document.getElementById('cart-total').textContent = total.toLocaleString('vi-VN') + '₫';
            }

            function sendUpdateQuantity(productId, variantId, quantity) {
                console.log("Sending update:", productId, variantId, quantity);
                fetch('MainController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `action=updateCart&pid=${productId}&variant_id=${variantId}&quantity=${quantity}`
                }).then(response => {
                    if (!response.ok) {
                        console.error("Cập nhật số lượng thất bại");
                    }
                });
            }

            document.querySelectorAll('.btn-qty-plus').forEach((btn) => {
                btn.addEventListener('click', function () {
                    const input = this.parentElement.querySelector('.quantity-input');
                    input.value = parseInt(input.value) + 1;
                    updateCartTotal();

                    const productId = input.dataset.productId;
                    const variantId = input.dataset.variantId;

                    console.log("🟢 Product ID:", productId);  // KIỂM TRA Ở ĐÂY
                    console.log("🟢 Variant ID:", variantId);
                    sendUpdateQuantity(productId, variantId, input.value);
                });
            });

            document.querySelectorAll('.btn-qty-minus').forEach((btn) => {
                btn.addEventListener('click', function () {
                    const input = this.parentElement.querySelector('.quantity-input');
                    const current = parseInt(input.value);
                    if (current > 1) {
                        input.value = current - 1;
                        updateCartTotal();

                        const productId = input.dataset.productId;
                        const variantId = input.dataset.variantId;
                        sendUpdateQuantity(productId, variantId, input.value);
                    }
                });
            });

            document.querySelectorAll('.quantity-input').forEach((input) => {
                input.addEventListener('change', function () {
                    let value = parseInt(this.value);
                    if (isNaN(value) || value < 1)
                        value = 1;
                    this.value = value;
                    updateCartTotal();

                    const productId = input.dataset.productId;
                    const variantId = input.dataset.variantId;
                    sendUpdateQuantity(productId, variantId, value);
                });
            });

            // Tính tổng lần đầu
            updateCartTotal();

        </script>
    </body>
</html>
