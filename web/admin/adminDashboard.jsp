<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <style>
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: Arial, sans-serif;
            }

            body {
                display: flex;
                min-height: 100vh;  /* Luôn cao ít nh?t b?ng viewport */
            }

            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                color: white;
                flex-shrink: 0; /* Không co l?i */
                padding: 20px;
                box-sizing: border-box;
            }

            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px;
                margin-bottom: 5px;
            }

            .sidebar a:hover {
                background-color: #34495e;
            }

            .content {
                flex: 1; /* Fill ph?n còn l?i */
                padding: 20px;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                min-height: 100vh;  /* Luôn full cao nh? sidebar */
            }
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 220px;
                height: 100%;
                background-color: #2c3e50;
                color: white;
                padding: 20px;
            }

            .content {
                margin-left: 220px; /* d?ch n?i dung sang ph?i, tránh ?è sidebar */
                padding: 20px;
            }
            body {
                display: flex;
                min-height: 100vh; /* ??m b?o body cao ít nh?t 100% viewport */
                margin: 0;
            }

            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                color: white;
                padding: 20px;
            }

            .content {
                flex: 1;
                padding: 20px;
            }


        </style>
    </head>
    <body>

        <div class="sidebar">
            <h3>Admin Menu</h3>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForRevenue">Revenue</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">Product</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListBuying">Booking</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListCategory">Category</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListBrand">Brand</a>
        </div>

        <div class="content">
            <c:choose>
                <c:when test="${section == 'product'}">
                    <jsp:include page="product/listProduct.jsp" />
                </c:when>
                <c:when test="${section == 'createProduct'}">
                    <jsp:include page="product/createProductForm.jsp"/>
                </c:when>
                <c:when test="${section == 'editProduct'}">
                    <jsp:include page="product/UpdateProductForm.jsp"/>   
                </c:when>
                <c:when test="${section == 'createVariant'}">
                    <jsp:include page="product/ProductVariantForm.jsp"/>
                </c:when>
                <c:when test="${section == 'viewDetailProduct'}">
                    <jsp:include page="product/ProductDetail.jsp"/>
                </c:when>
                <c:when test="${section == 'CreateDetailProduct'}">
                    <jsp:include page="product/createProductForm.jsp"/>
                </c:when>
                <c:when test="${section == 'listBuyings'}">
                    <jsp:include page="Buying/BuyingManager.jsp"/>
                </c:when>
                <c:when test="${section == 'detailBuying'}">
                    <jsp:include page="Buying/detailProductVariant.jsp"/>
                </c:when>
                <c:when test="${section == 'listCategory'}">
                    <jsp:include page="category/listCategory.jsp"/>
                </c:when>
                <c:when test="${section == 'listBrand'}">
                    <jsp:include page="brand/listBrand.jsp"/>
                </c:when>

                <c:when test="${section == 'revenue'}">
                    <jsp:include page="revenue/revenueManager.jsp"/>

                </c:when>
                <c:otherwise>
                    <h2>Welcome to the Admin Dashboard</h2>
                    <p>Select a section from the menu.</p>
                </c:otherwise>
            </c:choose>

        </div>

    </body>
</html>
