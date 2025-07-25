<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Sản Phẩm</title>

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;600;700&display=swap');

        :root {
            --bg: #121212;
            --panel: #1e1e1e;
            --text: #ffffff;
            --border: #2e2e2e;
            --primary: #e52b50;  /* đỏ mạnh */
        }

        * { box-sizing: border-box; }
        body {
            margin: 0; padding: 0;
            background: var(--bg);
            color: var(--text);
            font-family: 'Oswald', sans-serif;
            line-height: 1.6;
        }
        .header {
            background: var(--primary);
            padding: 3rem 1rem;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.7);
        }
        .header h1 {
            margin: 0;
            font-size: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--text);
        }
        .header p {
            margin-top: .5rem;
            opacity: .8;
            color: var(--text);
        }
        .container-main {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .card {
            background: var(--panel);
            border: 1px solid var(--border);
            border-radius: .5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.7);
            transition: transform .3s, box-shadow .3s;
            color: #fff;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.7);
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            border-bottom: 2px solid var(--primary);
            padding-bottom: .5rem;
            margin-bottom: 1rem;
            color: var(--text);
            color: #fff;
        }
        .table {
            margin-bottom: 0;
            background: var(--panel);
            color: var(--text);
        }
        .table thead {
            background: var(--bg);
        }
        .table th, .table td {
            border-color: var(--border);
            vertical-align: middle;
            padding: .75rem 1rem;
            color: var(--text);
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background: #1a1a1a;
        }
        .table-striped tbody tr:hover {
            background: #2a2a2a;
        }
        .badge-status {
            text-transform: uppercase;
            font-weight: 600;
            padding: .4em .8em;
            color: var(--text);
        }
        .badge-success { background: #28a745; }
        .badge-secondary { background: #6c757d; }
        .form-control, .form-select {
            background: var(--panel);
            color: var(--text);
            border: 1px solid var(--border);
            border-radius: .25rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: none;
            background: var(--panel);
        }
        .form-label { font-weight: 500; color: var(--text); }
        .btn-primary {
            background: var(--primary);
            border: none;
            text-transform: uppercase;
            font-weight: 600;
            transition: background .3s;
        }
        .btn-primary:hover {
            background: #c41b3a;
        }
        .btn-success {
            background: #17a2b8;
            border: none;
        }
        .btn-success:hover {
            background: #138496;
        }
        .btn-secondary {
            background: #343a40;
            border: none;
        }
        .btn-secondary:hover {
            background: #23272b;
        }
        .delete-btn {
            background: #dc3545;
            border: none;
            color: var(--text);
            transition: transform .2s;
        }
        .delete-btn:hover {
            transform: scale(1.1);
        }
        input[type="file"] { padding: .3rem; color: var(--text); }
        @media (max-width:768px) {
            .header h1 { font-size:2rem; }
        }
    </style>
</head>
<body>

    <div class="container-main">

        <!-- Product Info -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Thông Tin Sản Phẩm</h5>
                <p><strong>ID:</strong> ${product.product_id}</p>
                <p><strong>Tên:</strong> ${product.product_name}</p>
                <p><strong>Mô tả:</strong> ${product.description}</p>
                <p><strong>Giá:</strong> ${product.price} đ</p>
                <p><strong>Trạng thái:</strong>
                    <span class="badge-status ${product.status?'badge-success':'badge-secondary'}">
                        ${product.status?'Hoạt động':'Không hoạt động'}
                    </span>
                </p>
            </div>
        </div>

        <!-- Add Variant Form -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Thêm Biến Thể Mới</h5>
                <form action="${pageContext.request.contextPath}/MainController" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="createVariant">
                    <input type="hidden" name="StrProductId" value="${product.product_id}">

                    <div class="mb-3">
                        <label class="form-label">Kiểu Size</label>
                        <select id="sizeType" class="form-select" onchange="updateSizeOptions()">
                            <option value="text">Chữ (S,M,L…)</option>
                            <option value="number">Số (36,38…)</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Size</label>
                        <select name="StrSize" id="size" class="form-select" required></select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Màu sắc</label>
                        <input type="text" name="StrColor" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số lượng</label>
                        <input type="number" name="StrQuantity" class="form-control" min="0" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ảnh biến thể</label>
                        <input type="file" name="variantImages" class="form-control" accept="image/*" multiple>
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-plus-circle"></i> Thêm Biến Thể
                    </button>
                </form>
            </div>
        </div>

        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/MainController?action=LoadViewProductDetail&StrProductId=${product.product_id}"
           class="btn btn-secondary mb-5">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateSizeOptions() {
            const t = document.getElementById('sizeType').value;
            const sel = document.getElementById('size');
            sel.innerHTML = '';
            const opts = t === 'text'
                ? ['S','M','L','XL','XXL']
                : ['36','38','40','42','44'];
            opts.forEach(v => {
                const o = document.createElement('option');
                o.value = v; o.textContent = v;
                sel.appendChild(o);
            });
        }
        window.onload = updateSizeOptions;
    </script>
    <jsp:include page="/common/popup.jsp" />
</body>
</html>
