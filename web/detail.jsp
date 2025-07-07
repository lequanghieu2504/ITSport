<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết sản phẩm</title>
        <!-- Bootstrap, FontAwesome -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link rel="stylesheet" href="assets/css/detail.css" />

    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container product-container">
            <div class="row">
                <div class="col-md-6 mb-4">
                    <img src="${product.img_url}" alt="${product.product_name}" class="product-img" />
                </div>
                <div class="col-md-6 product-info">
                    <h2>${product.product_name}</h2>
                    <div class="product-price">${product.price}₫</div>
                    <div class="product-desc">${product.description}</div>


                    <form action="buyNow" method="post">
                        <input type="hidden" name="pid" value="${product.product_id}" />
                        <button type="submit" class="btn btn-buy mt-3">
                            <i class="fas fa-shopping-cart mr-2"></i>Mua Ngay
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <jsp:include page="popup.jsp" />
    </body>
</html>
