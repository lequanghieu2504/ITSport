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
        body {
            background: #f8f9fc;
        }
        .header-section {
            background: linear-gradient(135deg, #4e73df, #224abe);
            color: #fff;
            padding: 25px 0;
            text-align: center;
            margin-bottom: 30px;
        }
        .header-section h1 {
            margin: 0;
            font-weight: 700;
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
