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
    </head>
    <body>

        <!-- Header -->
        <div class="header-section">
            <h1><i class="bi bi-box-seam"></i> Chi Tiết Sản Phẩm</h1>
        </div>

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
                            <img src="${pageContext.request.contextPath}/${img.file_name}" alt="Main Image" class="img-thumbnail w-100">
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
                                <img src="${pageContext.request.contextPath}/${img.file_name}" class="img-thumbnail w-100">
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
