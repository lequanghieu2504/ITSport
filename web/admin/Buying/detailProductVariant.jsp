<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Product Variant</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fc;
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
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .table th {
            width: 200px;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header-section">
        <h1><i class="bi bi-info-square-fill"></i> Chi Tiết Product Variant</h1>
        <p>Thông tin chi tiết về biến thể sản phẩm</p>
    </div>

    <div class="container mb-5">
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Thông Tin Variant</h5>
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th>ID Variant</th>
                            <td>${productVariant.product_variant_id}</td>
                        </tr>
                        <tr>
                            <th>Product ID</th>
                            <td>${productVariant.product_id}</td>
                        </tr>
                        <tr>
                            <th>Size</th>
                            <td>${productVariant.size}</td>
                        </tr>
                        <tr>
                            <th>Quantity</th>
                            <td>${productVariant.quantity}</td>
                        </tr>
                        <tr>
                            <th>SKU</th>
                            <td>${productVariant.sku}</td>
                        </tr>
                        <tr>
                            <th>Color</th>
                            <td>${productVariant.color}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <c:if test="${not empty productVariant.product}">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Thông Tin Product Gốc</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <th>Product ID</th>
                                <td>${productVariant.product.product_id}</td>
                            </tr>
                            <tr>
                                <th>Tên</th>
                                <td>${productVariant.product.name}</td>
                            </tr>
                            <tr>
                                <th>Mô tả</th>
                                <td>${productVariant.product.description}</td>
                            </tr>
                            <!-- Thêm các field khác nếu có -->
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty productVariant.listImage}">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Hình Ảnh</h5>
                    <div class="row">
                        <c:forEach var="img" items="${productVariant.listImage}">
                            <div class="col-md-3 col-sm-4 mb-3">
                                <img src="${img.url}" alt="Image" class="img-thumbnail w-100">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>

        <a href="javascript:history.back()" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="/common/popup.jsp" />

</body>
</html>
