<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản Lý Đơn Hàng</title>

  <!-- Bootstrap + Icons + DataTables CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">

  <style>
    @import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;600;700&display=swap');

    :root {
      --bg: #fff;
      --card: #f5f5f5;
      --header-bg: #000;
      --text: #000;
      --text-light: #666;
      --accent: #e74a3b; /* chút đỏ thể thao */
      --radius: 8px;
      --shadow: rgba(0, 0, 0, 0.1);
    }

    *, *::before, *::after {
      box-sizing: border-box;
      margin: 0; padding: 0;
    }
    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'Oswald', sans-serif;
      line-height: 1.5;
    }
    a {
      color: var(--accent);
      text-decoration: none;
      transition: color .2s;
    }
    a:hover {
      color: #c0392b;
    }

    /* Header */
    .header-section {
      background: var(--header-bg);
      color: #fff;
      padding: 2rem 1rem;
      text-align: center;
      box-shadow: 0 4px 12px var(--shadow);
      margin-bottom: 2rem;
      border-radius: var(--radius);
    }
    .header-section h1 {
      font-size: 2.5rem;
      text-transform: uppercase;
      letter-spacing: 2px;
      font-weight: 700;
    }
    .header-section p {
      color: var(--text-light);
      margin-top: 0.5rem;
    }

    /* Table wrapper */
    .table-wrapper {
      background: var(--card);
      border-radius: var(--radius);
      padding: 1rem;
      box-shadow: 0 4px 16px var(--shadow);
    }

    /* Modern table */
    table.sport-table {
      width: 100%;
      border-collapse: collapse;
    }
    table.sport-table thead {
      background: var(--header-bg);
    }
    table.sport-table thead th {
      color: #fff;
      padding: .75rem 1rem;
      text-transform: uppercase;
      font-weight: 600;
      border: none;
    }
    table.sport-table tbody tr {
      transition: background .2s;
    }
    table.sport-table tbody tr:nth-child(odd) {
      background: var(--bg);
    }
    table.sport-table tbody tr:nth-child(even) {
      background: var(--card);
    }
    table.sport-table tbody tr:hover {
      background: var(--header-bg);
      color: #fff;
    }
    table.sport-table td {
      padding: .75rem 1rem;
      border-top: 1px solid #ddd;
      vertical-align: middle;
    }
    table.sport-table td a {
      color: var(--accent);
    }
    table.sport-table td a:hover {
      color: #c0392b;
    }

    /* Status badges */
    .status-badge {
      display: inline-block;
      padding: .25rem .75rem;
      border-radius: var(--radius);
      font-size: .75rem;
      font-weight: 600;
      text-transform: uppercase;
    }
    .status-PENDING   { background: #f6c23e; color: #000; }
    .status-COMPLETED { background: #1cc88a; color: #000; }
    .status-CANCELLED { background: #e74a3b; color: #fff; }

    /* Form controls */
    .form-select,
    .dataTables_filter input,
    .dataTables_length select {
      border-radius: var(--radius);
      padding: .5rem;
      border: 1px solid #ccc;
    }
    .form-select:focus,
    .dataTables_filter input:focus {
      outline: none;
      border-color: var(--accent);
      box-shadow: 0 0 0 2px rgba(231, 74, 59, 0.2);
    }

    /* Buttons */
    .btn-primary {
      background: var(--accent);
      border: none;
      color: #fff;
      text-transform: uppercase;
      font-weight: 600;
      border-radius: var(--radius);
      padding: .5rem 1rem;
      transition: background .2s;
    }
    .btn-primary:hover {
      background: #c0392b;
    }

    /* Pagination */
    .dataTables_wrapper .dataTables_paginate .paginate_button a {
      background: var(--card);
      color: var(--text) !important;
      border: 1px solid #ccc;
      border-radius: var(--radius);
      padding: .5rem .75rem;
      margin: 0 .25rem;
    }
    .dataTables_wrapper .dataTables_paginate .paginate_button .current {
      background: var(--accent) !important;
      color: #fff !important;
      border-color: var(--accent) !important;
    }
    .dataTables_wrapper .dataTables_paginate .paginate_button a:hover {
      background: #c0392b !important;
      color: #fff !important;
      border-color: #c0392b !important;
    }

    @media (max-width: 768px) {
      .header-section h1 { font-size: 2rem; }
      table.sport-table thead th,
      table.sport-table td { padding: .5rem .75rem; font-size: .9rem; }
    }
  </style>
</head>
<body>
  <div class="container-fluid">
    <!-- Header -->

    <div class="container mb-5">
      <div class="table-wrapper">
        <table id="ordersTable" class="table sport-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Sản phẩm</th>
              <th>Tổng tiền</th>
              <th>Thanh toán</th>
              <th>Trạng thái</th>
              <th>Ngày tạo</th>
              <th>Giao hàng</th>
              <th>Hành động</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="buying" items="${buyings}">
              <tr>
                <td><span class="badge bg-primary">${buying.buyingId}</span></td>
                <td>
                  <ul class="list-unstyled mb-0">
                    <c:forEach var="sku" items="${buying.skuList}">
                      <li>
                        <a href="MainController?action=GetProductDetail&sku=${sku}">
                          <i class="bi bi-box"></i> ${sku}
                        </a>
                      </li>
                    </c:forEach>
                  </ul>
                </td>
                <td><fmt:formatNumber value="${buying.totalPrice}" type="currency"/></td>
                <td><span class="badge bg-success">${buying.paymentMethod}</span></td>
                <td>
                  <form action="MainController" method="post" class="d-flex mb-1">
                    <input type="hidden" name="action" value="UpdateBuyingStatus">
                    <input type="hidden" name="strBuyingId" value="${buying.buyingId}">
                    <select name="status" class="form-select form-select-sm me-2">
                      <c:forEach var="st" items="${statuses}">
                        <option value="${st}" <c:if test="${st eq buying.status}">selected</c:if>>
                          ${st}
                        </option>
                      </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">
                      <i class="bi bi-arrow-repeat"></i>
                    </button>
                  </form>
                  <span class="status-badge status-${buying.status}">${buying.status}</span>
                </td>
                <td><fmt:formatDate value="${buying.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>
                  <strong>${buying.shippingName}</strong><br>
                  <i class="bi bi-telephone"></i> ${buying.shippingPhone}<br>
                  <small>${buying.shippingStreet}, ${buying.shippingWard}, ${buying.shippingDistrict}, ${buying.shippingProvince}</small>
                </td>
                <td><!-- Hành động --></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <c:if test="${empty buyings}">
          <div class="alert alert-info text-center mt-3">
            <i class="bi bi-info-circle-fill"></i> Không có đơn hàng!
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
          zeroRecords: "Không tìm thấy đơn hàng",
          infoEmpty: "0–0 của 0",
          infoFiltered: "(lọc từ _MAX_)",
          search: "Tìm kiếm:",
          paginate: { first: "Đầu", last: "Cuối", next: ">", previous: "<" }
        }
      });
    });
  </script>
  <jsp:include page="/common/popup.jsp"/>
</body>
</html>
