<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
            }
            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                color: white;
                height: 100vh;
                padding: 20px;
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
                flex: 1;
                padding: 20px;
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <h3>Admin Menu</h3>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">Product</a>
            <a href="adminDashBoard.jsp?section=revenue">Revenue</a>
        </div>

        <div class="content">
            <c:choose>
                <c:when test="${section == 'product'}">
                    <jsp:include page="product/listProduct.jsp" />
                </c:when>
                <c:when test="${section == 'revenue'}">
                    <h2>Revenue (Coming soon)</h2>
                </c:when>
                <c:when test="${section == 'createProduct'}">
                    <jsp:include page="product/createProductForm.jsp" />
                </c:when>

                <c:otherwise>
                    <h2>Welcome to the Admin Dashboard</h2>
                    <p>Select a section from the menu.</p>
                </c:otherwise>
            </c:choose>

        </div>

    </body>
</html>
