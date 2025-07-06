<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">

    <div class="card shadow-sm p-4" style="width: 100%; max-width: 400px;">
        <h2 class="text-center mb-4">🔐 Login</h2>

        <!-- Hiển thị lỗi nếu có query param error -->
        <c:choose>
            <c:when test="${param.error == 'invalid'}">
                <div class="alert alert-danger text-center py-2 mb-3" role="alert">
                    ⚠️ Username hoặc Password không đúng!
                </div>
            </c:when>
            <c:when test="${param.error == 'unauthorized'}">
                <div class="alert alert-warning text-center py-2 mb-3" role="alert">
                    🚫 Bạn không có quyền truy cập trang này.
                </div>
            </c:when>
        </c:choose>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="login" />

            <div class="mb-3">
                <label for="strUsername" class="form-label">👤 Username</label>
                <input type="text" id="strUsername" name="strUsername" class="form-control" required />
            </div>

            <div class="mb-3">
                <label for="strPassword" class="form-label">🔒 Password</label>
                <input type="password" id="strPassword" name="strPassword" class="form-control" required />
            </div>

            <div class="d-grid">
                <input type="submit" value="Login" class="btn btn-primary" />
            </div>
        </form>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
