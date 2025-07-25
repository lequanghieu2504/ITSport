<%-- 
    Document   : filter
    Created on : Jul 21, 2025, 10:11:54 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .category-menu-wrapper {
                background-color: #1a1a1a;
                padding: 8px 0;
            }

            .container.category-menu {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 16px;
            }

            .category-menu-item, .brand-menu-item {
                text-decoration: none;
                background-color: #2b2b2b;
                color: #ffffff;
                padding: 5px 14px;
                border-radius: 16px;
                font-size: 14px;
                transition: all 0.2s ease;
                box-shadow: none;
            }

            .category-menu-item:hover,
            .brand-menu-item:hover {
                background-color: #3a3a3a;
                color: #ffffff;
                box-shadow: 0 0 8px 2px rgba(255, 255, 255, 0.3);
                transform: translateY(-1px);
            }

            .category-menu-item p,
            .brand-menu-item p {
                margin: 0;
                padding: 0;
            }
        </style>
    </head>
    <body>
        <div class="category-menu-wrapper">
            <div class="container category-menu">
                <!-- Category -->
                <c:choose>
                    <c:when test="${not empty listC}">
                        <c:forEach var="c" items="${listC}">
                            <a href="ProductController?action=productByCategory&cid=${c.category_id}" class="category-menu-item">
                                <p>${c.category_name}</p>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="ml-3">Không có danh mục nào.</p>
                    </c:otherwise>
                </c:choose>

                <!-- Brand -->
                <c:choose>
                    <c:when test="${not empty listB}">
                        <c:forEach var="b" items="${listB}">
                            <a href="ProductController?action=productByBrand&bid=${b.brand_id}" class="brand-menu-item">
                                <p>${b.brand_name}</p>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="ml-3">Không có thương hiệu nào.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>  
    </body>
</html>
