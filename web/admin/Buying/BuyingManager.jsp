<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Đơn Hàng</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container my-5">
            <h2 class="mb-4 text-center">Quản Lý Đơn Hàng</h2>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Danh sách sản phẩm</th>
                        <th>Tổng tiền</th>
                        <th>Phương thức thanh toán</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Thông tin giao hàng</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="buying" items="${buyings}">
                        <tr>
                            <td>${buying.buyingId}</td>
                            <td>
                                <ul class="list-unstyled">
                                    <c:forEach var="sku" items="${buying.skuList}">
                                        <li>
                                            <!-- Khi bấm vào SKU thì chuyển sang Controller -->
                                            <a href="MainController?action=GetProductDetail&sku=${sku}" 
                                               class="text-primary text-decoration-underline">
                                                ${sku}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td><fmt:formatNumber value="${buying.totalPrice}" type="currency"/></td>
                            <td>${buying.paymentMethod}</td>
                            <td>
                                <form action="MainController" method="post" class="d-flex">
                                    <input type="hidden" name="action" value="UpdateBuyingStatus">
                                    <input type="hidden" name="strBuyingId" value="${buying.buyingId}"/>
                                    <select name="status" class="form-select form-select-sm me-2">
                                        <c:forEach var="st" items="${statuses}">
                                            <option value="${st}" <c:if test="${st eq buying.status}">selected</c:if>>${st}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                                </form>
                            </td>
                            <td><fmt:formatDate value="${buying.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>
                                <strong>Tên:</strong> ${buying.shippingName}<br/>
                                <strong>ĐT:</strong> ${buying.shippingPhone}<br/>
                                <strong>Địa chỉ:</strong><br/>
                                ${buying.shippingStreet}, ${buying.shippingWard}, ${buying.shippingDistrict}, ${buying.shippingProvince}
                            </td>
                            <td><!-- Các hành động khác nếu cần --></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty buyings}">
                <div class="alert alert-info text-center">
                    Không có đơn hàng nào!
                </div>
            </c:if>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="/common/popup.jsp" />

    </body>
</html>
