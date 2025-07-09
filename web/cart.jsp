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
        <div class="page-wrapper d-flex flex-column min-vh-100">
            <jsp:include page="/common/header.jsp"/>

            <main class="flex-grow-1">
                <div class="container-xl py-5">
                    <h2 class="cart-title">GIỎ HÀNG CỦA BẠN</h2>

                    <c:choose>
                        <c:when test="${empty sessionScope.cartItems}">
                            <p class="empty-message">Giỏ hàng của bạn đang trống.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="cart-container">
                                <c:forEach var="item" items="${sessionScope.cartItems}">
                                    <div class="cart-item row align-items-center">
                                        <div class="col-md-2">
                                            <img class="product-img img-fluid" src="assets/images/${item.product.image}" alt="${item.product.name}"/>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="product-name">${item.product.name}</div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="product-price">${item.product.price}₫</div>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="number" class="form-control quantity-input" name="quantity" value="${item.quantity}" min="1"/>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <form action="removeFromCart" method="post">
                                                <input type="hidden" name="productId" value="${item.product.id}"/>
                                                <button class="btn btn-outline-secondary btn-sm">
                                                    <i class="fas fa-trash"></i> Xóa
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>

                                <div class="cart-summary">
                                    Tổng cộng: <span>${sessionScope.cartTotal}₫</span>
                                </div>
                                <div class="text-end mt-3">
                                    <a href="checkout" class="btn btn-success">Thanh toán</a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <jsp:include page="/common/footer.jsp"/>
        </div>
    </body>
</html>
