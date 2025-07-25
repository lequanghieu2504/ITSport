<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Product Variant</title>

    <!-- Bootstrap CSS + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

    <style>
      @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;600;700&display=swap');

      :root {
        --bg-page: #ffffff;
        --card-bg: #f8f9fa;
        --text-dark: #212529;
        --text-muted: #6c757d;
        --accent-red: #e74a3b;
        --accent-red-dark: #c0392b;
        --radius: 8px;
        --shadow: rgba(0,0,0,0.1);
      }

      *, *::before, *::after {
        box-sizing: border-box;
      }
      body {
        background: var(--bg-page);
        color: var(--text-dark);
        font-family: 'Oswald', sans-serif;
        line-height: 1.5;
      }
      a {
        color: var(--accent-red);
        text-decoration: none;
        transition: color .2s;
      }
      a:hover {
        color: var(--accent-red-dark);
      }

      /* Header */
      .header-section {
        background: linear-gradient(135deg, var(--accent-red-dark), var(--accent-red));
        color: #fff;
        padding: 2rem 1rem;
        text-align: center;
        border-radius: var(--radius);
        box-shadow: 0 4px 12px var(--shadow);
        margin-bottom: 2rem;
      }
      .header-section h1 {
        font-size: 2.5rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
      .header-section p {
        color: rgba(255,255,255,0.8);
        margin-top: .5rem;
      }

      /* Cards */
      .card {
        background: var(--card-bg);
        border: none;
        border-radius: var(--radius);
        box-shadow: 0 4px 16px var(--shadow);
        margin-bottom: 2rem;
      }
      .card-body {
        padding: 1.5rem;
      }
      .card-title {
        font-weight: 600;
        color: var(--accent-red-dark);
        margin-bottom: 1rem;
      }

      /* Tables */
      .table-bordered {
        border: 1px solid #dee2e6;
      }
      .table-bordered th,
      .table-bordered td {
        vertical-align: middle;
        border: 1px solid #dee2e6;
      }
      .table th {
        width: 200px;
      }
      .table-striped tbody tr:nth-of-type(odd) {
        background-color: var(--bg-page);
      }
      .table-striped tbody tr:nth-of-type(even) {
        background-color: var(--card-bg);
      }
      .table-striped tbody tr:hover {
        background-color: var(--accent-red-light);
        color: #fff;
      }
      .table th {
        background: var(--accent-red);
        color: #fff;
        text-transform: uppercase;
        font-weight: 600;
      }

      /* Images */
      .img-thumbnail {
        border-radius: var(--radius);
        box-shadow: 0 2px 8px var(--shadow);
      }

      /* Buttons */
      .btn-secondary {
        background: var(--accent-red);
        border: none;
        color: #fff;
        border-radius: var(--radius);
        transition: background .2s;
      }
      .btn-secondary:hover {
        background: var(--accent-red-dark);
      }

      /* Responsive */
      @media (max-width: 768px) {
        .header-section h1 { font-size: 2rem; }
        .card-body, .table th, .table td { padding: .75rem; }
      }
    </style>
</head>
<body>

    <!-- Header -->

    <div class="container mb-5">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Thông Tin Variant</h5>
                <table class="table table-bordered table-striped">
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
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Thông Tin Product Gốc</h5>
                    <table class="table table-bordered table-striped">
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
            <div class="card">
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
