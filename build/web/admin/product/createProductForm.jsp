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
  @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;600;700&display=swap');

  :root {
    --bg-page: #121212;
    --card-bg: #1e1e1e;
    --text-light: #f0f0f0;
    --accent-red: #e52b50;
    --accent-orange: #f5a623;
    --input-bg: #2a2a2a;
    --border-color: #333;
    --shadow: rgba(0, 0, 0, 0.7);
    --radius: 8px;
  }

  /* --- NEW OVERRIDES --- */
  label, 
  h1, h5, p, span, .form-check-label {
    color: var(--text-light);
  }

  .form-select,
  .form-select option {
    background-color: var(--input-bg) !important;
    color: var(--text-light)   !important;
  }

  ::placeholder {
    color: #777;
    opacity: 1;
  }
  /* --- END OVERRIDES --- */

  body {
    background-color: var(--bg-page);
    color: var(--text-light);
    font-family: 'Oswald', sans-serif;
    line-height: 1.5;
  }


  a { color: var(--accent-orange); text-decoration: none; }
  a:hover { color: var(--accent-red); }

  /* Header */
  .page-header {
    background: linear-gradient(135deg, var(--accent-red), var(--accent-orange));
    color: #fff;
    padding: 30px 0;
    text-align: center;
    box-shadow: 0 4px 12px var(--shadow);
    border-bottom-left-radius: var(--radius);
    border-bottom-right-radius: var(--radius);
    margin-bottom: 30px;
  }
  .page-header h1 {
    font-size: 2rem;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    margin: 0;
  }

  /* Card */
  .card {
    background-color: var(--card-bg);
    border: none;
    border-radius: var(--radius);
    box-shadow: 0 2px 10px var(--shadow);
  }
  .card-title {
    color: var(--accent-red);
    font-weight: 600;
    font-size: 1.25rem;
  }

  /* Form controls */
  .form-control, .form-select {
    background-color: var(--input-bg);
    color: var(--text-light);
    border: 1px solid var(--border-color);
    border-radius: var(--radius);
    transition: border-color 0.3s ease;
  }
  .form-control:focus, .form-select:focus {
    border-color: var(--accent-red);
    box-shadow: none;
    background-color: var(--input-bg);
    color: var(--text-light);
  }
  label.form-label {
    font-weight: 500;
  }
  .form-check-label {
    color: var(--text-light);
  }

  /* Buttons */
  .btn-success {
    background-color: var(--accent-red);
    border-color: var(--accent-red);
    font-weight: 600;
    text-transform: uppercase;
    transition: background-color 0.3s ease;
  }
  .btn-success:hover {
    background-color: var(--accent-orange);
    border-color: var(--accent-orange);
  }
  .btn-secondary {
    background-color: #343a40;
    border: none;
    color: #ddd;
  }
  .btn-secondary:hover {
    background-color: #2a2a2a;
    color: #fff;
    opacity: 0.9;
  }

  /* File input */
  input[type="file"] {
    background-color: var(--input-bg);
    border-radius: var(--radius);
  }

  /* Responsive */
  @media (max-width: 768px) {
    .page-header h1 { font-size: 1.6rem; }
    .card-body { padding: 1rem; }
  }
</style>

    </head>
    <body>

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
