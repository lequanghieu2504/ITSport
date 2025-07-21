<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách sản phẩm</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

        <style>
  @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;600;700&display=swap');

  :root {
    --bg-page: #0d0d0d;
    --card-bg: #1a1a1a;
    --text-light: #f0f0f0;
    --accent-red: #b30000;
    --accent-dark: #000;
    --table-head: #2c0202;
    --table-hover: #330000;
    --shadow: rgba(0, 0, 0, 0.8);
    --radius: 6px;
  }

  /* Reset & base */
  *, *::before, *::after { box-sizing: border-box; }
  body {
    margin: 0; padding: 0;
    background: var(--bg-page);
    color: var(--text-light);
    font-family: 'Oswald', sans-serif;
    line-height: 1.5;
  }
  a { color: var(--accent-red); text-decoration: none; transition: color .2s; }
  a:hover { color: #ff4d4d; }

  /* Header */
  .page-header {
    background: linear-gradient(120deg, var(--accent-red), var(--accent-dark));
    color: #fff;
    padding: 25px 0;
    text-align: center;
    box-shadow: 0 4px 12px var(--shadow);
    margin-bottom: 30px;
  }
  .page-header h1 {
    font-size: 2.2rem;
    text-transform: uppercase;
    letter-spacing: 1.5px;
  }

  /* Search */
  #searchProductInput {
    background: var(--card-bg);
    color: var(--text-light);
    border: 1px solid #330000;
    border-radius: var(--radius);
    padding: .5rem 1rem;
    transition: border-color .2s;
  }
  #searchProductInput:focus {
    border-color: var(--accent-red);
    outline: none;
  }
  .input-group .btn-outline-secondary {
    background: var(--card-bg);
    border: 1px solid #330000;
    color: var(--text-light);
    transition: background .2s;
  }
  .input-group .btn-outline-secondary:hover {
    background: var(--accent-red);
    color: #fff;
  }

  /* Table container */
  .table-responsive {
    background: var(--card-bg);
    border-radius: var(--radius);
    overflow: hidden;
    box-shadow: 0 2px 8px var(--shadow);
    margin-bottom: 1.5rem;
  }

  /* Table */
  .table {
    width: 100%;
    border-collapse: collapse;
  }
  .table thead {
    background: linear-gradient(90deg, var(--accent-red), var(--accent-dark));
  }
  .table thead th {
    padding: 12px;
    color: #fff;
    text-transform: uppercase;
    font-weight: 600;
    border: none;
  }
  .table tbody tr {
    background: var(--card-bg);
    transition: background .3s;
  }
  .table tbody tr:nth-child(odd) {
    background: #151515;
  }
  .table tbody tr:hover {
    background: var(--table-hover);
  }
  .table td {
    padding: 12px;
    border-top: 1px solid #2a0000;
    color: var(--text-light);
  }

  /* Buttons */
  .btn-primary, .btn-success {
    background: var(--accent-red);
    border: none;
    color: #fff;
    font-weight: 600;
    text-transform: uppercase;
    padding: .5rem 1rem;
    border-radius: var(--radius);
    transition: background .2s;
  }
  .btn-primary:hover, .btn-success:hover {
    background: #ff1a1a;
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

  /* Floating add */
  .add-product-btn {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background: var(--accent-red);
    color: #fff;
    width: 55px;
    height: 55px;
    font-size: 26px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 12px var(--shadow);
    transition: transform .2s, background .2s;
    z-index: 1000;
  }
  .add-product-btn:hover {
    background: #ff1a1a;
    transform: scale(1.1);
  }

  /* Responsive */
  @media (max-width: 768px) {
    .page-header h1 { font-size: 1.8rem; }
    .table thead th, .table td { padding: 8px; font-size: .9rem; }
    .add-product-btn { width: 50px; height: 50px; font-size: 24px; }
  }
  
  /* Table chữ xám, không còn trắng */
.table td,
.table thead th {
  color: #bbb !important;
}

/* Search input chữ trắng */
#searchProductInput {
  color: #fff !important;
}

/* Placeholder search input cũng trắng nhạt */
#searchProductInput::placeholder {
  color: #ddd !important;
}

/* Button tìm kiếm chữ trắng */
.input-group .btn-outline-secondary,
.input-group .btn-outline-secondary i {
  color: #fff !important;
}

</style>


    </head>
    <body>



        <div class="container mb-5">

            <c:if test="${empty productList}">
                <div class="alert alert-info text-center">
                    Chưa có sản phẩm nào.
                </div>
            </c:if>

            <c:if test="${not empty productList}">
                <!-- Tìm kiếm -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="input-group" style="max-width: 400px;">
                        <input type="text" id="searchProductInput" class="form-control"
                               placeholder="Tìm kiếm sản phẩm..." onkeyup="searchProduct()">
                        <button class="btn btn-outline-secondary" type="button" onclick="searchProduct()">
                            <i class="bi bi-search"></i> Tìm
                        </button>
                    </div>
                </div>

                <!-- Bảng sản phẩm -->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped align-middle">

                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Danh mục</th>
                                <th>Thương hiệu</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${productList}">
                                <tr>
                                    <td>${p.product_id}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/MainController?action=LoadViewProductDetail&StrProductId=${p.product_id}">
                                            ${p.product_name}
                                        </a>
                                    </td>
                                    <td>${p.price} đ</td>
                                    <td>${p.category_name}</td>
                                    <td>${p.brand_name}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/MainController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="toggleStatus"/>
                                            <input type="hidden" name="StrProductId" value="${p.product_id}" />
                                            <button type="submit" name="status" value="${!p.status}" class="btn btn-link p-0">
                                                <i class="bi ${p.status ? 'bi-toggle-on text-success' : 'bi-toggle-off text-secondary'}"
                                                   style="font-size: 1.5rem;"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td class="table-actions">
                                        <a class="btn btn-sm btn-primary"
                                           href="${pageContext.request.contextPath}/MainController?action=loadEditForm&StrProductId=${p.product_id}">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </a>
                                        <a class="btn btn-sm btn-danger"
                                           href="${pageContext.request.contextPath}/MainController?action=deleteProduct&StrProductId=${p.product_id}"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Nút Thêm mới -->
            <a href="${pageContext.request.contextPath}/MainController?action=loadForCreateForm"
               class="btn btn-success add-product-btn shadow">
                <i class="bi bi-plus"></i>
            </a>

        </div>

        <jsp:include page="/common/popup.jsp" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Script Tìm kiếm -->
        <script>
                                               function searchProduct() {
                                                   const input = document.getElementById("searchProductInput");
                                                   const filter = input.value.toLowerCase();
                                                   const table = document.querySelector(".table-responsive table");
                                                   const rows = table.getElementsByTagName("tr");

                                                   for (let i = 1; i < rows.length; i++) { // Bỏ header
                                                       const cells = rows[i].getElementsByTagName("td");
                                                       let found = false;

                                                       for (let j = 0; j < cells.length; j++) {
                                                           const cell = cells[j];
                                                           if (cell && cell.innerText.toLowerCase().indexOf(filter) > -1) {
                                                               found = true;
                                                               break;
                                                           }
                                                       }

                                                       rows[i].style.display = found ? "" : "none";
                                                   }
                                               }
        </script>

    </body>
</html>
