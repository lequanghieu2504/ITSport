<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/popup.css"/>
<c:if test="${not empty sessionScope.message}">
    <c:set var="popupMessage" value="${sessionScope.message}" scope="request"/>
    <c:remove var="message" scope="session"/>
</c:if>

<c:if test="${not empty popupMessage}">
    <div id="popupMessage" class="custom-popup">
        <div class="popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <p>${popupMessage}</p>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/popup.js"></script>
</c:if>
