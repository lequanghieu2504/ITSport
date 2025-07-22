<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin Dashboard</title>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {
    --brand-primary: #00e676;       /* Neon green accent */
    --brand-secondary: #121212;     /* Deep dark background */
    --brand-tertiary: #212121;      /* Slightly lighter dark */
    --text-primary: #f5f5f5;        /* Main text */
    --text-secondary: #b0bec5;      /* Secondary text */
    --radius: 6px;                  /* Border radius */
    --transition: 0.25s ease;       /* Global transition */
    --shadow: 0 2px 8px rgba(0,0,0,0.7);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Roboto', sans-serif;
    background: var(--brand-secondary);
    color: var(--text-primary);
    display: flex;
    min-height: 100vh;
}

/* Sidebar */
.sidebar {
    width: 240px;
    background: var(--brand-tertiary) url('/static/img/mesh-pattern.png') center/auto repeat;
    color: var(--text-primary);
    padding: 2rem 1rem;
    position: fixed;
    top: 0; left: 0; bottom: 0;
    box-shadow: 2px 0 6px rgba(0,0,0,0.8);
}

.sidebar h3 {
    font-size: 1.8rem;
    text-transform: uppercase;
    text-align: center;
    margin-bottom: 2rem;
    letter-spacing: 2px;
}

.sidebar a {
    display: block;
    padding: 0.8rem 1.2rem;
    margin-bottom: 1rem;
    color: var(--text-secondary);
    text-decoration: none;
    border-radius: var(--radius);
    transition: background var(--transition), color var(--transition);
}
.sidebar a:hover,
.sidebar a.active {
    background: var(--brand-primary);
    color: var(--brand-secondary);
}

/* Main content */
.content {
    margin-left: 240px;
    padding: 2rem;
    flex: 1;
    background: var(--brand-secondary);
    background-image:
      linear-gradient(135deg, rgba(0,0,0,0.2) 25%, transparent 25%),
      linear-gradient(225deg, rgba(0,0,0,0.2) 25%, transparent 25%);
    background-size: 40px 40px;
}

.content h2 {
    font-size: 2rem;
    color: var(--brand-primary);
    margin-bottom: 1.5rem;
    text-transform: uppercase;
}

/* Cards */
.content .card {
    background: var(--brand-tertiary);
    padding: 1.5rem;
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    margin-bottom: 2rem;
    transition: transform var(--transition), box-shadow var(--transition);
}
.content .card:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.9);
}
.content .card h3 {
    margin: 0 0 1rem;
    color: var(--brand-primary);
    font-size: 1.4rem;
    position: relative;
}
.content .card h3::after {
    content: '';
    display: block;
    width: 50px;
    height: 3px;
    background: var(--brand-primary);
    margin-top: 0.5rem;
}

/* Tables within dashboard */
.content table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1rem;
}
.content table thead {
    background: var(--brand-tertiary);
}
.content table thead th {
    padding: 0.8rem 1rem;
    color: var(--text-primary);
    font-weight: 600;
    border-bottom: 2px solid var(--brand-primary);
    text-transform: uppercase;
    font-size: 0.85rem;
}
.content table tbody tr {
    border-bottom: 1px solid rgba(255,255,255,0.1);
    transition: background var(--transition);
}
.content table tbody tr:hover {
    background: rgba(0,0,0,0.3);
}
.content table td {
    padding: 0.8rem 1rem;
    color: var(--text-secondary);
}

/* Responsive */
@media (max-width: 768px) {
    .sidebar { width: 200px; }
    .content { margin-left: 200px; padding: 1rem; }
    .sidebar h3 { font-size: 1.5rem; }
    .content h2 { font-size: 1.6rem; }
}

        </style>
    </head>
    <body>

        <div class="sidebar">

            <h3 style="margin-bottom: 20px; size: 50px">Admin Menu</h3>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForHomePage">HomePage</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForRevenue">Revenue</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">Product</a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListBuying">Order</a>
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
