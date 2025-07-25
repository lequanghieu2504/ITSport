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
  @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;600;700&display=swap');

  :root {
    --bg-page: #121212;
    --card-bg: #1e1e1e;
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
    letter-spacing: 1.5px;
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

  /* Labels & Inputs */
  .form-label,
  .form-check-label {
    color: var(--text-light);
    font-weight: 500;
  }
  .form-control,
  .form-select {
    background: var(--card-bg);
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
    transition: background .2s;
  }
  .btn-secondary:hover {
    background: #444;
  }
  .btn-danger {
    background: #660000;
    border: none;
    color: #fff;
    transition: background .2s;
  }
  .btn-danger:hover {
    background: #990000;
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
