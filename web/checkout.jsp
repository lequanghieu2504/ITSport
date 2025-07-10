<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
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
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning">
                                        Bạn chưa có địa chỉ giao hàng. 
                                        <a href="MainController?action=addAddress" class="alert-link">Thêm địa chỉ mới</a>
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
    
    <jsp:include page="/common/footer.jsp"/>
</body>
</html>