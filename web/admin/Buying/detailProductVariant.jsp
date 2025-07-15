<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Product Variant</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container my-5">
            <h2 class="mb-4">Chi Tiết Product Variant</h2>

            <table class="table table-bordered">
                <tr>
                    <th>ID Variant</th>
                    <td>${productVariant.product_variant_id}</td>
                </tr>
                <tr>
                    <th>Product ID</th>
                    <td>${productVariant.product_id}</td>
                </tr>
                <tr>
                    <th>Size</th>
                    <td>${productVariant.size}</td>
                </tr>
                <tr>
                    <th>Quantity</th>
                    <td>${productVariant.quantity}</td>
                </tr>
                <tr>
                    <th>SKU</th>
                    <td>${productVariant.sku}</td>
                </tr>
                <tr>
                    <th>Color</th>
                    <td>${productVariant.color}</td>
                </tr>
            </table>

            <c:if test="${not empty productVariant.product}">
                <h4 class="mt-4">Thông Tin Product Gốc</h4>
                <table class="table table-bordered">
                    <tr>
                        <th>Product ID</th>
                        <td>${productVariant.product.product_id}</td>
                    </tr>
                    <tr>
                        <th>Tên</th>
                        <td>${productVariant.product.name}</td>
                    </tr>
                    <tr>
                        <th>Mô tả</th>
                        <td>${productVariant.product.description}</td>
                    </tr>
                    <!-- Thêm các field khác của ProductDTO nếu có -->
                </table>
            </c:if>

            <c:if test="${not empty productVariant.listImage}">
                <h4 class="mt-4">Hình Ảnh</h4>
                <div class="row">
                    <c:forEach var="img" items="${productVariant.listImage}">
                        <div class="col-md-3 mb-3">
                            <img src="${img.url}" alt="Image" class="img-thumbnail">
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <a href="javascript:history.back()" class="btn btn-secondary">Quay Lại</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
