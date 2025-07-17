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
                <form action="BuyingController" method="post" id="checkout-form">
                    <input type="hidden" name="action" value="cartCheckout"/>

                    <div class="cart-container">
                        <c:forEach var="item" items="${listCartItem}" varStatus="status">
                            <div class="cart-item row align-items-center gx-2 gy-3" id="cart-item-${status.index}">
                                <!-- Checkbox -->
                                <div class="col-1 text-center">
                                    <input type="checkbox" class="form-check-input checkout-checkbox"
                                           data-index="${status.index}" checked>
                                </div>

                                <!-- Hình ảnh -->
                                <div class="col-2">
                                    <img src="${pageContext.request.contextPath}/${item.image_url}"
                                         alt="${item.product.product_name}" class="product-img"/>
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
                                    <div class="product-price" data-price="${item.product.price}">
                                        ${item.product.price}₫
                                    </div>
                                </div>

                                <!-- SỐ LƯỢNG -->
                                <div class="col-2">
                                    <div class="input-group quantity-group">
                                        <form action="MainController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="updateQuantity"/>
                                            <input type="hidden" name="cartItemId" value="${item.cart_item_id}"/>
                                            <input type="hidden" name="quantity" value="${item.quantity - 1}"/>
                                            <button type="submit"
                                                    class="btn btn-outline-secondary btn-sm btn-qty-minus"
                                                    <c:if test="${item.quantity <= 1}">disabled</c:if>>-</button>
                                        </form>

                                        <input type="number"
                                               class="form-control text-center quantity-input"
                                               value="${item.quantity}" readonly/>

                                        <form action="MainController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="updateQuantity"/>
                                            <input type="hidden" name="cartItemId" value="${item.cart_item_id}"/>
                                            <input type="hidden" name="quantity" value="${item.quantity + 1}"/>
                                            <button type="submit"
                                                    class="btn btn-outline-secondary btn-sm btn-qty-plus">+</button>
                                        </form>
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

                                <!-- Hidden input nằm trong cart-item -->
                                <div class="hidden-inputs" id="hidden-${status.index}">
                                    <input type="hidden" name="StrProductId" value="${item.product.product_id}"/>
                                    <input type="hidden" name="StrColor" value="${item.variant.color}"/>
                                    <input type="hidden" name="StrSize" value="${item.variant.size}"/>
                                    <input type="hidden" name="StrQuantity" value="${item.quantity}"/>
                                    <input type="hidden" name="StrCartItemId" value="${item.cart_item_id}"/>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Tổng tiền -->
                        <div class="cart-summary">
                            Tổng cộng: <span id="cart-total">0₫</span>
                        </div>

                        <!-- Nút thanh toán -->
                        <div class="text-end mt-3">
                            <button type="submit" class="btn btn-success">Thanh toán</button>
                        </div>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/common/footer.jsp"/>
<jsp:include page="/common/popup.jsp"/>

<script>
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

    const checkboxes = document.querySelectorAll('.checkout-checkbox');
    checkboxes.forEach(cb => cb.addEventListener('change', updateCartTotal));
    updateCartTotal();

    document.getElementById('checkout-form').addEventListener('submit', function (e) {
        checkboxes.forEach((checkbox) => {
            const index = checkbox.dataset.index;
            const hiddenInputs = document.getElementById('hidden-' + index);
            if (!checkbox.checked && hiddenInputs) {
                hiddenInputs.remove();
            }
        });
    });
</script>

</body>
</html>
