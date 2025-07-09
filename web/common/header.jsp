<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="assets/css/header.css"/>

<header class="sports-header shadow-sm">
    <div class="container-xl d-flex align-items-center justify-content-between py-2">
        <!-- Logo -->
        <a href="MainController?action=loadForHomePage" class="logo d-flex align-items-center text-decoration-none">
            <img src="assets/images/logo.png" alt="ITSport" class="logo-img mr-2" />
            <span class="logo-text font-weight-bold text-uppercase">ITSport</span>
        </a>

        <!-- Navigation -->
        <nav class="main-nav d-none d-lg-block">
            <ul class="nav-list list-unstyled d-flex mb-0">
                <li><a href="home">Trang chủ</a></li>
                <li><a href="shop">Cửa hàng</a></li>
                <li><a href="about">Về chúng tôi</a></li>
                <li><a href="new">Sản phẩm mới</a></li>
            </ul>
        </nav>

        <!-- Search -->
        <form action="search" method="get" class="search-bar d-none d-md-flex align-items-center">
            <input type="text" name="txt" value="${txtS}" placeholder="Tìm kiếm..." class="form-control search-input" />
            <button type="submit" class="btn btn-primary search-btn"><i class="fa fa-search"></i></button>
        </form>

        <!-- Icons & Auth -->
        <div class="d-flex align-items-center ml-3">
            <!-- Cart -->
            <a href="cart" class="icon-wrapper position-relative mr-3" title="Giỏ hàng">
                <i class="fa fa-shopping-cart icon-item"></i>
                <c:if test="${sessionScope.cartSize > 0}">
                    <span class="cart-badge">${sessionScope.cartSize}</span>
                </c:if>
            </a>
            <!-- Wishlist -->
            <a href="wishlist" class="icon-wrapper mr-3" title="Yêu thích">
                <i class="fa-solid fa-heart icon-item"></i>
            </a>
            
            <!-- Login / Register or Username / Logout -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- Nếu đã login -->
                    <span class="mr-2">Xin chào, ${sessionScope.user.fullName}</span>
                    <a href="MainController?action=logout" class="btn btn-outline-light btn-sm">Logout</a>
                </c:when>
                <c:otherwise>
                    <!-- Nếu chưa login -->
                    <form action="MainController" method="get" class="d-inline">
                        <input type="hidden" name="action" value="login">
                        <button type="submit" class="btn btn-outline-light btn-sm mr-2">Login</button>
                    </form>

                    <form action="MainController" method="get" class="d-inline">
                        <input type="hidden" name="action" value="register">
                        <button type="submit" class="btn btn-primary btn-sm">Register</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler d-lg-none border-0 bg-transparent ml-2" type="button" data-toggle="collapse" data-target="#mobileNav">
            <i class="fa fa-bars fa-lg text-white"></i>
        </button>
    </div>

    <!-- Mobile Nav -->
    <div class="collapse" id="mobileNav">
        <nav class="bg-dark py-2">
            <ul class="list-unstyled mb-0 text-center">
                <li class="py-1"><a href="home">Trang chủ</a></li>
                <li class="py-1"><a href="shop">Cửa hàng</a></li>
                <li class="py-1"><a href="about">Về chúng tôi</a></li>
                <li class="py-1"><a href="new">Sản phẩm mới</a></li>
                <li class="py-1"><a href="sale">Khuyến mãi</a></li>
                <li class="py-1"><a href="MainController?action=login">Login</a></li>
                <li class="py-1"><a href="MainController?action=register">Register</a></li>
            </ul>
        </nav>
    </div>
</header>
