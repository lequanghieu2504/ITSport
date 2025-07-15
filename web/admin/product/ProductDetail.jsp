<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #fafafa;
                color: #333;
                line-height: 1.6;
            }
            .container {
                max-width: 960px;
                margin: 40px auto;
                padding: 0 20px;
            }
            h2, h3, h4 {
                margin-bottom: 15px;
                color: #2c3e50;
            }
            .product-info {
                padding: 20px;
                background: #ffffff;
                border-radius: 8px;
                border: 1px solid #ddd;
                margin-bottom: 30px;
            }
            .product-info p {
                margin: 8px 0;
            }
            .image-gallery {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                margin-bottom: 25px;
            }
            .image-gallery img {
                width: 140px;
                height: auto;
                border-radius: 6px;
                border: 1px solid #ccc;
                object-fit: cover;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 25px;
                background: #ffffff;
                border: 1px solid #ddd;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background: #f5f5f5;
                font-weight: bold;
            }
            td img {
                margin: 5px;
                border-radius: 4px;
            }
            .add-button {
                display: inline-block;
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }
            .add-button:hover {
                background-color: #2980b9;
            }
            a.back-link {
                display: inline-block;
                margin-top: 20px;
                text-decoration: none;
                color: #555;
            }
            a.back-link:hover {
                text-decoration: underline;
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

            <!-- Ảnh đại diện -->
            <h3>Ảnh đại diện sản phẩm</h3>
            <div class="image-gallery">
                <c:forEach var="img" items="${productMainImages}">
                    <img src="${pageContext.request.contextPath}/${img.file_name}" alt="Main Image">
                </c:forEach>
            </div>

            <!-- Danh sách biến thể -->
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
                        <th>Màu sắc</th>
                        <th>SKU</th>
                    </tr>
                    <c:forEach var="v" items="${variantList}">
                        <tr>
                            <td>${v.product_variant_id}</td>
                            <td>${v.size}</td>
                            <td>${v.quantity}</td>
                            <td>${v.color}</td>
                            <td>${v.sku}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <!-- ✅ Luôn cho phép thêm ảnh cho từng biến thể -->
            <c:if test="${not empty variantList}">
                <h4>Ảnh chi tiết của từng biến thể</h4>
                <c:forEach var="v" items="${variantList}">
                    <p><strong>Biến thể ID ${v.product_variant_id}:</strong></p>

                    <!-- ✅ Gallery biến thể kèm nút Xóa -->
                    <div class="image-gallery">
                        <c:forEach var="img" items="${variantImageMap[v.product_variant_id]}">
                            <div style="position: relative; display: inline-block;">
                                <img src="${pageContext.request.contextPath}/${img.file_name}" alt="Variant Image">

                                <!-- Nút Xóa ảnh -->
                                <form action="${pageContext.request.contextPath}/MainController"
                                      method="post" style="position: absolute; top: 5px; right: 5px;">
                                    <input type="hidden" name="action" value="DeleteProductVariantImage">
                                    <input type="hidden" name="StrVariantId" value="${v.product_variant_id}">
                                    <input type="hidden" name="StrProductId" value="${product.product_id}">
                                    <input type="hidden" name="StrImageId" value="${img.image_id}">
                                    <button type="submit" style="
                                            background: red;
                                            border: none;
                                            color: white;
                                            font-weight: bold;
                                            border-radius: 50%;
                                            width: 24px;
                                            height: 24px;
                                            cursor: pointer;">×</button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>


                    <!-- ✅ Luôn hiển thị form thêm ảnh -->
                    <form action="${pageContext.request.contextPath}/MainController"
                          method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="AddToProductVariantImage">
                        <input type="hidden" name="StrVariantId" value="${v.product_variant_id}">
                        <input type="hidden" name="StrProductId" value="${product.product_id}">
                        <input type="file" name="variantImage" accept="image/*" required>
                        <button type="submit" class="add-button">+ Thêm ảnh cho biến thể này</button>
                    </form>

                    <br/><br/>
                </c:forEach>
            </c:if>


            <!-- Thêm biến thể -->
            <a class="add-button" href="${pageContext.request.contextPath}/MainController?action=LoadForcreateVariantForm&StrProductId=${product.product_id}">
                + Thêm biến thể
            </a>

            <br/><br/>
            <a class="back-link" href="${pageContext.request.contextPath}/MainController?action=loadForListProductForm">← Quay lại danh sách sản phẩm</a>

        </div>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
