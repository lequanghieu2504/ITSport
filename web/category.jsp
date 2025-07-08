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

        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/category.css"/>
    </head>
    <body>
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
                    <label class="font-weight-bold">Thương hiệu:</label>
                    <c:forEach var="b" items="${listBrand}">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="brand" value="${b.brandId}" id="brand${b.brandId}">
                            <label class="form-check-label" for="brand${b.brandId}">${b.name}</label>
                        </div>
                    </c:forEach>
                </div>

                <div class="mb-3">
                    <label class="font-weight-bold">Khoảng giá:</label>
                    <div class="d-flex">
                        <input type="number" class="form-control mr-2" name="minPrice" placeholder="Từ">
                        <input type="number" class="form-control" name="maxPrice" placeholder="Đến">
                    </div>
                </div>

                <!-- Apply button -->
                <button type="submit" style="background-color: #800020; color: white" class="btn w-100 mt-3">Áp dụng bộ lọc</button>
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
                            <a class="brand-item" href="ProductController?action=productByCategory&cid=${param.cid}&brand=${b.brandId}">
                                ${b.name}
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

            <!-- Product List -->
            <div class="row product-list">
                <c:forEach var="p" items="${listP}">
                    <div class="col-md-4 mb-4">
                        <div class="product-card text-center p-3 h-100">
                            <img src="${p.img_url}" class="img-fluid rounded mb-2" alt="${p.product_name}">
                            <h6 class="product-name">${p.product_name}</h6>
                            <p class="text-danger font-weight-bold">${p.price}₫</p>
                            <a href="ProductController?action=viewDetailProduct&pid=${p.product_id}" class="btn btn-sm btn-outline-danger-red">
                                Xem chi tiết
                            </a>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp"/>
        <script src="assets/js/sidebar.js" defer></script>
    </body>
</html>
