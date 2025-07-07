<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">

        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/homepage.css" type="text/css">

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
                integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>

        <!-- Bootstrap JS -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="banner.jsp"></jsp:include>

            <!-- Category Section -->
            <div class="category-wrapper section-wrapper">
                <h2>Danh Mục</h2>
                <div class="category-container">
                <c:choose>
                    <c:when test="${not empty listC}">
                        <c:forEach var="p" items="${listC}">
                            <a href="category?id=${p.id}" class="category-item">
                                <img src="assets/images/detail1.png" width="100" />
                                <h4>${p.name}</h4>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>Không có danh mục nào.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- New Product Section -->
        <div class="newproduct-wrapper section-wrapper">
            <h2>SẢN PHẨM MỚI</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${listNewP}">
                    <a href="detail?pid=${p.id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${p.imgUrl}" alt="${p.productName}" />
                            <div class="product-info">
                                <p class="product-name">${p.productName}</p>
                                <p class="product-price">${p.price}₫</p>
                                <p class="product-quantity">Số lượng: ${p.quantity}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Áo Section -->
        <div class="ao-wrapper section-wrapper">
            <h2>ÁO THỂ THAO</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${listAo}">
                    <a href="detail?pid=${p.id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${p.imgUrl}" alt="${p.productName}" />
                            <div class="product-info">
                                <p class="product-name">${p.productName}</p>
                                <p class="product-price">${p.price}₫</p>
                                <p class="product-quantity">Số lượng: ${p.quantity}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Quần Section -->
        <div class="quan-wrapper section-wrapper">
            <h2>QUẦN THỂ THAO</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${listQ}">
                    <a href="detail?pid=${p.id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${p.imgUrl}" alt="${p.productName}" />
                            <div class="product-info">
                                <p class="product-name">${p.productName}</p>
                                <p class="product-price">${p.price}₫</p>
                                <p class="product-quantity">Số lượng: ${p.quantity}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Suggest Today Section -->
        <div class="suggest-wrapper section-wrapper">
            <h2>GỢI Ý HÔM NAY</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${productListP}">
                    <a href="detail?pid=${p.id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${p.imgUrl}" alt="${p.productName}" />
                            <div class="product-info">
                                <p class="product-name">${p.productName}</p>
                                <p class="product-price">${p.price}₫</p>
                                <p class="product-quantity">Số lượng: ${p.quantity}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
        <script src="assets/js/home.js" defer></script>
    </body>
    <jsp:include page="footer.jsp"></jsp:include>
    <jsp:include page="popup.jsp" />
</html>