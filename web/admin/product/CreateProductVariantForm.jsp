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
            form {
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                border: 1px solid #ccc;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
            }
            select, input[type="number"], input[type="text"], input[type="file"] {
                width: 100%;
                padding: 6px;
                margin-bottom: 12px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }
            input[type="submit"] {
                background-color: #2ecc71;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #27ae60;
            }
            a.back-link {
                display: inline-block;
                margin-top: 20px;
                text-decoration: none;
                color: #3498db;
            }
        </style>

        <script>
            function updateSizeOptions() {
                const sizeType = document.getElementById("sizeType").value;
                const sizeSelect = document.getElementById("size");

                sizeSelect.innerHTML = "";

                let options = (sizeType === "text")
                        ? ["S", "M", "L", "XL", "XXL"]
                        : ["36", "38", "40", "42", "44"];

                for (let val of options) {
                    let opt = document.createElement("option");
                    opt.value = val;
                    opt.textContent = val;
                    sizeSelect.appendChild(opt);
                }
            }

            window.onload = updateSizeOptions;
        </script>
    </head>
    <body>
        <div class="container">

            <h2>Chi tiết sản phẩm</h2>

            <!-- Thông tin sản phẩm -->
            <div class="product-info">
                <p><strong>ID:</strong> ${product.product_id}</p>
                <p><strong>Tên:</strong> ${product.product_name}</p>
                <p><strong>Mô tả:</strong> ${product.description}</p>
                <p><strong>Giá:</strong> ${product.price} đ</p>
                <p><strong>Trạng thái:</strong> ${product.status ? "Hoạt động" : "Không hoạt động"}</p>
            </div>

            <!-- ✅ Form tạo biến thể -->
            <h3>Thêm biến thể sản phẩm</h3>

            <!-- Phải dùng multipart/form-data để gửi ảnh -->
            <form action="${pageContext.request.contextPath}/MainController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="createVariant" />
                <input type="hidden" name="StrProductId" value="${product.product_id}" />

                <label for="sizeType">Kiểu size:</label>
                <select id="sizeType" onchange="updateSizeOptions()">
                    <option value="text">Ký tự (S, M, L,...)</option>
                    <option value="number">Số (36, 38,...)</option>
                </select>

                <label for="size">Size:</label>
                <select name="StrSize" id="size" required>
                    <!-- Sẽ được fill bằng JS -->
                </select>

                <label for="color">Màu sắc:</label>
                <input type="text" name="StrColor" id="color" required />

                <label for="quantity">Số lượng:</label>
                <input type="number" name="StrQuantity" id="quantity" required min="0" />

                <!-- ✅ Upload ảnh cho biến thể -->
                <label for="variantImages">Ảnh biến thể (có thể chọn nhiều ảnh):</label>
                <input type="file" name="variantImages" id="variantImages" accept="image/*" multiple />

                <input type="submit" value="Thêm biến thể" />
            </form>

            <!-- Quay lại -->
            <a class="back-link" href="${pageContext.request.contextPath}/MainController?action=LoadViewProductDetail&StrProductId=${product.product_id}">
                ← Quay lại danh sách sản phẩm
            </a>

        </div>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
