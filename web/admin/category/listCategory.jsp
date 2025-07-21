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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css"/>

        <style>
            :root {
                --wine-red: #800020;
                --wine-red-dark: #5a0017;
                --background: #fefefe;
                --card-bg: #fff5f8;
                --border-radius: 12px;
                --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                --text-dark: #222;
                --text-light: #fff;
                --accent: #c72c48;
                --success: #28a745;
                --info: #17a2b8;
                --warning: #ffc107;
                --danger: #dc3545;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--background);
                color: var(--text-dark);
                margin: 0;
                padding: 0;
            }

            .main-wrapper {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                margin: 24px auto;
                max-width: 1400px;
                overflow: hidden;
            }

            .header-section {
                background: linear-gradient(135deg, var(--wine-red), var(--wine-red-dark));
                color: var(--text-light);
                text-align: center;
                padding: 36px 0;
            }

            .header-section h1 {
                font-size: 2.4rem;
                font-weight: 700;
                margin-bottom: 6px;
            }

            .content-area {
                padding: 30px;
            }

            .stat-card {
                background: var(--card-bg);
                border-left: 5px solid var(--wine-red);
                padding: 20px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                transition: transform 0.2s ease;
            }

            .stat-card:hover {
                transform: scale(1.02);
            }

            .stat-number {
                font-size: 1.8rem;
                font-weight: bold;
                color: var(--wine-red);
            }

            .table-wrapper {
                background: #fff;
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--shadow);
            }

            .table thead th {
                background-color: var(--wine-red-dark);
                color: var(--text-light);
                text-transform: uppercase;
                font-weight: 600;
                border: none;
            }

            .table tbody tr:hover {
                background-color: #fceef1;
            }

            .category-img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #ddd;
            }

            .action-btn {
                margin: 2px;
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 0.875rem;
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .form-section {
                background: var(--card-bg);
                padding: 30px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                border-top: 4px solid var(--accent);
                margin-top: 30px;
            }

            .form-control {
                border-radius: 8px;
                border: 2px solid #eee;
                transition: all 0.2s ease;
            }

            .form-control:focus {
                border-color: var(--wine-red);
                box-shadow: 0 0 0 0.2rem rgba(128, 0, 32, 0.25);
            }

            .btn-primary {
                background: linear-gradient(to right, var(--wine-red), var(--wine-red-dark));
                border: none;
                border-radius: 8px;
                font-weight: bold;
                color: var(--text-light);
                padding: 10px 24px;
                transition: all 0.2s ease;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(128, 0, 32, 0.3);
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-active {
                background: var(--success);
                color: white;
            }

            .status-inactive {
                background: #999;
                color: white;
            }

            .search-container {
                position: relative;
                max-width: 300px;
            }

            .search-container input {
                padding-left: 40px;
            }

            .search-container i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #999;
            }

            .breadcrumb {
                background: none;
                padding: 0;
                margin-bottom: 20px;
            }

            .breadcrumb-item a {
                color: var(--wine-red);
                text-decoration: none;
            }

            .alert {
                border-radius: var(--border-radius);
                border: none;
                box-shadow: var(--shadow);
            }

            .modal-content {
                border-radius: var(--border-radius);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }

            @media (max-width: 768px) {
                .header-section h1 {
                    font-size: 2rem;
                }

                .content-area {
                    padding: 20px;
                }

                .action-btn {
                    font-size: 0.75rem;
                    padding: 4px 8px;
                }
            }
        </style>
    </head>
    <body>

        <div class="container-fluid">
            <div class="main-wrapper">
                <!-- Header -->
                <div class="header-section">
                    <h1><i class="bi bi-folder-fill"></i> Quản lý Danh mục</h1>
                    <p class="mb-0">Quản lý và tổ chức các danh mục sản phẩm</p>
                </div>

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
                    <div class="row stats-row">
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="flex-grow-1">
                                        <div class="stat-number">
                                            <c:choose>
                                                <c:when test="${not empty categoryList}">
                                                    ${categoryList.size()}
                                                </c:when>
                                                <c:otherwise>0</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="text-muted">Tổng danh mục</div>
                                    </div>
                                    <i class="bi bi-folder text-primary" style="font-size: 2rem;"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="flex-grow-1">
                                        <div class="stat-number">
                                            <c:set var="parentCount" value="0"/>
                                            <c:forEach var="cat" items="${categoryList}">
                                                <c:if test="${cat.parent_id == 0}">
                                                    <c:set var="parentCount" value="${parentCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            ${parentCount}
                                        </div>
                                        <div class="text-muted">Danh mục cha</div>
                                    </div>
                                    <i class="bi bi-folder-plus text-success" style="font-size: 2rem;"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="flex-grow-1">
                                        <div class="stat-number">
                                            <c:set var="childCount" value="0"/>
                                            <c:forEach var="cat" items="${categoryList}">
                                                <c:if test="${cat.parent_id != 0}">
                                                    <c:set var="childCount" value="${childCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            ${childCount}
                                        </div>
                                        <div class="text-muted">Danh mục con</div>
                                    </div>
                                    <i class="bi bi-folder-minus text-warning" style="font-size: 2rem;"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="stat-card">
                                <div class="d-flex align-items-center">
                                    <div class="flex-grow-1">
                                        <div class="stat-number">
                                            <c:set var="imageCount" value="0"/>
                                            <c:forEach var="cat" items="${categoryList}">
                                                <c:if test="${not empty cat.imageUrl}">
                                                    <c:set var="imageCount" value="${imageCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${not empty categoryList and categoryList.size() > 0}">
                                                <fmt:formatNumber value="${(imageCount / categoryList.size()) * 100}" maxFractionDigits="0"/>%
                                            </c:if>
                                            <c:if test="${empty categoryList or categoryList.size() == 0}">0%</c:if>
                                            </div>
                                            <div class="text-muted">Có hình ảnh</div>
                                        </div>
                                        <i class="bi bi-image text-info" style="font-size: 2rem;"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

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

        <jsp:include page="/common/popup.jsp" />

    </body>

</html>