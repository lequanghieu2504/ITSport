<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Sản Phẩm</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

        <style>
    @import url('https://fonts.googleapis.com/css2?family=Oswald:w:wght@300;400;600;700&display=swap');
    :root {
        --bg-color: #121212;
        --card-bg: #1a1a1a;
        --text-color: #fff;
        --border-color: #2e2e2e;
        --primary-color: #e52b50;    /* đỏ rượu mạnh mẽ */
        --secondary-color: #1f1f1f;  /* nền tối */
        --accent-color: #f5a623;     /* cam nổi bật */
        --shadow-color: rgba(0, 0, 0, 0.7);
    }

    /* Toàn trang */
    body {
        background-color: var(--bg-color);
        color: var(--text-color);
        font-family: 'Oswald', sans-serif;
        line-height: 1.6;
    }

    /* Header section */
    .header-section {
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
        padding: 40px 0;
        text-align: center;
        color: #fff;
        box-shadow: 0 4px 10px var(--shadow-color);
    }
    .header-section h1 {
        font-size: 2.5rem;
        letter-spacing: 2px;
        text-transform: uppercase;
    }
    .header-section p {
        font-size: 1rem;
        opacity: 0.8;
        margin-top: 8px;
    }

    /* Thẻ card */
    .card {
        background-color: var(--card-bg);
        border: 2px solid var(--border-color);
        border-radius: 0.5rem;
        box-shadow: 0 2px 8px var(--shadow-color);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px var(--shadow-color);
    }
    .card-title {
        font-weight: 600;
        font-size: 1.25rem;
        border-bottom: 2px solid var(--primary-color);
        padding-bottom: 0.5rem;
        margin-bottom: 1rem;
    }

    /* Bảng thông tin */
    .table {
        background-color: var(--card-bg);
        color: var(--text-color);
    }
    .table thead {
        background-color: var(--secondary-color);
    }
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #1f1f1f;
    }
    .table-striped tbody tr:hover {
        background-color: #2a2a2a;
    }

    /* Badge trạng thái */
    .badge {
        font-size: 0.85rem;
        padding: 0.4em 0.75em;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    .badge.bg-success {
        background-color: #28a745 !important;
    }
    .badge.bg-secondary {
        background-color: #6c757d !important;
    }

    /* Form control */
    .form-control, .form-select {
        background-color: #2a2a2a;
        color: var(--text-color);
        border: 1px solid var(--border-color);
        border-radius: 0.25rem;
        transition: border-color 0.3s ease;
    }
    .form-control:focus, .form-select:focus {
        background-color: #2a2a2a;
        border-color: var(--primary-color);
        box-shadow: none;
        color: var(--text-color);
    }
    label.form-label {
        font-weight: 500;
    }

    /* Buttons */
    .btn-primary {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
        text-transform: uppercase;
        font-weight: 600;
        transition: background-color 0.3s ease;
    }
    .btn-primary:hover {
        background-color: var(--accent-color);
        border-color: var(--accent-color);
    }
    .btn-success {
        background-color: #17a2b8;
        border-color: #17a2b8;
    }
    .btn-success:hover {
        background-color: #138496;
        border-color: #138496;
    }
    .btn-secondary {
        background-color: #343a40;
        border-color: #343a40;
    }
    .btn-secondary:hover {
        background-color: #23272b;
        border-color: #23272b;
    }

    /* Nút xoá */
    .delete-btn {
        background-color: #dc3545;
        border: none;
        box-shadow: 0 2px 6px var(--shadow-color);
        transition: transform 0.2s ease;
    }
    .delete-btn:hover {
        transform: scale(1.1);
    }

    /* Ảnh upload */
    input[type="file"] {
        padding: 0.3rem;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .header-section h1 { font-size: 2rem; }
        .header-section p { font-size: 0.9rem; }
    }
</style>


        <script>
            function updateSizeOptions() {
                const sizeType = document.getElementById("sizeType").value;
                const sizeSelect = document.getElementById("size");

                sizeSelect.innerHTML = "";

                let options = (sizeType === "text")
                        ? ["S", "M", "L", "XL", "XXL"]
                        : ["36", "38", "40", "42", "44"];

                for (let val of options) {
                    let opt = document.createElement("option");
                    opt.value = val;
                    opt.textContent = val;
                    sizeSelect.appendChild(opt);
                }
            }

            window.onload = updateSizeOptions;
        </script>
    </head>
    <body>

        <!-- Header -->
        <div class="header-section">
            <h1><i class="bi bi-box-seam"></i> Chi Tiết Sản Phẩm</h1>
            <p>Thông tin & Tạo biến thể</p>
        </div>

        <div class="container mb-5">
            <!-- Thông tin sản phẩm -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Thông Tin Sản Phẩm</h5>
                    <p><strong>ID:</strong> ${product.product_id}</p>
                    <p><strong>Tên:</strong> ${product.product_name}</p>
                    <p><strong>Mô tả:</strong> ${product.description}</p>
                    <p><strong>Giá:</strong> ${product.price} đ</p>
                    <p><strong>Trạng thái:</strong> 
                        <span class="badge bg-${product.status ? 'success' : 'secondary'}">
                            ${product.status ? "Hoạt động" : "Không hoạt động"}
                        </span>
                    </p>
                </div>
            </div>

            <!-- Form tạo biến thể -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Thêm Biến Thể Mới</h5>
                    <form action="${pageContext.request.contextPath}/MainController" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="createVariant" />
                        <input type="hidden" name="StrProductId" value="${product.product_id}" />

                        <div class="mb-3">
                            <label for="sizeType" class="form-label">Kiểu Size:</label>
                            <select id="sizeType" class="form-select" onchange="updateSizeOptions()">
                                <option value="text">Ký tự (S, M, L,...)</option>
                                <option value="number">Số (36, 38,...)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="size" class="form-label">Size:</label>
                            <select name="StrSize" id="size" class="form-select" required>
                                <!-- JS fill -->
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="color" class="form-label">Màu sắc:</label>
                            <input type="text" name="StrColor" id="color" class="form-control" required />
                        </div>

                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số lượng:</label>
                            <input type="number" name="StrQuantity" id="quantity" class="form-control" required min="0" />
                        </div>

                        <div class="mb-3">
                            <label for="variantImages" class="form-label">Ảnh biến thể (có thể chọn nhiều):</label>
                            <input type="file" name="variantImages" id="variantImages" class="form-control" accept="image/*" multiple />
                        </div>

                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-plus-circle"></i> Thêm Biến Thể
                        </button>
                    </form>
                </div>
            </div>

            <!-- Back -->
            <a href="${pageContext.request.contextPath}/MainController?action=LoadViewProductDetail&StrProductId=${product.product_id}" 
               class="btn btn-secondary mt-4">
                <i class="bi bi-arrow-left"></i> Quay Lại
            </a>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
