<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang Chủ ITSPORT</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              crossorigin="anonymous">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/homepage.css" type="text/css">

        <!-- jQuery + Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        crossorigin="anonymous"></script>
    </head>

    <body>
        <jsp:include page="/common/header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <jsp:include page="/homepage/filter.jsp"/>

        <!-- SẢN PHẨM MỚI -->
        <div class="newproduct-wrapper section-wrapper">
            <h2>SẢN PHẨM MỚI</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${listNewP}">
                    <a href="MainController?action=viewDetailProduct&pid=${p.product_id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/${p.img_url}" alt="${p.product_name}" />

                            <div class="product-info">
                                <p class="product-name">${p.product_name}</p>
                                <p class="product-price">
                                <fmt:formatNumber value="${p.price}" pattern="#,###" />₫
                            </p>
                                <div class="product-actions">
                                    <form action="MainController?action=viewDetailProduct&pid=${p.product_id}" method="post">
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

        <!-- ÁO THỂ THAO -->
        <div class="ao-wrapper section-wrapper">
            <h2>ÁO THỂ THAO</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${listAo}">
                    <a href="MainController?action=viewDetailProduct&pid=${p.product_id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/${p.img_url}" alt="${p.product_name}" />
                            <div class="product-info">
                                <p class="product-name">${p.product_name}</p>
                                <p class="product-price">
                                <fmt:formatNumber value="${p.price}" pattern="#,###" />₫
                            </p>
                                <div class="product-actions">
                                    <form action="MainController?action=viewDetailProduct&pid=${p.product_id}" method="post">
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

        <!-- QUẦN THỂ THAO -->
        <div class="quan-wrapper section-wrapper">
            <h2>QUẦN THỂ THAO</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${listQ}">
                    <a href="MainController?action=viewDetailProduct&pid=${p.product_id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/${p.img_url}" alt="${p.product_name}" />
                            <div class="product-info">
                                <p class="product-name">${p.product_name}</p>
                                <p class="product-price">
                                <fmt:formatNumber value="${p.price}" pattern="#,###" />₫
                            </p>
                                <div class="product-actions">

                                    <form action="MainController?action=viewDetailProduct&pid=${p.product_id}" method="post">
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

        <!-- GỢI Ý HÔM NAY -->
        <div class="suggest-wrapper section-wrapper">
            <h2>GỢI Ý HÔM NAY</h2>
            <div class="product-grid">
                <c:forEach var="p" items="${productListP}">
                    <a href="MainController?action=viewDetailProduct&pid=${p.product_id}" class="product-card-link">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/${p.img_url}" alt="${p.product_name}" />
                            <div class="product-info">
                                <p class="product-name">${p.product_name}</p>
                                <p class="product-price">
                                <fmt:formatNumber value="${p.price}" pattern="#,###" />₫
                            </p>
                                <div class="product-actions">

                                    <form action="MainController?action=viewDetailProduct&pid=${p.product_id}" method="post">
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

        <script src="assets/js/home.js" defer></script>
        <jsp:include page="/common/footer.jsp" />
        <jsp:include page="/common/popup.jsp" />
    </body>
</html>
