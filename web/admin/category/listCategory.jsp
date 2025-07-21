<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Danh mục - Admin Panel</title>

        <!-- Bootstrap 5.3 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- DataTables -->
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">

        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #858796;
                --success-color: #1cc88a;
                --warning-color: #f6c23e;
                --danger-color: #e74a3b;
                --dark-color: #5a5c69;

                --bg-dark: #121212;
                --card-dark: #1e1e1e;
                --border-dark: #333;
                --text-dark: #f0f0f0;
            }

            body {
                background: var(--bg-dark);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-dark);
            }

            .main-wrapper {
                background: var(--card-dark);
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
                margin: 20px auto;
                overflow: hidden;
                max-width: 1400px;
            }

            .header-section {
                background: linear-gradient(135deg, var(--primary-color), #224abe);
                color: white;
                padding: 30px 0;
                text-align: center;
            }

            .header-section h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .content-area {
                padding: 30px;
            }

            .stats-row {
                margin-bottom: 30px;
            }

            .stat-card {
                background: var(--card-dark);
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
                border-left: 4px solid var(--primary-color);
                transition: transform 0.3s ease;
                color: var(--text-dark);
            }

            .stat-card:hover {
                transform: translateY(-5px);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 5px;
            }

            .table-wrapper {
                background: var(--card-dark);
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }

            .table {
                color: var(--text-dark);
            }

            .table thead th {
                background: var(--primary-color);
                color: white;
                font-weight: 600;
                border: none;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background-color: #2a2a2a;
            }

            .category-img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid var(--border-dark);
            }

            .action-btn {
                margin: 2px;
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4);
            }

            .form-section {
                background: var(--card-dark);
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                border-top: 4px solid var(--success-color);
                margin-top: 30px;
            }

            .form-control {
                border-radius: 8px;
                border: 2px solid var(--border-dark);
                background: #2a2a2a;
                color: var(--text-dark);
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary-color), #224abe);
                border: none;
                border-radius: 8px;
                font-weight: 600;
                padding: 12px 30px;
                transition: all 0.3s ease;
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 15px rgba(78, 115, 223, 0.4);
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-active {
                background: var(--success-color);
                color: white;
            }

            .status-inactive {
                background: var(--secondary-color);
                color: white;
            }

            .search-container {
                position: relative;
                max-width: 300px;
                margin-bottom: 20px;
            }

            .search-container input {
                padding-left: 40px;
                background: #2a2a2a;
                border: 2px solid var(--border-dark);
                color: var(--text-dark);
            }

            .search-container i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--secondary-color);
            }

            .breadcrumb {
                background: none;
                padding: 0;
                margin-bottom: 20px;
            }

            .breadcrumb-item a {
                color: var(--primary-color);
                text-decoration: none;
            }

            .alert {
                border-radius: 10px;
                border: none;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                background: var(--card-dark);
                color: var(--text-dark);
            }

            .modal-content {
                border-radius: 15px;
                border: none;
                background: var(--card-dark);
                color: var(--text-dark);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            }

            .modal-header,
            .modal-footer {
                border: none;
            }

            @media (max-width: 768px) {
                .header-section h1 {
                    font-size: 2rem;
                }

                .content-area {
                    padding: 20px;
                }

                .action-btn {
                    padding: 4px 8px;
                    font-size: 0.75rem;
                }
            }
        </style>

    </head>
    <body>

        <div class="container-fluid">
            <div class="main-wrapper">
            

                <!-- Content -->
                <div class="content-area">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/admin">
                                    <i class="bi bi-house"></i> Trang chủ
                                </a>
                            </li>
                            <li class="breadcrumb-item active">Quản lý Danh mục</li>
                        </ol>
                    </nav>

                    <!-- Statistics --> 
                        <!-- Messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Search and Actions -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="search-container">
                            <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm danh mục...">
                            <i class="bi bi-search"></i>
                        </div>
                        <div class="btn-group">
                            <button class="btn btn-outline-primary" onclick="exportData()">
                                <i class="bi bi-download"></i> Xuất Excel
                            </button>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                                <i class="bi bi-plus-circle"></i> Thêm danh mục
                            </button>
                        </div>
                    </div>

                    <!-- Categories Table -->
                    <div class="table-wrapper">
                        <table id="categoryTable" class="table table-striped table-hover mb-0">
                            <thead>
                                <tr>
                                    <th width="8%">ID</th>
                                    <th width="30%">Tên danh mục</th>
                                    <th width="15%">Danh mục cha</th>
                                    <th width="12%">Hình ảnh</th>
                                    <th width="10%">Trạng thái</th>
                                    <th width="25%">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="category" items="${categoryList}">
                                    <tr>
                                        <td>
                                            <span class="badge bg-primary">${category.category_id}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <strong>${category.category_name}</strong>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${category.parent_id == 0}">
                                                    <span class="badge bg-success">Danh mục gốc</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-info">${category.parent_id}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty category.imageUrl}">
                                                    <img src="${pageContext.request.contextPath}/${category.imageUrl}" alt="Category Image" 
                                                         class="category-img" style="cursor: pointer;"
                                                         onclick="previewImage('${category.imageUrl}')">
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">
                                                        <i class="bi bi-image"></i> Chưa có
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="status-badge status-active">Hoạt động</span>
                                        </td>
                                        <td>
                                            -<!-- delele button -->
                                            <div class="btn-group" role="group">
                                                <button class="btn btn-sm btn-outline-primary action-btn" 
                                                        onclick="editCategory('${category.category_id}', '${category.category_name}', '${category.parent_id}', '${category.imageUrl}')"
                                                        title="Chỉnh sửa">
                                                    <i class="bi bi-pencil"></i>
                                                </button>

                                                <!-- Thêm/Xóa ảnh -->
                                                <c:choose>
                                                    <c:when test="${empty category.imageUrl}">
                                                        <button class="btn btn-sm btn-outline-success action-btn" 
                                                                onclick="addImage('${category.category_id}')"
                                                                title="Thêm hình ảnh">
                                                            <i class="bi bi-image"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-outline-warning action-btn" 
                                                                onclick="deleteImage('${category.category_id}', '${category.imageId}')"
                                                                title="Xóa hình ảnh">
                                                            <i class="bi bi-image-fill"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>

                                                <!-- ✅ Nút XÓA CATEGORY -->
                                                <form action="MainController" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="deleteCategory" />
                                                    <input type="hidden" name="category_id" value="${category.category_id}" />
                                                    <button type="submit"
                                                            onclick="return confirm('Bạn có chắc chắn muốn XÓA DANH MỤC này?')"
                                                            class="btn btn-sm btn-outline-danger action-btn"
                                                            title="Xóa danh mục">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Add Category Form -->
                    <div class="form-section">
                        <h2 class="mb-4">
                            <i class="bi bi-plus-circle text-success"></i> Thêm danh mục mới
                        </h2>
                        <form action="MainController" method="post" id="addForm" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="addCategory">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                                        <input type="text" name="category_name" class="form-control" required 
                                               placeholder="Nhập tên danh mục">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Danh mục cha</label>
                                        <select name="parent_id" class="form-select">
                                            <option value="0">Danh mục gốc</option>
                                            <c:forEach var="parentCategory" items="${categoryList}">
                                                <c:if test="${parentCategory.parent_id == 0}">
                                                    <option value="${parentCategory.category_id}">
                                                        ${parentCategory.category_name}
                                                    </option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Hình ảnh (upload)</label>
                                <input type="file" name="imageFile" class="form-control">
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Lưu danh mục
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title">
                            <i class="bi bi-pencil"></i> Chỉnh sửa danh mục
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="CategoryController" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="category_id" id="editId">

                            <div class="mb-3">
                                <label class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                                <input type="text" name="category_name" id="editName" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Danh mục cha</label>
                                <select name="parent_id" id="editParent" class="form-select">
                                    <option value="0">Danh mục gốc</option>
                                    <c:forEach var="parentCategory" items="${categoryList}">
                                        <c:if test="${parentCategory.parent_id == 0}">
                                            <option value="${parentCategory.category_id}">
                                                ${parentCategory.category_name}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">URL hình ảnh</label>
                                <input type="text" name="imageUrl" id="editImage" class="form-control">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning">
                                <i class="bi bi-save"></i> Cập nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Add Image Modal -->
        <div class="modal fade" id="addImageModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">
                            <i class="bi bi-image"></i> Thêm hình ảnh
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <!-- NOTE: thêm enctype="multipart/form-data" -->
                    <form action="MainController" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="addImageCategory">
                            <input type="hidden" name="category_id" id="addImageId">

                            <div class="mb-3">
                                <label class="form-label">Chọn file hình ảnh <span class="text-danger">*</span></label>
                                <input type="file" name="categoryImage" class="form-control">
                            </div>

                            <div class="mb-3 text-center">Hoặc nhập URL hình ảnh</div>

                            <div class="mb-3">
                                <label class="form-label">URL hình ảnh</label>
                                <input type="text" name="imageUrl" class="form-control"
                                       placeholder="Nhập URL hình ảnh...">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Thêm hình ảnh
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- Image Preview Modal -->
        <div class="modal fade" id="imagePreviewModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Xem trước hình ảnh</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="previewImg" src="" alt="Preview" class="img-fluid" style="max-height: 500px;">
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

        <script>
                                                                $(document).ready(function () {
                                                                    // Initialize DataTable
                                                                    $('#categoryTable').DataTable({
                                                                        responsive: true,
                                                                        pageLength: 10,
                                                                        order: [[0, 'asc']],
                                                                        columnDefs: [
                                                                            {orderable: false, targets: [5]}
                                                                        ],
                                                                        language: {
                                                                            "lengthMenu": "Hiển thị _MENU_ mục",
                                                                            "zeroRecords": "Không tìm thấy dữ liệu",
                                                                            "info": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                                                                            "infoEmpty": "Hiển thị 0 đến 0 của 0 mục",
                                                                            "infoFiltered": "(được lọc từ _MAX_ mục)",
                                                                            "search": "Tìm kiếm:",
                                                                            "paginate": {
                                                                                "first": "Đầu",
                                                                                "last": "Cuối",
                                                                                "next": "Tiếp",
                                                                                "previous": "Trước"
                                                                            }
                                                                        }
                                                                    });

                                                                    // Search functionality
                                                                    $('#searchInput').on('keyup', function () {
                                                                        $('#categoryTable').DataTable().search(this.value).draw();
                                                                    });

                                                                    // Auto-hide alerts
                                                                    setTimeout(function () {
                                                                        $('.alert').fadeOut('slow');
                                                                    }, 5000);

                                                                    // Form validation
                                                                    $('#addForm').on('submit', function (e) {
                                                                        const categoryName = $('input[name="category_name"]').val().trim();
                                                                        if (categoryName.length < 2) {
                                                                            e.preventDefault();
                                                                            alert('Tên danh mục phải có ít nhất 2 ký tự');
                                                                            return false;
                                                                        }
                                                                    });
                                                                });

                                                                // Edit category function
                                                                function editCategory(id, name, parentId, imageUrl) {
                                                                    $('#editId').val(id);
                                                                    $('#editName').val(name);
                                                                    $('#editParent').val(parentId);
                                                                    $('#editImage').val(imageUrl || '');
                                                                    $('#editModal').modal('show');
                                                                }

                                                                // Add image function
                                                                function addImage(categoryId) {
                                                                    $('#addImageId').val(categoryId);
                                                                    $('#addImageModal').modal('show');
                                                                }

                                                                // Delete image function
                                                                function deleteImage(categoryId, imageId) {
                                                                    if (confirm('Bạn có chắc chắn muốn xóa hình ảnh này?')) {
                                                                        const form = document.createElement('form');
                                                                        form.method = 'post';
                                                                        form.action = 'MainController';

                                                                        const actionInput = document.createElement('input');
                                                                        actionInput.type = 'hidden';
                                                                        actionInput.name = 'action';
                                                                        actionInput.value = 'deleteImageCategory';

                                                                        const categoryInput = document.createElement('input');
                                                                        categoryInput.type = 'hidden';
                                                                        categoryInput.name = 'category_id';
                                                                        categoryInput.value = categoryId;

                                                                        const imageIdInput = document.createElement('input');
                                                                        imageIdInput.type = 'hidden';
                                                                        imageIdInput.name = 'StrImageId';
                                                                        imageIdInput.value = imageId;

                                                                        form.appendChild(actionInput);
                                                                        form.appendChild(categoryInput);
                                                                        form.appendChild(imageIdInput);

                                                                        document.body.appendChild(form);
                                                                        form.submit();
                                                                    }
                                                                }

                                                                // Delete category function
                                                                function deleteCategory(categoryId) {
                                                                    if (confirm('Bạn có chắc chắn muốn xóa danh mục này?\nLưu ý: Việc xóa danh mục có thể ảnh hưởng đến các sản phẩm liên quan.')) {
                                                                        const form = document.createElement('form');
                                                                        form.method = 'post';
                                                                        form.action = 'CategoryController';

                                                                        const actionInput = document.createElement('input');
                                                                        actionInput.type = 'hidden';
                                                                        actionInput.name = 'action';
                                                                        actionInput.value = 'delete';

                                                                        const idInput = document.createElement('input');
                                                                        idInput.type = 'hidden';
                                                                        idInput.name = 'category_id';
                                                                        idInput.value = categoryId;

                                                                        form.appendChild(actionInput);
                                                                        form.appendChild(idInput);

                                                                        document.body.appendChild(form);
                                                                        form.submit();
                                                                    }
                                                                }
        </script>
        <jsp:include page="/common/popup.jsp" />

    </body>

</html>