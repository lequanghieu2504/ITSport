<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/popup.css"/>

<c:if test="${not empty sessionScope.message}">
    <div id="toast-message" class="toast">${sessionScope.message}</div>

    <script>
        setTimeout(() => {
            const toast = document.getElementById("toast-message");
            if (toast) {
                toast.style.opacity = "0";
                toast.style.transform = "translateY(-20px)";
                setTimeout(() => toast.remove(), 500);
            }
        }, 2000);
    </script>

    <c:remove var="message" scope="session" />
</c:if>
