<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Create Product</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                background: #f8f9fa;
            }
            .page-header {
                background: linear-gradient(135deg, #00b894, #0984e3);
                color: #fff;
                padding: 25px 0;
                text-align: center;
                margin-bottom: 30px;
            }
            .page-header h1 {
                margin: 0;
                font-weight: 700;
            }
        </style>
    </head>
    <body>

        <div class="page-header">
            <h1><i class="bi bi-plus-square"></i> Create New Product</h1>
        </div>

        <div class="container mb-5">

            <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm" class="btn btn-secondary mb-3">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách
            </a>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Nhập thông tin sản phẩm mới</h5>
                    <form action="MainController" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="insertProduct" />

                        <div class="mb-3">
                            <label for="StrProductName" class="form-label">Product Name</label>
                            <input type="text" id="StrProductName" name="StrProductName" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="StrDescription" class="form-label">Description</label>
                            <textarea id="StrDescription" name="StrDescription" rows="4" class="form-control"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="StrPrice" class="form-label">Price</label>
                            <input type="number" step="0.01" id="StrPrice" name="StrPrice" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="MainImage" class="form-label">Main Product Image</label>
                            <input type="file" id="MainImage" name="MainImage" class="form-control" accept="image/*" required>
                        </div>

                        <div class="mb-3">
                            <label for="StrCategoryId" class="form-label">Category</label>
                            <select name="StrCategoryId" id="StrCategoryId" class="form-select" required>
                                <option value="">-- Select Category --</option>
                                <c:forEach var="c" items="${listC}">
                                    <option value="${c.category_id}">${c.category_name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="StrBrandId" class="form-label">Brand</label>
                            <select name="StrBrandId" id="StrBrandId" class="form-select" required>
                                <option value="">-- Select Brand --</option>
                                <c:forEach var="b" items="${listB}">
                                    <option value="${b.brand_id}">${b.brand_name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-check mb-3">
                            <input type="checkbox" id="StrStatus" name="StrStatus" class="form-check-input" checked>
                            <label for="StrStatus" class="form-check-label">Active</label>
                        </div>

                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-circle"></i> Create Product
                        </button>
                    </form>
                </div>
            </div>

        </div>

        <jsp:include page="/common/popup.jsp" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
