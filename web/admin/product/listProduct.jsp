<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách sản phẩm</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            a.button {
                padding: 5px 10px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 3px;
            }
            a.button:hover {
                background-color: #2980b9;
            }
            .actions a {
                margin-right: 5px;
            }
            .add-button {
                display: inline-block;
                margin-top: 15px;
                padding: 10px 15px;
                background-color: #2ecc71;
                color: white;
                font-weight: bold;
                border-radius: 50%;
                font-size: 24px;
                text-align: center;
                line-height: 1;
                text-decoration: none;
            }
            .add-button:hover {
                background-color: #27ae60;
            }
        </style>
    </head>
    <body>

        <h2>Danh sách sản phẩm</h2>

        <c:if test="${empty productList}">
            <p>Chưa có sản phẩm nào.</p>
        </c:if>

        <c:if test="${not empty productList}">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Danh mục</th>
                    <th>Thương hiệu</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="p" items="${productList}">
                    <tr>
                        <td>${p.product_id}</td>
                        <td>${p.product_name}</td>
                        <td>${p.price} đ</td>
                        <td>${p.category_name}</td>
                        <td>${p.brand_name}</td>
                        <td><form action="${pageContext.request.contextPath}/MainController" method="post">
                                <input type="hidden" name="action" value="toggleStatus"/>
                                <input type="hidden" name="product_id" value="${p.product_id}" />

                                <input type="checkbox" name="status"
                                       onchange="this.form.submit()"
                                       <c:if test="${p.status}">checked</c:if> />
                                <label>${p.status ? 'Active' : 'Inactive'}</label>
                            </form></td>
                        <td class="actions">
                            <a class="button" href="${pageContext.request.contextPath}/MainController?action=loadEditForm&id=${p.product_id}">Sửa</a>
                            <a class="button" href="${pageContext.request.contextPath}/MainController?action=deleteProduct&id=${p.product_id}" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <a href="${pageContext.request.contextPath}/MainController?action=loadForCreateForm" class="add-button">+</a>

    </body>
</html>