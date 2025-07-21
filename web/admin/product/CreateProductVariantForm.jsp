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
            :root {
                --bg-color: #121212;
                --card-bg: #1e1e1e;
                --text-color: #f0f0f0;
                --border-color: #333;
                --primary-color: #4e73df;
            }

            body {
                background: var(--bg-color);
                color: var(--text-color);
            }

            .header-section {
                background: linear-gradient(135deg, #4e73df, #224abe);
                color: #fff;
                padding: 30px 0;
                text-align: center;
                margin-bottom: 30px;
            }

            .header-section h1 {
                font-weight: 700;
            }

            .card {
                background-color: var(--card-bg);
                border: 1px solid var(--border-color);
                color: var(--text-color);
            }

            .table {
                background-color: var(--card-bg);
                color: var(--text-color);
            }

            .table thead {
                background-color: #343a40;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #1a1a1a;
            }

            .table-striped tbody tr:hover {
                background-color: #2a2a2a;
            }

            .badge {
                font-size: 0.9rem;
            }

            .delete-btn {
                position: absolute;
                top: 5px;
                right: 5px;
                background: red;
                border: none;
                color: #fff;
                font-weight: bold;
                border-radius: 50%;
                width: 24px;
                height: 24px;
                line-height: 20px;
                text-align: center;
                cursor: pointer;
            }

            .form-control {
                background-color: #2a2a2a;
                color: var(--text-color);
                border: 1px solid var(--border-color);
            }

            .form-control:focus {
                background-color: #2a2a2a;
                color: var(--text-color);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border: none;
            }

            .btn-success {
                background-color: #198754;
                border: none;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
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
