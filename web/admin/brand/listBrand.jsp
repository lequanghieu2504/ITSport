<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách Brand</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>

        <style>
            :root {
                --wine-red: #800020;
                --wine-dark: #5a0c1a;
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

            h1, h3 {
                color: var(--wine-red);
                text-align: center;
                margin-bottom: 20px;
            }

            /* ✅ Box thêm brand mới */
            .add-brand-form {
                background: var(--card-bg);
                border: 2px dashed var(--wine-red);
                padding: 20px;
                margin-bottom: 30px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }

            label {
                display: block;
                margin: 8px 0 4px;
            }

            input[type="text"],
            input[type="file"] {
                width: 100%;
                padding: 10px 12px;
                margin-bottom: 15px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                background: #2a2a2a;
                color: var(--text-color);
            }

            button {
                background-color: var(--wine-red);
                color: white;
                padding: 10px 16px;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            button:hover {
                background-color: var(--wine-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.4);
            }

            /* Mỗi brand item */
            .brand {
                background-color: var(--card-bg);
                border: 1px solid var(--border-color);
                padding: 15px 20px;
                border-radius: 10px;
                margin-bottom: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.25);
            }

            .brand h3 {
                color: var(--text-color);
                font-size: 20px;
                margin-bottom: 10px;
            }

            .brand img {
                border-radius: 8px;
                border: 2px solid var(--border-color);
                margin-top: 8px;
            }

            /* Sidebar chỉnh nhẹ */
            .sidebar {
                background-color: #1a1a1a;
                color: #ddd;
            }

            .sidebar a {
                color: #eee;
                padding: 10px 20px;
                display: block;
                text-decoration: none;
            }

            .sidebar a:hover {
                background-color: var(--wine-red);
                color: white;
            }

        </style>
    </head>
    <body>
        <!-- Form thêm Brand mới -->
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

        <!-- Danh sách Brand -->
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
