<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/popup.css"/>

<c:if test="${not empty sessionScope.message}">
    <div id="popupMessage" class="custom-popup">
        <div class="popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <p>${sessionScope.message}</p>
        </div>
    </div>
    <c:remove var="message" scope="session"/>
</c:if>

<script src="${pageContext.request.contextPath}/assets/js/popup.js" defer></script>