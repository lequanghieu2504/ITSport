<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Brand</title>

    <!-- Bootstrap CSS + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">


    <style>
        @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;600;700&display=swap');

        :root {
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --text-white: #f0f0f0;
            --accent-red-start: #b30000;
            --accent-red-end:   #800000;
            --radius: 8px;
            --shadow: rgba(0,0,0,0.7);
        }

        * { box-sizing: border-box; margin:0; padding:0; }
        body {
            background: var(--dark-bg);
            color: var(--text-white);
            font-family: 'Oswald', sans-serif;
            padding: 40px;
        }
        a { color: var(--accent-red-start); text-decoration: none; transition: color .2s; }
        a:hover { color: var(--accent-red-end); }

        h1 {
            color: var(--text-white);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5rem;
            font-weight: 700;
        }

        .add-brand-form {
            background: var(--card-bg);
            border: 2px dashed var(--accent-red-start);
            padding: 20px;
            margin-bottom: 30px;
            border-radius: var(--radius);
            box-shadow: 0 5px 15px var(--shadow);
        }
        .add-brand-form h3 {
            margin-bottom: 1rem;
            color: var(--accent-red-start);
            font-weight: 600;
        }
        .add-brand-form label {
            display: block;
            margin: 8px 0 4px;
            color: var(--text-white);
            font-weight: 500;
        }
        .add-brand-form input[type="text"],
        .add-brand-form input[type="file"] {
            width: 100%;
            padding: 8px 12px;
            margin-bottom: 10px;
            border: 2px solid var(--text-white);
            border-radius: var(--radius);
            background: #2a2a2a;
            color: var(--text-white);
            font-size: 1rem;
        }
        .add-brand-form button {
            background: var(--accent-red-start);
            color: #fff;
            border: none;
            padding: 10px 18px;
            border-radius: var(--radius);
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .add-brand-form button:hover {
            background: var(--accent-red-end);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px var(--shadow);
        }


        .brand {
            background: var(--card-bg);
            border: 1px solid #333;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: var(--radius);
            box-shadow: 0 5px 15px var(--shadow);
        }
        .brand h3 {
            margin-bottom: .75rem;
            color: var(--accent-red-start);
            font-weight: 600;
        }
        .brand img {
            border-radius: var(--radius);
            border: 2px solid #333;
            margin-bottom: 1rem;
        }
        .brand form {
            margin-top: 10px;
        }
        .brand button {
            background: var(--accent-red-start);
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: var(--radius);
            cursor: pointer;
            font-weight: 600;
            transition: background .2s, transform .2s;
        }
        .brand button:hover {
            background: var(--accent-red-end);
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

    <h1>Danh sách Brand</h1>

    <!-- Form thêm Brand mới -->
    <div class="add-brand-form">
        <h3><i class="bi bi-plus-circle"></i> Thêm Brand Mới</h3>
        <form action="MainController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="addBrand">

            <label for="brandName">Tên Brand:</label>
            <input type="text" id="brandName" name="brandName" required>

            <label for="brandImage">Hình Ảnh (tùy chọn):</label>
            <input type="file" id="brandImage" name="brandImage" accept="image/*">

            <button type="submit"><i class="bi bi-check-circle"></i> Tạo Brand</button>
        </form>
    </div>

    <!-- Danh sách Brand -->
    <c:forEach var="brand" items="${brandList}">
        <div class="brand">
            <h3>${brand.brand_name}</h3>

            <c:if test="${not empty brand.image_url}">
                <img src="${pageContext.request.contextPath}/${brand.image_url}" alt="Brand Image" width="120">
            </c:if>

            <!-- Form thêm hình ảnh -->
            <form action="MainController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="uploadBrandImage">
                <input type="hidden" name="brandId" value="${brand.brand_id}">
                <input type="file" name="brandImage" accept="image/*" required>
                <button type="submit"><i class="bi bi-upload"></i> Thêm ảnh</button>
            </form>


            <!-- Form xóa hình ảnh -->
            <c:if test="${not empty brand.image_url}">
                <form action="MainController" method="post" style="margin-top:5px;">
                    <input type="hidden" name="action" value="deleteBrandImage">
                    <input type="hidden" name="brandId" value="${brand.brand_id}">
                    <input type="hidden" name="imageId" value="${brand.image_id}">
                    <button type="submit" onclick="return confirm('Bạn có chắc muốn xóa ảnh này không?');">
                        <i class="bi bi-trash"></i> Xóa ảnh
                    </button>
                </form>
            </c:if>
        </div>
    </c:forEach>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
