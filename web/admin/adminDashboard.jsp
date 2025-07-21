<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin Dashboard</title>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #8B0000;
                --bg-color: #121212;
                --sidebar-bg: #1c1c1c;
                --content-bg: #181818;
                --text-color: #f0f0f0;
                --muted-text: #aaa;
                --hover-bg: #292929;
                --shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
            }

            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: 'Roboto', sans-serif;
                background: var(--bg-color);
                color: var(--text-color);
            }

            body {
                display: flex;
                min-height: 100vh;
            }

            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 220px;
                height: 100%;
                background: var(--sidebar-bg);
                padding: 20px;
                box-sizing: border-box;
                box-shadow: var(--shadow);
            }

            .sidebar h3 {
                color: var(--primary-color);
                margin-bottom: 1.5rem;
                font-weight: 700;
            }

            .sidebar a {
                display: block;
                text-decoration: none;
                color: var(--text-color);
                padding: 10px;
                margin-bottom: 8px;
                border-radius: 4px;
                transition: background 0.3s;
            }

            .sidebar a:hover {
                background: var(--hover-bg);
            }

            .content {
                margin-left: 220px;
                padding: 30px;
                background: var(--content-bg);
                flex: 1;
                min-height: 100vh;
                box-sizing: border-box;
            }

            h2 {
                color: var(--primary-color);
            }

            p {
                color: var(--muted-text);
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 180px;
                }
                .content {
                    margin-left: 180px;
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <h3>Admin Menu</h3>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForHomePage">Homepage</a>
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
                    <h2>Welcome to the Admin Dashboard</h2>
                    <p>Select a section from the menu.</p>
                </c:otherwise>
            </c:choose>
        </div>

    </body>
</html>
