<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
</head>
<body>
    <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">Quay lại danh sách sản phẩm</a>
    <h2>Update Product</h2>

    <form action="MainController" method="post">
        <input type="hidden" name="action" value="updateProduct" />
        <input type="hidden" name="StrProductId" value="${product.product_id}" />

        <label for="StrProductName">Product Name:</label><br>
        <input type="text" id="StrProductName" name="StrProductName" value="${product.product_name}" required><br><br>

        <label for="StrDescription">Description:</label><br>
        <textarea id="StrDescription" name="StrDescription" rows="4" cols="50">${product.description}</textarea><br><br>

        <label for="StrPrice">Price:</label><br>
        <input type="number" step="0.01" id="StrPrice" name="StrPrice" value="${product.price}" required><br><br>

        <label for="StrImgUrl">Image URL:</label><br>
        <input type="text" id="StrImgUrl" name="StrImgUrl" value="${product.img_url}"><br><br>

        <label for="StrCategoryId">Category:</label><br>
        <select name="StrCategoryId" id="StrCategoryId" required>
            <option value="">-- Select Category --</option>
            <c:forEach var="c" items="${listC}">
                <option value="${c.category_id}" <c:if test="${c.category_id == product.category_id}">selected</c:if>>${c.category_name}</option>
            </c:forEach>
        </select><br><br>

        <label for="StrBrandId">Brand:</label><br>
        <select name="StrBrandId" id="StrBrandId" required>
            <option value="">-- Select Brand --</option>
            <c:forEach var="b" items="${listB}">
                <option value="${b.brand_id}" <c:if test="${b.brand_id == product.brand_id}">selected</c:if>>${b.brand_name}</option>
            </c:forEach>
        </select><br><br>

        <label for="StrStatus">Status:</label>
        <input type="checkbox" id="StrStatus" name="StrStatus" <c:if test="${product.status eq 'Active'}">checked</c:if>> Active<br><br>

        <input type="submit" value="Update Product">
    </form>
</body>
</html>