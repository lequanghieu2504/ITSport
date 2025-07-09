<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/detail.css" />
</head>

<body>
<jsp:include page="/common/header.jsp" />

<div class="container product-container">
    <div class="row">
        <div class="col-md-6 mb-4">
            <img src="${product.img_url}" alt="${product.product_name}" class="product-img" />
        </div>
        <div class="col-md-6 product-info">
            <h2>${product.product_name}</h2>
            <div class="product-price">${product.price}&#8363;</div>
            <div class="product-desc">${product.description}</div>

            <form action="MainController" method="post" class="mt-3">
                <input type="hidden" name="action" value="addToCart" />
                <input type="hidden" name="pid" value="${product.product_id}" />
                <input type="hidden" name="variant_id" id="variantIdInput" />

                <!-- Chọn màu -->
                <div class="form-group">
                    <label for="colorSelect">Chọn màu:</label>
                    <select class="form-control" id="colorSelect" name="color">
                        <c:forEach var="color" items="${colors}">
                            <option value="${color}">${color}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Chọn size -->
                <div class="form-group">
                    <label for="sizeSelect">Chọn size:</label>
                    <select class="form-control" id="sizeSelect" name="size">
                        <!-- Sẽ được cập nhật qua JS -->
                    </select>
                </div>

                <button type="submit" class="btn btn-cart">
                    <i class="fas fa-cart-plus mr-1"></i> Thêm vào giỏ hàng
                </button>
            </form>

            <form action="MainController" method="post" class="flex-fill mt-2">
                <input type="hidden" name="pid" value="${product.product_id}" />
                <input type="hidden" name="action" value="buyProduct" />
                <button type="submit" class="btn btn-buy">
                    <i class="fas fa-shopping-cart mr-2"></i> Mua Ngay
                </button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
<jsp:include page="/common/popup.jsp" />

<script>
    // JSON từ server, ví dụ: [{id:1, color:'Red', size:'M'}, ...]
    const variants = ${variantListJson};

    const colorSelect = document.getElementById('colorSelect');
    const sizeSelect = document.getElementById('sizeSelect');
    const variantIdInput = document.getElementById('variantIdInput');

    function updateSizeOptions() {
        const selectedColor = colorSelect.value;
        const sizeSet = new Set();
        variants.forEach(v => {
            if (v.color === selectedColor) {
                sizeSet.add(v.size);
            }
        });

        sizeSelect.innerHTML = '';
        sizeSet.forEach(size => {
            const option = document.createElement('option');
            option.value = size;
            option.innerText = size;
            sizeSelect.appendChild(option);
        });

        updateVariantId();
    }

    function updateVariantId() {
        const selectedColor = colorSelect.value;
        const selectedSize = sizeSelect.value;
        const match = variants.find(v => v.color === selectedColor && v.size === selectedSize);
        variantIdInput.value = match ? match.id : '';
    }

    colorSelect.addEventListener('change', () => {
        updateSizeOptions();
    });

    sizeSelect.addEventListener('change', () => {
        updateVariantId();
    });

    document.addEventListener('DOMContentLoaded', () => {
        updateSizeOptions();
    });
</script>
</body>
</html>
