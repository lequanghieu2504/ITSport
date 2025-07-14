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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css"/>
    </head>
    <body>
        <jsp:include page="/common/header.jsp"/>
        <div class="page-wrapper d-flex flex-column min-vh-100">

            <main class="flex-grow-1">
                <div class="container-xl py-5">
                    <h2 class="cart-title">GIỎ HÀNG CỦA BẠN</h2>

                    <c:choose>
                        <c:when test="${empty listCartItem}">
                            <p class="empty-message">Giỏ hàng của bạn đang trống.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="cart-container">
                                <c:forEach var="item" items="${listCartItem}">
                                    <c:set var="cartTotal" value="${cartTotal + (item.quantity * item.product.price)}"/>
                                    <div class="cart-item row align-items-center">
                                        <!--                                         Hình ảnh 
                                                                                <div class="col-md-2">
                                                                                    <img class="product-img img-fluid" src="assets/images/${item.product}" alt="${item.product.product_name}"/>
                                                                                </div>-->

                                        <!-- Tên sản phẩm và biến thể -->
                                        <div class="col-md-4">
                                            <div class="product-name">${item.product.product_name}</div>
                                            <c:if test="${not empty item.variant}">
                                                <div class="text-muted small">
                                                    Size: ${item.variant.size} |
                                                    Màu: ${item.variant.color}
                                                </div>
                                            </c:if>
                                        </div>

                                        <!-- Giá -->
                                        <div class="col-md-2">
                                            <div class="product-price">${item.product.price}₫</div>
                                        </div>

                                        <!-- Số lượng -->
                                        <div class="col-md-2">
                                            <input type="number" class="form-control quantity-input" name="quantity" value="${item.quantity}" min="1"/>
                                        </div>

                                        <!-- Xóa -->
                                        <div class="col-md-2 text-end">
                                            <form action="MainController" method="post">
                                                <input type="hidden" name="action" value="removeFromCart"/>
                                                <input type="hidden" name="product_id" value="${item.product.product_id}"/>
                                                <input type="hidden" name="variant_id" value="${item.variant.product_variant_id}"/>
                                                <button class="btn btn-outline-secondary btn-sm">
                                                    <i class="fas fa-trash"></i> Xóa
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Tổng tiền -->
                                <div class="cart-summary">
                                    Tổng cộng: <span>${cartTotal}₫</span>
                                </div>

                                <!-- Thanh toán -->
                                <form action="BuyingController" method="post" class="text-end mt-3">
                                    <input type="hidden" name="action" value="cartCheckout"/>
                                    <c:forEach var="item" items="${listCartItem}">
                                        <input type="hidden" name="StrProductId" value="${item.product.product_id}"/>
                                        <input type="hidden" name="StrColor"     value="${item.variant.color}"/>
                                        <input type="hidden" name="StrSize"      value="${item.variant.size}"/>
                                        <input type="hidden" name="StrQuantity"  value="${item.quantity}"/>
                                    </c:forEach>
                                    <button type="submit" class="btn btn-success">Thanh toán</button>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <jsp:include page="/common/footer.jsp"/>
        </div>
    </body>
</html>
