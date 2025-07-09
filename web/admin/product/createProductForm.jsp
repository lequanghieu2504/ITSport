<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Create Product</title>
    </head>
    <body>
        <h2>Create New Product</h2>

        <form action="MainController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="insertProduct" />

            <label for="StrProductName">Product Name:</label><br>
            <input type="text" id="StrProductName" name="StrProductName" required><br><br>

            <label for="StrDescription">Description:</label><br>
            <textarea id="StrDescription" name="StrDescription" rows="4" cols="50"></textarea><br><br>

            <label for="StrPrice">Price:</label><br>
            <input type="number" step="0.01" id="StrPrice" name="StrPrice" required><br><br>

            <!-- ✅ Upload ảnh đại diện -->
            <label for="MainImage">Main Product Image:</label><br>
            <input type="file" id="MainImage" name="MainImage" accept="image/*" required><br><br>

            <label for="StrCategoryId">Category:</label><br>
            <select name="StrCategoryId" id="StrCategoryId" required>
                <option value="">-- Select Category --</option>
                <c:forEach var="c" items="${listC}">
                    <option value="${c.category_id}">${c.category_name}</option>
                </c:forEach>
            </select><br><br>

            <label for="StrBrandId">Brand:</label><br>
            <select name="StrBrandId" id="StrBrandId" required>
                <option value="">-- Select Brand --</option>
                <c:forEach var="b" items="${listB}">
                    <option value="${b.brand_id}">${b.brand_name}</option>
                </c:forEach>
            </select><br><br>

            <label for="StrStatus">Status:</label>
            <input type="checkbox" id="StrStatus" name="StrStatus" checked> Active<br><br>

            <input type="submit" value="Create Product">
        </form>

        <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">
            &larr; Quay lại danh sách
        </a>
    </body>
</html>
