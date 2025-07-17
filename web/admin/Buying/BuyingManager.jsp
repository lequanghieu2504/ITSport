<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đơn Hàng</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header-section {
            background: linear-gradient(135deg, #4e73df, #224abe);
            color: #fff;
            padding: 30px 0;
            text-align: center;
            margin-bottom: 30px;
        }
        .header-section h1 {
            font-weight: 700;
        }
        .table-wrapper {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .status-PENDING { background: #f6c23e; color: #fff; }
        .status-COMPLETED { background: #1cc88a; color: #fff; }
        .status-CANCELLED { background: #e74a3b; color: #fff; }
    </style>
</head>
<body>

    <div class="container-fluid">
        <!-- Header -->
        <div class="header-section">
            <h1><i class="bi bi-cart-check-fill"></i> Quản Lý Đơn Hàng</h1>
            <p>Quản lý danh sách đơn hàng và trạng thái</p>
        </div>

        <div class="container mb-5">
            <div class="table-wrapper">
                <table id="ordersTable" class="table table-striped table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Thanh toán</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Thông tin giao hàng</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="buying" items="${buyings}">
                            <tr>
                                <td>
                                    <span class="badge bg-primary">${buying.buyingId}</span>
                                </td>
                                <td>
                                    <ul class="list-unstyled mb-0">
                                        <c:forEach var="sku" items="${buying.skuList}">
                                            <li>
                                                <a href="MainController?action=GetProductDetail&sku=${sku}" 
                                                   class="text-decoration-underline text-primary">
                                                   <i class="bi bi-box"></i> ${sku}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <td><fmt:formatNumber value="${buying.totalPrice}" type="currency"/></td>
                                <td>
                                    <span class="badge bg-success">${buying.paymentMethod}</span>
                                </td>
                                <td>
                                    <form action="MainController" method="post" class="d-flex">
                                        <input type="hidden" name="action" value="UpdateBuyingStatus">
                                        <input type="hidden" name="strBuyingId" value="${buying.buyingId}"/>
                                        <select name="status" class="form-select form-select-sm me-2">
                                            <c:forEach var="st" items="${statuses}">
                                                <option value="${st}" <c:if test="${st eq buying.status}">selected</c:if>>${st}</option>
                                            </c:forEach>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-primary">
                                            <i class="bi bi-arrow-repeat"></i>
                                        </button>
                                    </form>
                                    <span class="status-badge status-${buying.status} mt-2">${buying.status}</span>
                                </td>
                                <td><fmt:formatDate value="${buying.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <strong>${buying.shippingName}</strong><br/>
                                    <i class="bi bi-telephone"></i> ${buying.shippingPhone}<br/>
                                    <small>
                                        ${buying.shippingStreet}, ${buying.shippingWard}, ${buying.shippingDistrict}, ${buying.shippingProvince}
                                    </small>
                                </td>
                                <td>
                                    <!-- Bổ sung hành động nếu cần -->
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:if test="${empty buyings}">
                    <div class="alert alert-info text-center mt-3">
                        <i class="bi bi-info-circle-fill"></i> Không có đơn hàng nào!
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#ordersTable').DataTable({
                responsive: true,
                pageLength: 10,
                order: [[0, 'desc']],
                language: {
                    "lengthMenu": "Hiển thị _MENU_ mục",
                    "zeroRecords": "Không tìm thấy đơn hàng",
                    "info": "Hiển thị _START_ đến _END_ của _TOTAL_ đơn hàng",
                    "infoEmpty": "Hiển thị 0 đến 0 của 0 đơn hàng",
                    "infoFiltered": "(lọc từ _MAX_ đơn hàng)",
                    "search": "Tìm kiếm:",
                    "paginate": {
                        "first": "Đầu",
                        "last": "Cuối",
                        "next": "Tiếp",
                        "previous": "Trước"
                    }
                }
            });
        });
    </script>

    <jsp:include page="/common/popup.jsp" />

</body>
</html>
