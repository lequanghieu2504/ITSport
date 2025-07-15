<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm ảnh cho biến thể</title>
        <style>
            .container {
                max-width: 600px;
                margin: auto;
            }
            .form-box {
                background: #f0f0f0;
                padding: 20px;
                border-radius: 10px;
            }
            label {
                font-weight: bold;
            }
            input[type="file"] {
                margin-top: 10px;
            }
            .submit-button {
                display: inline-block;
                padding: 10px 15px;
                background-color: #3498db;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                text-decoration: none;
                margin-top: 15px;
                border: none;
                cursor: pointer;
            }
            .submit-button:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Thêm ảnh cho biến thể ID ${variantId}</h2>

            <div class="form-box">
                <!-- Form upload ảnh -->
                <form action="${pageContext.request.contextPath}/MainController?action=AddVariantImage" method="post" enctype="multipart/form-data">
                    <!-- Gửi kèm variantId -->
                    <input type="hidden" name="StrVariantId" value="${variantId}"/>

                    <label>Chọn ảnh:</label><br/>
                    <input type="file" name="variantImage" required accept="image/*"/>

                    <br/>
                    <button type="submit" class="submit-button">Tải lên</button>
                </form>
            </div>

            <br/>
            <a href="${pageContext.request.contextPath}/MainController?action=LoadVariantDetail&variantId=${variantId}">← Quay lại chi tiết biến thể</a>
        </div>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
