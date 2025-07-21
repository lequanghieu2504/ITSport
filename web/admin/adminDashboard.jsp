<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin Dashboard</title>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {

                --wine-red: #800020;
                --wine-dark: #5a0016;
                --white: #ffffff;
                --light-gray: #f4f4f4;
                --text-dark: #2c2c2c;
                --radius: 10px;
                --shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--light-gray);
                color: var(--text-dark);
                display: flex;
                min-height: 100vh;
            }

            .sidebar {

                width: 220px;
                background-color: var(--wine-red);
                color: var(--white);
                padding: 20px;
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                box-shadow: var(--shadow);
            }

            .sidebar h3 {

                margin-top: 0;
                font-size: 22px;
                text-align: center;
                margin-bottom: 30px;
            }

            .sidebar a {
                color: var(--white);
                text-decoration: none;
                display: block;
                padding: 12px 15px;
                border-radius: var(--radius);
                margin-bottom: 10px;
                transition: var(--transition);
            }

            .sidebar a:hover {
                background-color: var(--wine-dark);
            }

            .content {
                margin-left: 220px;
                padding: 40px 50px;
                width: calc(100% - 220px);
                background-color: #fdfdfd;
            }

            .content h2 {
                font-size: 28px;
                color: #2c2c2c;
                margin-bottom: 25px;
            }

            .card {
                background-color: var(--white);
                border-radius: var(--radius);
                box-shadow: var(--shadow);
                padding: 25px 30px;
                margin-bottom: 30px;
                transition: var(--transition);
            }

            .card h3 {
                margin-top: 0;
                margin-bottom: 20px;
                font-size: 20px;
                color: var(--wine-red);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 16px;
            }

            table thead {
                background-color: #f2f2f2;
                font-weight: bold;
            }

            table th, table td {
                padding: 12px 16px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            table td {
                color: #333;
            }

            @media screen and (max-width: 768px) {
                .content {
                    margin-left: 0;
                    padding: 20px;
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <div class="sidebar">

            <h3 style="margin-bottom: 20px; size: 50px">Admin Menu</h3>
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
                    <jsp:include page="product/CreateProductVariantForm.jsp"/>
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
                    <div class="card">
                        <h2>Welcome to the Admin Dashboard</h2>
                        <p>Select a section from the menu.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
