<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách Brand</title>
        <style>
            :root {
                --primary-color: #4e73df;
                --success-color: #1cc88a;
                --danger-color: #e74a3b;
                --dark-bg: #121212;
                --card-bg: #1e1e1e;
                --text-color: #f0f0f0;
                --border-color: #333;
            }

            body {
                background: var(--dark-bg);
                color: var(--text-color);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                padding: 40px;
            }

            h1 {
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 30px;
            }

            .brand {
                background: var(--card-bg);
                border: 1px solid var(--border-color);
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }

            .brand img {
                border-radius: 8px;
                border: 2px solid var(--border-color);
            }

            .add-brand-form {
                background: var(--card-bg);
                border: 2px dashed var(--primary-color);
                padding: 20px;
                margin-bottom: 30px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }

            label {
                display: block;
                margin: 8px 0 4px;
            }

            input[type="text"],
            input[type="file"] {
                width: 100%;
                padding: 8px 12px;
                margin-bottom: 10px;
                border: 2px solid var(--border-color);
                border-radius: 6px;
                background: #2a2a2a;
                color: var(--text-color);
            }

            button {
                background: var(--primary-color);
                color: #fff;
                border: none;
                padding: 10px 18px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            button:hover {
                background: #224abe;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.4);
            }

            form {
                margin-top: 10px;
            }
        </style>

    </head>
    <body>


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
