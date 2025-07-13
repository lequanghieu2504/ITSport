<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
    </head>
    <body class="bg-light d-flex align-items-center justify-content-center vh-100">
        <div class="container d-flex shadow-sm bg-white p-3 gap-3" style="max-width: 900px;">

            <!-- Form bên trái -->
            <div class="p-4 flex-fill form-side" style="width: 50%;">
                <h2 class="text-center mb-4 text-danger">Sign Up</h2>

                <form method="post" action="MainController?action=register">
                    <div class="form-group mb-3">
                        <label for="StrUserName">Username:</label>
                        <input type="text" name="StrUserName" id="StrUserName" class="form-control" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="StrFullName">Full Name:</label>
                        <input type="text" name="StrFullName" id="StrFullName" class="form-control" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="StrPassword">Password:</label>
                        <input type="password" name="StrPassword" id="StrPassword" class="form-control" required>
                    </div>
                    <div class="d-grid">
                        <input type="submit" value="Register" class="btn btn-primary" />
                    </div>
                </form>
            </div>

            <!-- Logo bên phải -->
            <div class="d-none d-md-flex align-items-center justify-content-center bg-dark p-4 logo-side" style="width: 50%;">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Logo" class="img-fluid" style="max-height: 250px;">
            </div>
        </div>
        <jsp:include page="/common/popup.jsp" />
    </body>
</html>
