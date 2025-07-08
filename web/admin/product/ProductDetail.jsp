<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết sản phẩm</title>
    <style>
        .container {
            max-width: 900px;
            margin: auto;
        }
        .product-info {
            padding: 20px;
            background: #f0f0f0;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background: #ddd;
        }
        .add-button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #2ecc71;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            text-decoration: none;
        }
        .add-button:hover {
            background-color: #27ae60;
        }
    </style>
</head>
<body>
<div class="container">

    <h2>Chi tiết sản phẩm</h2>

    <div class="product-info">
        <p><strong>ID:</strong> ${product.product_id}</p>
        <p><strong>Tên:</strong> ${product.product_name}</p>
        <p><strong>Mô tả:</strong> ${product.description}</p>
        <p><strong>Giá:</strong> ${product.price} đ</p>
        <p><strong>Trạng thái:</strong> ${product.status ? "Hoạt động" : "Không hoạt động"}</p>
    </div>

    <h3>Biến thể sản phẩm</h3>

    <c:if test="${empty variantList}">
        <p>Chưa có biến thể nào cho sản phẩm này.</p>
    </c:if>

    <c:if test="${not empty variantList}">
        <table>
            <tr>
                <th>ID</th>
                <th>Size</th>
                <th>Số lượng</th>
                <th>SKU</th>
            </tr>
            <c:forEach var="v" items="${variantList}">
                <tr>
                    <td>${v.product_variant_id}</td>
                    <td>${v.size}</td>
                    <td>${v.quantity}</td>
                    <td>${v.sku}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <!-- Nút thêm biến thể -->
    <a class="add-button" href="${pageContext.request.contextPath}/MainController?action=LoadForcreateVariantForm&StrProductId=${product.product_id}">
        + Thêm biến thể
    </a>

    <br/><br/>
    <a href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">← Quay lại danh sách sản phẩm</a>

</div>
</body>
</html>
