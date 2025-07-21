<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Update Product</title>

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
            padding-bottom: 40px;
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
          .page-header {
            background: linear-gradient(135deg, var(--accent-red), var(--accent-red-dark));
            color: #fff;
            padding: 25px 0;
            text-align: center;
            box-shadow: 0 4px 12px var(--shadow);
            margin-bottom: 30px;
          }
          .page-header h1 {
            font-size: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
          }

          /* Card */
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

          /* Form controls */
          .form-label,
          .form-check-label {
            color: var(--text-light);
            font-weight: 500;
          }
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
            outline: none;
            box-shadow: none;
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
            padding: .5rem 1rem;
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
          .btn-danger {
            background: #660000;
            border: none;
            color: #fff;
          }
          .btn-danger:hover {
            background: #990000;
          }

          /* Override text đen */
          .card-body * {
            color: var(--text-light) !important;
          }

          /* Responsive */
          @media (max-width: 576px) {
            .page-header h1 {
              font-size: 1.6rem;
            }
            .card-body {
              padding: 1rem;
            }
            .btn-primary, .btn-secondary, .btn-success {
              font-size: .9rem;
              padding: .5rem .75rem;
            }
          }
        </style>
    </head>
    <body>


        <div class="container mb-5">

            <!-- Quay lại -->
            <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm"
               class="btn btn-secondary mb-3">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách sản phẩm
            </a>

            <!-- Form cập nhật -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Cập nhật thông tin sản phẩm</h5>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="updateProduct">
                        <input type="hidden" name="StrProductId" value="${product.product_id}" />

                        <div class="mb-3">
                            <label for="StrProductName" class="form-label">Product Name</label>
                            <input type="text" id="StrProductName" name="StrProductName" class="form-control"
                                   value="${product.product_name}" required>
                        </div>

                        <div class="mb-3">
                            <label for="StrDescription" class="form-label">Description</label>
                            <textarea id="StrDescription" name="StrDescription" class="form-control"
                                      rows="4">${product.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="StrPrice" class="form-label">Price</label>
                            <input type="number" step="0.01" id="StrPrice" name="StrPrice" class="form-control"
                                   value="${product.price}" required>
                        </div>

                        <div class="mb-3">
                            <label for="StrCategoryId" class="form-label">Category</label>
                            <select name="StrCategoryId" id="StrCategoryId" class="form-select" required>
                                <option value="">-- Select Category --</option>
                                <c:forEach var="c" items="${listC}">
                                    <option value="${c.category_id}"
                                            <c:if test="${c.category_id == product.category_id}">selected</c:if>>
                                        ${c.category_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="StrBrandId" class="form-label">Brand</label>
                            <select name="StrBrandId" id="StrBrandId" class="form-select" required>
                                <option value="">-- Select Brand --</option>
                                <c:forEach var="b" items="${listB}">
                                    <option value="${b.brand_id}"
                                            <c:if test="${b.brand_id == product.brand_id}">selected</c:if>>
                                        ${b.brand_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-check mb-3">
                            <input type="checkbox" id="StrStatus" name="StrStatus" class="form-check-input"
                                   <c:if test="${product.status eq 'Active'}">checked</c:if>>
                            <label class="form-check-label" for="StrStatus">Active</label>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Update Product Info
                        </button>
                    </form>
                </div>
            </div>

            <!-- Ảnh sản phẩm -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Cập nhật ảnh đại diện</h5>

                    <div class="mb-3">
                        <label class="form-label">Current Main Image:</label><br/>
                        <c:if test="${not empty product_main_image}">
                            <img src="${pageContext.request.contextPath}/${product_main_image.file_name}"
                                 width="150" class="img-thumbnail">
                        </c:if>
                        <c:if test="${empty product_main_image}">
                            <span class="text-faint">No image uploaded yet.</span>
                        </c:if>
                    </div>

                    <!-- Form upload/update -->
                    <form action="MainController" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="insertMainProductImage">
                        <input type="hidden" name="StrProductId" value="${product.product_id}" />

                        <div class="mb-3">
                            <label for="MainImage" class="form-label">Add/Update Main Image</label>
                            <input type="file" id="MainImage" name="MainImage" accept="image/*"
                                   class="form-control" required>
                        </div>

                        <c:choose>
                            <c:when test="${empty product_main_image}">
                                <c:set var="btnLabel" value="Upload Image"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="btnLabel" value="Update Image"/>
                            </c:otherwise>
                        </c:choose>

                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-upload"></i> ${btnLabel}
                        </button>
                    </form>

                    <!-- Xóa ảnh -->
                    <c:if test="${not empty product_main_image}">
                        <form action="MainController" method="post" class="mt-3">
                            <input type="hidden" name="action" value="deleteProductImage">
                            <input type="hidden" name="StrProductId" value="${product.product_id}" />
                            <input type="hidden" name="StrImageId" value="${product_main_image.image_id}" />

                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this image?');">
                                <i class="bi bi-trash"></i> Delete Current Image
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>

        </div>

        <jsp:include page="/common/popup.jsp" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
