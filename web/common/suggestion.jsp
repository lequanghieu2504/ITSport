<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .suggestion-box {
        background-color: #fff;
        border: 1px solid #ccc;
        max-height: 300px;
        overflow-y: auto;
        position: absolute;
        width: 100%;
        z-index: 999;
    }

    .suggestion-item {
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    .suggestion-item:hover {
        background-color: #f9f9f9;
    }

</style>
<!-- Danh mục gợi ý -->
<c:if test="${not empty categorySuggestions}">
    <c:forEach var="cat" items="${categorySuggestions}">
        <div class="suggestion-item">
            <a href="ProductController?action=productByCategory&cid=${cat.category_id}" class="text-dark text-decoration-none">
                Xem tất cả sản phẩm thuộc danh mục "<strong>${cat.category_name}</strong>"
            </a>
        </div>
    </c:forEach>
</c:if>

<!-- Sản phẩm gợi ý -->
<c:choose>
    <c:when test="${not empty listS}">
        <c:forEach var="p" items="${listS}">
            <div class="suggestion-item">
                <a href="ProductController?action=productByCategory&cid=${p.category_id}&brand=${p.brand_id}" class="text-dark text-decoration-none">
                    ${p.product_name} - ${p.brand_name}
                </a>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="suggestion-item text-muted">Không tìm thấy sản phẩm phù hợp</div>
    </c:otherwise>
</c:choose>
