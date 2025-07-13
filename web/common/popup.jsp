<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        }, 5000);
    </script>

    <c:remove var="message" scope="session" />
</c:if>
