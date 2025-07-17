<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách Brand</title>
        <style>
            .brand {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 10px;
            }
            .add-brand-form {
                border: 2px dashed #2c3e50;
                padding: 15px;
                margin-bottom: 20px;
                background: #f9f9f9;
            }
        </style>
    </head>
    <body>

        <h1>Danh sách Brand</h1>

        <!-- ✅ Form thêm Brand mới -->
        <div class="add-brand-form">
            <h3>Thêm Brand Mới</h3>
            <form action="MainController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addBrand">

                <label for="brandName">Tên Brand:</label><br>
                <input type="text" id="brandName" name="brandName" required><br><br>

                <label for="brandImage">Hình Ảnh (tùy chọn):</label><br>
                <input type="file" id="brandImage" name="brandImage" accept="image/*"><br><br>

                <button type="submit">Tạo Brand</button>
            </form>
        </div>

        <!-- ✅ Danh sách Brand -->
        <c:forEach var="brand" items="${brandList}">
            <div class="brand">
                <h3>${brand.brand_name}</h3>

                <c:if test="${not empty brand.image_url}">
                    <img src="${pageContext.request.contextPath}/${brand.image_url}" alt="Brand Image" width="100">
                </c:if>

                <!-- Form thêm hình ảnh -->
                <form action="MainController" method="post" enctype="multipart/form-data" style="margin-top: 10px;">
                    <input type="hidden" name="action" value="uploadBrandImage">
                    <input type="hidden" name="brandId" value="${brand.brand_id}" />
                    <input type="file" name="brandImage" accept="image/*" required />
                    <button type="submit">Thêm hình ảnh</button>
                </form>

                <!-- Form xoá hình ảnh -->
                <c:if test="${not empty brand.image_url}">
                    <form action="MainController" method="post" style="margin-top: 5px;">
                        <input type="hidden" name="action" value="deleteBrandImage">
                        <input type="hidden" name="brandId" value="${brand.brand_id}" />
                        <input type="hidden" name="imageId" value="${brand.image_id}" />
                        <button type="submit" onclick="return confirm('Bạn có chắc muốn xoá hình ảnh này không?');">Xoá hình ảnh</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>

    </body>
</html>
