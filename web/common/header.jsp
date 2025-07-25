<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>

<!-- Bootstrap & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<header class="sports-header shadow-sm">
    <div class="container-xl d-flex align-items-center justify-content-between py-2">
        <!-- Logo -->
        <a href="MainController?action=loadForHomePage" class="logo d-flex align-items-center text-decoration-none">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="ITSport" class="logo-img mr-2" />
            <span class="logo-text font-weight-bold text-uppercase">ITSport</span>
        </a>

        <!-- Navigation -->
        <nav class="main-nav d-none d-lg-block">
            <ul class="nav-list list-unstyled d-flex mb-0">
                <li><a href="MainController?action=loadForHomePage">Trang chủ</a></li>
                <li>
                    <a href="https://maps.app.goo.gl/eLA7Sn7EmN4czyP68" target="_blank" rel="noopener noreferrer">
                        Map
                    </a>
                </li>

                <li><a href="${pageContext.request.contextPath}/aboutUs.jsp">Về chúng tôi</a></li>
                <li><a href="${pageContext.request.contextPath}/policy.jsp">Chính sách mua hàng</a></li>
            </ul>
        </nav>

        <!-- Search -->
        <div class="search-wrapper position-relative">
            <form action="ProductController" method="get" class="search-bar d-none d-md-flex align-items-center">
                <input type="hidden" name="action" value="searchProduct" />
                <input type="text" id="searchInput" name="keyword" value="${keyword}" placeholder="Tìm kiếm..." class="form-control search-input" autocomplete="off"/>
                <button type="submit" class="btn btn-primary search-btn"><i class="fa fa-search"></i></button>
            </form>
        </div>

        <!-- Icons & Auth -->
        <div class="d-flex align-items-center ml-3">

            <!-- ✅ GÓI CHUNG: Chỉ hiện nếu KHÔNG phải Admin -->
            <c:if test="${empty sessionScope.user || sessionScope.user.role ne 'ADMIN'}">

                <!-- Cart -->
                <a href="MainController?action=viewCart" class="icon-wrapper position-relative mr-3" title="Giỏ hàng">
                    <i class="fa fa-shopping-cart icon-item"></i>
                    <c:if test="${sessionScope.cartSize > 0}">
                        <span id="cart-size" class="cart-badge">${sessionScope.cartSize}</span>
                    </c:if>
                </a>

            </c:if>

            <!-- User Dropdown -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">

                    <!-- Xin chào -->
                    <c:choose>
                        <c:when test="${sessionScope.user.role  eq 'ADMIN'}">
                            <span class="mr-2 text-white">Xin chào, Admin</span>
                        </c:when>
                        <c:otherwise>
                            <span class="mr-2 text-white">Xin chào, ${sessionScope.client.full_name}</span>
                        </c:otherwise>

                    </c:choose>

                    <!-- Dropdown User Icon -->
                    <div class="dropdown">
                        <a class="icon-wrapper dropdown-toggle text-decoration-none text-white" href="#" id="userDropdown"

                           role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-user icon-item"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">

                            <!-- ✅ Chỉ hiện Profile & Orders nếu KHÔNG phải Admin -->
                            <c:if test="${sessionScope.user.role ne 'ADMIN'}">
                                <a class="dropdown-item" href="MainController?action=profile">Tài khoản cá nhân</a>
                                <a class="dropdown-item" href="MainController?action=myOrders">Đơn hàng của tôi</a>
                                <div class="dropdown-divider"></div>
                            </c:if>

                            <!-- ✅ Nếu là Admin thì thêm Dashboard -->
                            <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                                <a class="dropdown-item" href="admin/adminDashboard.jsp">
                                    <i class="fa fa-tools"></i> Quản trị Dashboard
                                </a>
                                <div class="dropdown-divider"></div>
                            </c:if>

                            <!-- Logout luôn hiện -->
                            <a class="dropdown-item" href="MainController?action=logout">Đăng xuất</a>

                        </div>
                    </div>

                </c:when>
                <c:otherwise>
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
                <li class="py-1"><a href="MainController?action=loadForHomePage">Trang chủ</a></li>
                <li><a href="https://maps.app.goo.gl/eLA7Sn7EmN4czyP68"
                       target="_blank" rel="noopener noreferrer">Map</a></li>

                <li class="py-1"><a href="${pageContext.request.contextPath}/aboutUs.jsp">Về chúng tôi</a></li>
                <li class="py-1"><a href="${pageContext.request.contextPath}/policy.jsp">Chính sách mua hàng</a></li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                        <li class="py-1"><a href="MainController?action=profile">Tài khoản</a></li>
                        <li class="py-1"><a href="MainController?action=logout">Đăng xuất</a></li>
                        </c:when>
                        <c:otherwise>
                        <li class="py-1"><a href="MainController?action=login">Login</a></li>
                        <li class="py-1"><a href="MainController?action=register">Register</a></li>
                        </c:otherwise>
                    </c:choose>
            </ul>
        </nav>
    </div>
</header>
