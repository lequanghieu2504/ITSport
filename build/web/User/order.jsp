<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Hồ sơ cá nhân | ITSPORT</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          crossorigin="anonymous">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css"/>

    <style>
        body {
            background: #f8f9fa;
            font-family: 'Roboto', sans-serif;
        }

        .profile-page {
            padding: 100px 20px;
        }

        .profile-container {
            max-width: 900px;
            background: #fff;
            margin: 0 auto 40px auto;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 40px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            border-bottom: 2px solid #dc3545;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }

        .profile-header i {
            font-size: 2rem;
            color: #dc3545;
            margin-right: 15px;
        }

        .profile-header h2 {
            font-size: 1.8rem;
            margin: 0;
            color: #333;
        }

        .profile-info {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            background: #fdfdfd;
            border: 1px solid #eee;
            border-left: 5px solid #dc3545;
            border-radius: 10px;
            padding: 15px 20px;
            transition: all 0.2s ease;
        }

        .info-item:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .info-item i {
            color: #dc3545;
            margin-right: 15px;
            font-size: 1.4rem;
            min-width: 24px;
            text-align: center;
        }

        .info-item span {
            font-size: 1rem;
            color: #333;
        }

        .product-img {
            width: 80px;
            height: auto;
            margin-right: 20px;
            border-radius: 10px;
            border: 1px solid #ddd;
        }

        .info-item strong {
            color: #212529;
        }

    </style>

    <!-- jQuery + Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
    crossorigin="anonymous"></script>
</head>

<body>

<jsp:include page="/common/header.jsp"/>

<div class="profile-page">

    <!-- ✅ Nếu KHÔNG có đơn hàng -->
    <c:if test="${empty userOrders}">
        <div class="profile-container text-center">
            <div class="profile-header justify-content-center">
                <i class="fa fa-box-open"></i>
                <h2>Bạn chưa có đơn hàng nào!</h2>
            </div>
            <p>Hãy tiếp tục mua sắm để sở hữu những sản phẩm yêu thích nhé!</p>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForHomePage" class="btn btn-danger">
                Tiếp tục mua sắm
            </a>
        </div>
    </c:if>

    <!-- Nếu CÓ đơn hàng -->
    <c:if test="${not empty userOrders}">
        <!-- Tổng quan -->
        <div class="profile-container">
            <div class="profile-header">
                <i class="fa fa-history"></i>
                <h2>Lịch sử mua hàng</h2>
            </div>
            <div class="profile-info">
                <div class="info-item">
                    <i class="fa fa-list"></i>
                    <span>Bạn có <strong><c:out value="${fn:length(userOrders)}"/></strong> sản phẩm đã mua.</span>
                </div>
            </div>
        </div>

        <!-- PENDING -->
        <div class="profile-container">
            <div class="profile-header">
                <i class="fa fa-clock"></i>
                <h2>Đơn hàng chờ xác nhận</h2>
            </div>
            <div class="profile-info">
                <c:forEach var="order" items="${userOrders}">
                    <c:if test="${order.status == 'PENDING'}">
                        <div class="info-item">
                            <i class="fa fa-shopping-bag"></i>
                            <span>Đơn hàng #${order.buyingId} | Tổng: ${order.totalPrice}đ | Ngày: ${order.createdAt}</span>
                        </div>
                        <div class="info-item">
                            <img src="${pageContext.request.contextPath}${order.image_url}" class="product-img"/>
                            <span><strong>SKU:</strong> ${order.sku} | Size: ${order.size} | Màu: ${order.color} | SL: ${order.quantity} | Giá: ${order.priceEach}đ</span>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- CONFIRMED / SHIPPING -->
        <div class="profile-container">
            <div class="profile-header">
                <i class="fa fa-truck"></i>
                <h2>Đơn hàng đã xác nhận / Đang giao</h2>
            </div>
            <div class="profile-info">
                <c:forEach var="order" items="${userOrders}">
                    <c:if test="${order.status == 'CONFIRM' || order.status == 'SHIPPING'}">
                        <div class="info-item">
                            <i class="fa fa-shopping-bag"></i>
                            <span>Đơn hàng #${order.buyingId} | Tổng: ${order.totalPrice}đ | Ngày: ${order.createdAt}</span>
                        </div>
                        <div class="info-item">
                            <img src="${pageContext.request.contextPath}${order.image_url}" class="product-img"/>
                            <span><strong>SKU:</strong> ${order.sku} | Size: ${order.size} | Màu: ${order.color} | SL: ${order.quantity} | Giá: ${order.priceEach}đ</span>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- SUCCESS -->
        <div class="profile-container">
            <div class="profile-header">
                <i class="fa fa-check-circle"></i>
                <h2>Đơn hàng đã giao thành công</h2>
            </div>
            <div class="profile-info">
                <c:forEach var="order" items="${userOrders}">
                    <c:if test="${order.status == 'DONE'}">
                        <div class="info-item">
                            <i class="fa fa-shopping-bag"></i>
                            <span>Đơn hàng #${order.buyingId} | Tổng: ${order.totalPrice}đ | Ngày: ${order.createdAt}</span>
                        </div>
                        <div class="info-item">
                            <img src="${pageContext.request.contextPath}${order.image_url}" class="product-img"/>
                            <span><strong>SKU:</strong> ${order.sku} | Size: ${order.size} | Màu: ${order.color} | SL: ${order.quantity} | Giá: ${order.priceEach}đ</span>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>

</div>

<jsp:include page="/common/footer.jsp"/>

</body>
</html>