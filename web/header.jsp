<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="assets/css/header.css"/>

<header class="sports-header shadow-sm">
    <div class="container-xl d-flex align-items-center justify-content-between py-2">
        <!-- Logo -->
        <a href="home" class="logo d-flex align-items-center text-decoration-none">
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
                <li><a href="sale">Khuyến mãi</a></li>
            </ul>
        </nav>

        <!-- Search -->
        <form action="search" method="get" class="search-bar d-none d-md-flex align-items-center">
            <input type="text" name="txt" value="${txtS}" placeholder="Tìm kiếm..." class="form-control search-input" />
            <button type="submit" class="btn btn-primary search-btn"><i class="fa fa-search"></i></button>
        </form>

        <!-- Icons -->
        <div class="icon-group d-flex align-items-center ml-3">
            <!-- Cart -->
            <a href="cart" class="icon-link position-relative mr-3">
                <i class="fa fa-shopping-cart fa-lg"></i>
                <span class="cart-badge badge badge-pill badge-danger">${sessionScope.cartSize}</span>
            </a>

            <!-- Wishlist -->
            <a href="wishlist" class="icon-link mr-3"><i class="fa-solid fa-heart fa-lg"></i></a>
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
            </ul>
        </nav>
    </div>
</header>