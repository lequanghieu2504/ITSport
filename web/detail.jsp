<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
        <style>
            .product-img {
                width: 100%;
                max-height: 500px;
                object-fit: contain;
                border: 1px solid #ddd;
                margin-bottom: 15px;
            }
            .variant-thumb {
                cursor: pointer;
                border: 2px solid #eee;
                width: 100%;
                height: auto;
            }
            .variant-thumb:hover {
                border: 2px solid #3498db;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/header.jsp"/>

        <div class="container my-5">
            <div class="row">
                <!-- Ảnh chính + Gallery -->
                <div class="col-md-6">
                    <img id="mainProductImg"
                         src="${pageContext.request.contextPath}/${mainImage.file_name}"
                         alt="${product.product_name}" class="product-img"/>

                    <div class="row">
                        <c:forEach var="img" items="${variantImageList}">
                            <div class="col-3 mb-2">
                                <img src="${pageContext.request.contextPath}/${img.file_name}"
                                     alt="Variant"
                                     class="variant-thumb"
                                     onclick="changeMainImage(this)"/>

                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Thông tin sản phẩm -->
                <div class="col-md-6">
                    <h2>${product.product_name}</h2>
                    <h4 class="text-danger">${product.price} &#8363;</h4>
                    <p>${product.description}</p>

                    <!-- Ví dụ nút thêm giỏ -->
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="addToCart"/>
                        <input type="hidden" name="pid" value="${product.product_id}"/>
                        <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp"/>

        <script>
            function changeMainImage(thumb) {
                const mainImg = document.getElementById('mainProductImg');

                // Lưu URL hiện tại của main
                const mainSrc = mainImg.src;

                // Hoán đổi src
                mainImg.src = thumb.src;

                // Đổi lại ảnh thumb thành main cũ
                thumb.src = mainSrc;
            }
        </script>

    </body>
</html>
