<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Product</title>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">
            &larr; Quay lại danh sách sản phẩm
        </a>

        <h2>Update Product Info</h2>

        <!-- ✅ Form 1: Cập nhật thông tin sản phẩm -->
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="updateProduct">
            <input type="hidden" name="StrProductId" value="${product.product_id}" />

            <!-- Tên sản phẩm -->
            <label for="StrProductName">Product Name:</label><br>
            <input type="text" id="StrProductName" name="StrProductName" value="${product.product_name}" required><br><br>

            <!-- Mô tả -->
            <label for="StrDescription">Description:</label><br>
            <textarea id="StrDescription" name="StrDescription" rows="4" cols="50">${product.description}</textarea><br><br>

            <!-- Giá -->
            <label for="StrPrice">Price:</label><br>
            <input type="number" step="0.01" id="StrPrice" name="StrPrice" value="${product.price}" required><br><br>

            <!-- Danh mục -->
            <label for="StrCategoryId">Category:</label><br>
            <select name="StrCategoryId" id="StrCategoryId" required>
                <option value="">-- Select Category --</option>
                <c:forEach var="c" items="${listC}">
                    <option value="${c.category_id}" 
                            <c:if test="${c.category_id == product.category_id}">selected</c:if>>
                        ${c.category_name}
                    </option>
                </c:forEach>
            </select><br><br>

            <!-- Thương hiệu -->
            <label for="StrBrandId">Brand:</label><br>
            <select name="StrBrandId" id="StrBrandId" required>
                <option value="">-- Select Brand --</option>
                <c:forEach var="b" items="${listB}">
                    <option value="${b.brand_id}" 
                            <c:if test="${b.brand_id == product.brand_id}">selected</c:if>>
                        ${b.brand_name}
                    </option>
                </c:forEach>
            </select><br><br>

            <!-- Trạng thái -->
            <label for="StrStatus">Status:</label>
            <input type="checkbox" id="StrStatus" name="StrStatus" 
                   <c:if test="${product.status eq 'Active'}">checked</c:if>> Active<br><br>

                   <input type="submit" value="Update Product Info">
            </form>

            <hr>

            <h2>Update Product Image</h2>

            <!-- Ảnh hiện tại -->
            <label>Current Main Image:</label><br>
        <c:if test="${not empty product_main_image}">
            <img src="${pageContext.request.contextPath}/${product_main_image.file_name}" width="120"><br><br>
        </c:if>
        <c:if test="${empty product_main_image}">
            <span>No image uploaded yet.</span><br><br>

            <!-- Form upload / update ảnh mới -->
            <form action="MainController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="insertMainProductImage">
                <input type="hidden" name="StrProductId" value="${product.product_id}" />

                <label for="MainImage">Add New Image</label><br>
                <input type="file" id="MainImage" name="MainImage" accept="image/*" required><br><br>

                <c:choose>
                    <c:when test="${empty product_main_image}">
                        <c:set var="btnLabel" value="Upload Image"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="btnLabel" value="Update Image"/>
                    </c:otherwise>
                </c:choose>

                <input type="submit" value="${btnLabel}">
            </form>
        </c:if>

        <!-- Form xóa ảnh (chỉ hiển thị nếu đã có ảnh) -->
        <c:if test="${not empty product_main_image}">
            <form action="MainController" method="post" style="margin-top: 10px;">
                <input type="hidden" name="action" value="deleteProductImage">
                <input type="hidden" name="StrProductId" value="${product.product_id}" />
                <input type="hidden" name="StrImageId" value="${product_main_image.image_id}" />
                <input type="submit" value="Delete Current Image"
                       onclick="return confirm('Are you sure you want to delete this image?');">
            </form>
        </c:if>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
