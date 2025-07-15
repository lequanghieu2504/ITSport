<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sản phẩm danh mục</title>

        <!-- Bootstrap & Icons -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/category.css"/>
        <link rel="stylesheet" href="assets/css/homepage.css" type="text/css">

        <!-- jQuery + Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
    </head>
    <body style="background-color: #121212;">
        <jsp:include page="/common/header.jsp"/>

        <!-- Overlay -->
        <div id="overlay" class="filter-overlay" onclick="closeFilterPopup()"></div>

        <!-- Popup filter form -->
        <div id="filterPopup" class="filter-popup">
            <div class="popup-header d-flex justify-content-between align-items-center mb-3">
                <h5 class="m-0">Bộ lọc sản phẩm</h5>
                <button class="btn btn-sm btn-outline-secondary" onclick="closeFilterPopup()">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <form action="ProductController" method="get">
                <input type="hidden" name="action" value="productByCategory"/>
                <input type="hidden" name="cid" value="${param.cid}"/>

                <!-- Brand list -->
                <div class="mb-3">
                    <label class="font-weight-bold text-white">Thương hiệu:</label>
                    <c:forEach var="b" items="${listBrand}">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="brand" value="${b.brand_id}" id="brand${b.brand_id}"/>
                            <label class="form-check-label" for="brand${b.brand_id}">${b.brand_name}</label>
                        </div>
                    </c:forEach>
                </div>

                <!-- Price range -->
                <div class="mb-3">
                    <label class="font-weight-bold text-white">Khoảng giá:</label>
                    <div class="d-flex">
                        <input type="number" class="form-control mr-2" name="minPrice" placeholder="Từ">
                        <input type="number" class="form-control" name="maxPrice" placeholder="Đến">
                    </div>
                </div>

                <!-- Apply button -->
                <button type="submit" class="btn w-100 mt-3" style="background-color: #800020; color: white;">Áp dụng bộ lọc</button>
            </form>
        </div>


        <div class="container my-5 px-4">
            <!-- Sort Bar -->
            <div class="filter-sort-bar mb-4">
                <!-- Dòng trên: icon + brand list -->
                <div class="filter-top d-flex align-items-center flex-wrap mb-2">
                    <button class="btn btn-filter" onclick="openFilterPopup()">
                        <i class="fas fa-filter"></i> Bộ lọc
                    </button>
                    <div class="brand-list d-flex flex-wrap">
                        <c:forEach var="b" items="${listBrand}">
                            <a class="brand-item" href="ProductController?action=productByCategory&cid=${param.cid}&brand=${b.brand_id}">
                                ${b.brand_name}
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <!-- Dòng dưới: sắp xếp -->
                <div class="sort-options d-flex flex-wrap align-items-center">
                    <span class="sort-label mr-2">Sắp xếp theo:</span>
                    <a href="#" class="sort-btn active">Nổi bật</a>
                    <a href="#" class="sort-btn">Bán chạy</a>
                    <a href="#" class="sort-btn">Giảm giá</a>
                    <a href="#" class="sort-btn">Mới</a>
                    <select class="sort-select ml-2">
                        <option disabled selected>Giá</option>
                        <option value="asc">Giá tăng dần</option>
                        <option value="desc">Giá giảm dần</option>
                    </select>
                </div>
            </div>

            <!-- Product List - Updated to match homepage style -->
            <div class="product-grid">
                <c:forEach var="p" items="${listP}">
                    <a href="MainController?action=viewDetailProduct&pid=${p.product_id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/${p.img_url}" alt="${p.product_name}" />
                            <div class="product-info">
                                <p class="product-name">${p.product_name}</p>
                                <p class="product-price">${p.price}₫</p>
                                <div class="product-actions">
                                    <form action="MainController" method="post">
                                        <input type="hidden" name="pid" value="${p.product_id}" />
                                        <input type="hidden" name="action" value="viewDetailProduct" />
                                        <button type="submit" class="btn btn-sm btn-danger w-100">
                                            Mua ngay
                                        </button>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp"/>
        <jsp:include page="/common/popup.jsp" />

        <script src="assets/js/sidebar.js" defer></script>
    </body>
</html>