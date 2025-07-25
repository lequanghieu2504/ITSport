<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Sản Phẩm</title>

        <!-- Bootstrap CSS + Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

        <style>
          @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;600;700&display=swap');

          :root {
            --bg-page: #121212;
            --card-bg: #181818;
            --text-light: #e0e0e0;
            --text-faint: #bbb;
            --accent-red: #b30000;
            --accent-red-dark: #800000;
            --shadow: rgba(0, 0, 0, 0.8);
            --radius: 6px;
          }

          /* Reset & Base */
          *, *::before, *::after {
            box-sizing: border-box;
            margin: 0; padding: 0;
          }
          body {
            background: var(--bg-page);
            color: var(--text-light);
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
            background: linear-gradient(135deg, var(--accent-red), var(--accent-red-dark));
            color: #fff;
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 4px 12px var(--shadow);
            margin-bottom: 30px;
          }
          .header-section h1 {
            font-size: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
          }

          /* Thẻ card */
          .card {
            background: var(--card-bg);
            border: 1px solid #222;
            border-radius: var(--radius);
            box-shadow: 0 2px 8px var(--shadow);
            margin-bottom: 1.5rem;
          }
          .card-body {
            padding: 1.5rem;
          }
          .card-title {
            color: var(--accent-red);
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 1rem;
          }

          /* Tables */
          table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border-radius: var(--radius);
            overflow: hidden;
          }
          thead {
            background: var(--accent-red-dark);
          }
          thead th {
            padding: 12px;
            color: #fff;
            text-transform: uppercase;
            font-weight: 600;
            border: none;
          }
          tbody tr {
            background: var(--card-bg);
            transition: background .3s;
          }
          tbody tr:nth-child(odd) {
            background: #202020;
          }
          tbody tr:hover {
            background: #2a2a2a;
          }
          tbody td {
            padding: 12px;
            border-top: 1px solid #222;
            color: var(--text-faint);
          }
          tbody td a {
            color: inherit;
          }
          tbody td a:hover {
            color: var(--accent-red);
            text-decoration: underline;
          }

          /* Badge */
          .badge {
            background: var(--accent-red);
            color: #fff;
            text-transform: uppercase;
            font-size: .8rem;
          }

          /* Form controls */
          .form-control,
          .form-select {
            background: #202020;
            color: var(--text-light);
            border: 1px solid #333;
            border-radius: var(--radius);
            transition: border-color .2s;
          }
          .form-control:focus,
          .form-select:focus {
            border-color: var(--accent-red);
            box-shadow: none;
            outline: none;
          }

          /* Buttons */
          .btn-primary,
          .btn-success {
            background: var(--accent-red);
            border: none;
            color: #fff;
            text-transform: uppercase;
            font-weight: 600;
            border-radius: var(--radius);
            transition: background .2s;
          }
          .btn-primary:hover,
          .btn-success:hover {
            background: var(--accent-red-dark);
          }
          .btn-secondary {
            background: #333;
            border: none;
            color: var(--text-light);
          }
          .btn-secondary:hover {
            background: #444;
          }

          /* Delete button */
          .delete-btn {
            background: var(--accent-red);
            color: #fff;
            border: none;
            width: 24px; height: 24px;
            border-radius: 50%;
            font-weight: bold;
            line-height: 20px;
            text-align: center;
            transition: background .2s;
          }
          .delete-btn:hover {
            background: var(--accent-red-dark);
          }

          /* Floating add-variant button */
          .add-product-btn {
            position: fixed;
            bottom: 25px; right: 25px;
            background: var(--accent-red);
            color: #fff;
            width: 55px; height: 55px;
            font-size: 26px;
            border-radius: 50%;
            box-shadow: 0 4px 12px var(--shadow);
            transition: background .2s, transform .2s;
            z-index: 1000;
          }
          .add-product-btn:hover {
            background: var(--accent-red-dark);
            transform: scale(1.1);
          }

          /* Override text đen trên nền đen */
          .card-body * {
            color: var(--text-light) !important;
          }

          /* Responsive */
          @media (max-width: 768px) {
            .header-section h1 {
              font-size: 1.6rem;
            }
            thead th, tbody td {
              padding: 8px;
              font-size: .9rem;
            }
            .add-product-btn {
              width: 50px; height: 50px;
              font-size: 24px;
              bottom: 15px; right: 15px;
            }
          }
        </style>
    </head>
    <body>

        <div class="container mb-5">

            <!-- Product Info -->
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

            <!-- Main Images -->
            <div class="mb-4">
                <h5>Ảnh Đại Diện</h5>
                <div class="row">
                    <c:forEach var="img" items="${productMainImages}">
                        <div class="col-md-3 mb-3">
                            <img src="${pageContext.request.contextPath}/${img.file_name}"
                                 alt="Main Image" class="img-thumbnail w-100">
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Variants -->
            <h5>Biến Thể Sản Phẩm</h5>
            <c:if test="${empty variantList}">
                <div class="alert alert-info">Chưa có biến thể nào cho sản phẩm này.</div>
            </c:if>

            <c:if test="${not empty variantList}">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Size</th>
                            <th>Số Lượng</th>
                            <th>Màu Sắc</th>
                            <th>SKU</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${variantList}">
                            <tr>
                                <td>${v.product_variant_id}</td>
                                <td>${v.size}</td>
                                <td>${v.quantity}</td>
                                <td>${v.color}</td>
                                <td>${v.sku}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Gallery từng biến thể -->
                <h5 class="mt-4">Ảnh Chi Tiết Biến Thể</h5>
                <c:forEach var="v" items="${variantList}">
                    <h6 class="mt-3">Biến Thể ID ${v.product_variant_id}</h6>
                    <div class="row mb-3">
                        <c:forEach var="img" items="${variantImageMap[v.product_variant_id]}">
                            <div class="col-md-3 position-relative mb-3">
                                <img src="${pageContext.request.contextPath}/${img.file_name}"
                                     class="img-thumbnail w-100">
                                <form action="${pageContext.request.contextPath}/MainController"
                                      method="post" style="position: absolute; top: 5px; right: 5px;">
                                    <input type="hidden" name="action" value="DeleteProductVariantImage">
                                    <input type="hidden" name="StrVariantId" value="${v.product_variant_id}">
                                    <input type="hidden" name="StrProductId" value="${product.product_id}">
                                    <input type="hidden" name="StrImageId" value="${img.image_id}">
                                    <button type="submit" class="delete-btn">&times;</button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Form thêm ảnh -->
                    <form action="${pageContext.request.contextPath}/MainController"
                          method="post" enctype="multipart/form-data" class="mb-4">
                        <input type="hidden" name="action" value="AddToProductVariantImage">
                        <input type="hidden" name="StrVariantId" value="${v.product_variant_id}">
                        <input type="hidden" name="StrProductId" value="${product.product_id}">
                        <div class="input-group">
                            <input type="file" name="variantImage" accept="image/*" required class="form-control">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-plus-circle"></i> Thêm Ảnh
                            </button>
                        </div>
                    </form>
                </c:forEach>
            </c:if>

            <!-- Add Variant & Back -->
            <a href="${pageContext.request.contextPath}/MainController?action=LoadForcreateVariantForm&StrProductId=${product.product_id}"
               class="btn btn-success me-2">
                <i class="bi bi-plus-circle"></i> Thêm Biến Thể
            </a>
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm"
               class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay Lại Danh Sách
            </a>

        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="/common/popup.jsp" />
    </body>
</html>
