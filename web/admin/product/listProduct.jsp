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
            body {
                background: #121212; /* Màu nền tối */
                color: #f0f0f0;
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

            .table-actions a {
                margin-right: 8px;
            }

            .add-product-btn {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 55px;
                height: 55px;
                font-size: 26px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            .table {
                background-color: #1e1e1e; /* Màu nền bảng tối */
                color: #f0f0f0;
            }

            .table thead {
                background-color: #2c2c2c;
                color: #f0f0f0;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #2a2a2a;
            }

            .table-striped tbody tr:hover {
                background-color: #333;
            }

            .table td, .table th {
                vertical-align: middle;
            }

            .table a {
                color: #4fc3f7; /* Link sản phẩm màu xanh dương nhẹ, dễ đọc trên nền tối */
                text-decoration: none;
            }

            .table a:hover {
                text-decoration: underline;
            }

            .btn-primary {
                background-color: #6c5ce7;
                border: none;
            }

            .btn-danger {
                background-color: #d63031;
                border: none;
            }
            .table {
                background-color: #1e1e1e !important; /* Đè mạnh Bootstrap */
                color: #f0f0f0 !important;
            }

            .table thead {
                background-color: #2c2c2c !important;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #2a2a2a !important;
            }

            .table-striped tbody tr:hover {
                background-color: #333 !important;
            }

            .table td, .table th {
                border-color: #444 !important; /* Viền tối */
            }

            .table a {
                color: #4fc3f7 !important;
            }

            .table a:hover {
                text-decoration: underline;
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
                        <thead>
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
