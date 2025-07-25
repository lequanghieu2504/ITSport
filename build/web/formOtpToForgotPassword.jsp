<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/popup.css"/>
    </head>
    <body class="bg-light d-flex align-items-center justify-content-center vh-100">
        <div class="container d-flex shadow-sm bg-white p-3 gap-3" style="max-width: 900px;">

            <!-- Logo bên trái -->
            <div class="d-none d-md-flex align-items-center justify-content-center bg-dark p-3 logo-side" style="width: 50%;">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Logo" class="img-fluid" style="max-height: 250px;">
            </div>

            <!-- Form login -->
            <div class="p-4 flex-fill form-side" style="width: 50%;">
                <h2 class="text-center mb-4 text-danger">Login</h2>

                        
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="OTPForGotPassWord" />
                    <div class="mb-3">
                        <label for="StrOtp" class="form-label">OTP</label>
                        <input type="text" id="StrOTP" name="StrOTP" class="form-control" required />
                    </div>
                    <div class="d-grid">
                        <input type="submit" value="Send OTP" class="btn btn-primary" />
                    </div>
                </form>
             

            </div>
        </div>
        <jsp:include page="/common/popup.jsp" />
    </body>
</html>
