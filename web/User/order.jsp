<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        .profile-page {
            background: #f4f4f4;
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            padding: 100px 20px;
        }

        .profile-page .profile-container {
            max-width: 800px;
            background: #fff;
            margin: 0 auto 40px auto;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            padding: 40px;
        }

        .profile-page .profile-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 15px;
        }

        .profile-page .profile-header-left {
            display: flex;
            align-items: center;
        }

        .profile-page .profile-header i {
            font-size: 2rem;
            color: #8B0000;
            margin-right: 15px;
        }

        .profile-page .profile-header h2 {
            font-size: 1.8rem;
            margin: 0;
            color: #333;
        }

        .profile-page .profile-info {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-page .info-item {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px 20px;
            background: #fafafa;
            transition: box-shadow 0.2s ease;
        }

        .profile-page .info-item:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .profile-page .info-item i {
            color: #8B0000;
            margin-right: 15px;
            font-size: 1.2rem;
            min-width: 20px;
            text-align: center;
        }

        .profile-page .info-item span {
            font-size: 1rem;
            color: #555;
        }

        .profile-page .product-img {
            width: 80px;
            height: auto;
            margin-right: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
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

    <!-- Danh sách đơn hàng -->
    <c:if test="${not empty userOrders}">
        <c:set var="prevId" value="0"/>
        <c:set var="isOpen" value="false"/>

        <c:forEach var="order" items="${userOrders}" varStatus="loop">
            <c:if test="${order.buyingId != prevId}">
                <!-- Nếu đang mở thẻ thì đóng -->
                <c:if test="${isOpen}">
                    <div class="info-item">
                        <i class="fa fa-map-marker-alt"></i>
                        <span>
                            <strong>Giao tới:</strong> ${order.shippingStreet}, ${order.shippingWard}, ${order.shippingDistrict}, ${order.shippingProvince} | ĐT: ${order.shippingPhone}
                        </span>
                    </div>
                </div> <!-- profile-info -->
                </div> <!-- profile-container -->
                </c:if>

                <!-- Mở thẻ mới -->
                <div class="profile-container">
                    <div class="profile-header">
                        <div class="profile-header-left">
                            <i class="fa fa-shopping-bag"></i>
                            <h2>Đơn hàng #${order.buyingId} - ${order.status}</h2>
                        </div>

                        <!-- Nút Xác nhận -->
                        <c:if test="${order.status == 'PENDING'}">
                            <form method="post" action="MainController">
                                <input type="hidden" name="buyingId" value="${order.buyingId}"/>
                                <input type="hidden" name="action" value="CancelOrderStatuByUser"/>
                                <button type="submit" class="btn btn-sm btn-primary">
                                    Hủy Đơn Hàng
                                </button>
                                
                            </form>
                        </c:if>
                    </div>

                    <div class="profile-info">
                        <div class="info-item">
                            <i class="fa fa-calendar"></i>
                            <span>Ngày đặt: ${order.createdAt} | Tổng: ${order.totalPrice}đ</span>
                        </div>
                <c:set var="isOpen" value="true"/>
            </c:if>

            <!-- Thông tin sản phẩm -->
            <div class="info-item">
                <img src="${pageContext.request.contextPath}${order.image_url}" alt="${order.sku}" class="product-img"/>
                <span>
                    <strong>SKU:</strong> ${order.sku} | Size: ${order.size} | Màu: ${order.color}<br/>
                    Số lượng: ${order.quantity} | Giá: ${order.priceEach}đ
                </span>
            </div>

            <!-- Nếu là dòng cuối thì đóng -->
            <c:if test="${loop.last}">
                <div class="info-item">
                    <i class="fa fa-map-marker-alt"></i>
                    <span>
                        <strong>Giao tới:</strong> ${order.shippingStreet}, ${order.shippingWard}, ${order.shippingDistrict}, ${order.shippingProvince} | ĐT: ${order.shippingPhone}
                    </span>
                </div>
                </div> <!-- profile-info -->
                </div> <!-- profile-container -->
            </c:if>

            <c:set var="prevId" value="${order.buyingId}"/>
        </c:forEach>
    </c:if>

</div>

<jsp:include page="/common/footer.jsp"/>

</body>
</html>
