<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <div class="suggestion-item text-muted">Không tìm thấy sản phẩm</div>
    </c:otherwise>
</c:choose>
