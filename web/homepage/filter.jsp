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
