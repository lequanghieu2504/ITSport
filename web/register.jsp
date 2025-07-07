<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
        }
        .form-container {
            width: 400px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        input[type=text], input[type=password] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }
        .message {
            color: red;
            margin-bottom: 10px;
        }
        input[type=submit] {
            padding: 10px 20px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>User Registration</h2>

        <!-- Hiển thị thông báo nếu có -->
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
            <div class="message"><%= message %></div>
        <%
                session.removeAttribute("message");
            }
        %>

        <!-- Form đăng ký -->
        <form method="post" action="MainController?action=register">
            <div class="form-group">
                <label for="StrUserName">Username:</label>
                <input type="text" name="StrUserName" id="StrUserName" required>
            </div>
            <div class="form-group">
                <label for="StrFullName">Full Name:</label>
                <input type="text" name="StrFullName" id="StrFullName" required>
            </div>
            <div class="form-group">
                <label for="StrPassword">Password:</label>
                <input type="password" name="StrPassword" id="StrPassword" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Register">
            </div>
        </form>
    </div>
</body>
</html>
