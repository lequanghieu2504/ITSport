<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Ảnh Cho Biến Thể</title>

        <!-- Bootstrap CSS + Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

            .page-header {
                background: linear-gradient(135deg, #4e73df, #224abe);
                color: #fff;
                padding: 25px 0;
                text-align: center;
                margin-bottom: 30px;
            }

            .page-header h1 {
                margin: 0;
                font-weight: 700;
            }

            .card {
                background-color: var(--card-bg);
                color: var(--text-color);
                border: 1px solid var(--border-color);
            }

            .form-label,
            .form-check-label {
                color: var(--text-color);
            }

            .form-control,
            .form-select {
                background-color: #2a2a2a;
                color: var(--text-color);
                border: 1px solid var(--border-color);
            }

            .form-control:focus,
            .form-select:focus {
                background-color: #2a2a2a;
                color: var(--text-color);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border: none;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
            }

            .btn-success {
                background-color: #198754;
                border: none;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <div class="header-section">
            <h1><i class="bi bi-images"></i> Thêm Ảnh Cho Biến Thể</h1>
        </div>

        <div class="container">

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Biến Thể ID: ${variantId}</h5>

                    <!-- Form Upload Ảnh -->
                    <form action="${pageContext.request.contextPath}/MainController?action=AddVariantImage"
                          method="post" enctype="multipart/form-data">

                        <input type="hidden" name="StrVariantId" value="${variantId}"/>

                        <div class="mb-3">
                            <label class="form-label">Chọn ảnh</label>
                            <input type="file" name="variantImage" accept="image/*" required class="form-control"/>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-upload"></i> Tải Lên
                        </button>
                    </form>
                </div>
            </div>

            <!-- Back Link -->
            <a href="${pageContext.request.contextPath}/MainController?action=LoadVariantDetail&variantId=${variantId}"
               class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay Lại Chi Tiết Biến Thể
            </a>
        </div>

        <jsp:include page="/common/popup.jsp" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
