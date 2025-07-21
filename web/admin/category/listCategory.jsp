<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-12">
                <h2><i class="bi bi-folder-fill"></i> Quản lý Danh mục</h2>
                
                <!-- Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Add Category Button -->
                <div class="mb-3">
                    <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#addForm">
                        <i class="bi bi-plus-circle"></i> Thêm danh mục
                    </button>
                </div>

                <!-- Add Category Form -->
                <div class="collapse mb-4" id="addForm">
                    <div class="card">
                        <div class="card-header">
                            <h5>Thêm danh mục mới</h5>
                        </div>
                        <div class="card-body">
                            <form action="MainController" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="addCategory">
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Tên danh mục *</label>
                                            <input type="text" name="category_name" class="form-control" required>
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
                                    <label class="form-label">Hình ảnh</label>
                                    <input type="file" name="imageFile" class="form-control">
                                </div>
                                
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-save"></i> Lưu danh mục
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Categories Table -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên danh mục</th>
                                <th>Danh mục cha</th>
                                <th>Hình ảnh</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categoryList}">
                                <tr>
                                    <td>${category.category_id}</td>
                                    <td>${category.category_name}</td>
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
                                                <img src="${pageContext.request.contextPath}/${category.imageUrl}" 
                                                     alt="Category Image" style="width: 50px; height: 50px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <!-- Edit Button -->
                                        <button class="btn btn-sm btn-outline-primary me-1" 
                                                onclick="editCategory('${category.category_id}', '${category.category_name}', '${category.parent_id}', '${category.imageUrl}')" 
                                                data-bs-toggle="modal" data-bs-target="#editModal">
                                            <i class="bi bi-pencil"></i>
                                        </button>

                                        <!-- Add/Remove Image -->
                                        <c:choose>
                                            <c:when test="${empty category.imageUrl}">
                                                <button class="btn btn-sm btn-outline-success me-1" 
                                                        onclick="addImage('${category.category_id}')" 
                                                        data-bs-toggle="modal" data-bs-target="#addImageModal">
                                                    <i class="bi bi-image"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-sm btn-outline-warning me-1" 
                                                        onclick="deleteImage('${category.category_id}', '${category.imageId}')">
                                                    <i class="bi bi-image-fill"></i>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Delete Category -->
                                        <form action="MainController" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="deleteCategory">
                                            <input type="hidden" name="category_id" value="${category.category_id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa danh mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="MainController" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="editCategory">
                        <input type="hidden" name="category_id" id="editId">

                        <div class="mb-3">
                            <label class="form-label">Tên danh mục *</label>
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
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Image Modal -->
    <div class="modal fade" id="addImageModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm hình ảnh</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="MainController" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="addImageCategory">
                        <input type="hidden" name="category_id" id="addImageId">

                        <div class="mb-3">
                            <label class="form-label">Chọn file hình ảnh</label>
                            <input type="file" name="categoryImage" class="form-control">
                        </div>

                        <div class="text-center mb-2">Hoặc</div>

                        <div class="mb-3">
                            <label class="form-label">URL hình ảnh</label>
                            <input type="text" name="imageUrl" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success">Thêm hình ảnh</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function editCategory(id, name, parentId, imageUrl) {
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editParent').value = parentId;
            document.getElementById('editImage').value = imageUrl || '';
        }

        function addImage(categoryId) {
            document.getElementById('addImageId').value = categoryId;
        }

        function deleteImage(categoryId, imageId) {
            if (confirm('Bạn có chắc chắn muốn xóa hình ảnh này?')) {
                // Create form to delete image
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'MainController';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteImageCategory';
                
                const categoryIdInput = document.createElement('input');
                categoryIdInput.type = 'hidden';
                categoryIdInput.name = 'category_id';
                categoryIdInput.value = categoryId;
                
                const imageIdInput = document.createElement('input');
                imageIdInput.type = 'hidden';
                imageIdInput.name = 'image_id';
                imageIdInput.value = imageId;
                
                form.appendChild(actionInput);
                form.appendChild(categoryIdInput);
                form.appendChild(imageIdInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>