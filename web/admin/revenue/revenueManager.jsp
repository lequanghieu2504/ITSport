<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="p-4">
    <h1>Admin Dashboard</h1>

    <!-- Tổng doanh thu -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Tổng Doanh Thu</h5>
            <h3><strong><c:out value="${totalRevenue}" /> VNĐ</strong></h3>
        </div>
    </div>

    <!-- Đơn hàng theo trạng thái -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Đơn Hàng Theo Trạng Thái</h5>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Trạng Thái</th>
                        <th>Số Lượng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${ordersByStatus}">
                        <tr>
                            <td><c:out value="${o.status}" /></td>
                            <td><c:out value="${o.totalOrders}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Biểu đồ Doanh Thu Theo Ngày -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Biểu Đồ Doanh Thu Theo Ngày</h5>
            <canvas id="dailyRevenueChart" height="100"></canvas>
        </div>
    </div>

    <!-- Biểu đồ Top 5 Sản Phẩm Bán Chạy -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Top 5 Sản Phẩm Bán Chạy</h5>
            <canvas id="topProductChart" height="100"></canvas>
        </div>
    </div>

    <!-- Tồn kho biến thể -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Tồn Kho Biến Thể Sản Phẩm</h5>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Tên Sản Phẩm</th>
                        <th>Size</th>
                        <th>Màu</th>
                        <th>Số Lượng Tồn Kho</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${stockList}">
                        <tr>
                            <td><c:out value="${s.productName}" /></td>
                            <td><c:out value="${s.size}" /></td>
                            <td><c:out value="${s.color}" /></td>
                            <td><c:out value="${s.stockQuantity}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Script Chart.js -->
    <script>
        // Doanh thu theo ngày
        const dailyLabels = [
            <c:forEach var="d" items="${dailyRevenue}" varStatus="loop">
                '<c:out value="${d.orderDate}" />'<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        const dailyData = [
            <c:forEach var="d" items="${dailyRevenue}" varStatus="loop">
                <c:out value="${d.dailyRevenue}" /><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        const ctx1 = document.getElementById('dailyRevenueChart').getContext('2d');
        const dailyRevenueChart = new Chart(ctx1, {
            type: 'line',
            data: {
                labels: dailyLabels,
                datasets: [{
                    label: 'Doanh Thu (VNĐ)',
                    data: dailyData,
                    fill: false,
                    borderColor: 'rgba(75,192,192,1)',
                    backgroundColor: 'rgba(75,192,192,0.2)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true
            }
        });

        // Top sản phẩm bán chạy
        const topProductLabels = [
            <c:forEach var="p" items="${topProducts}" varStatus="loop">
                '<c:out value="${p.productName}" />'<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        const topProductData = [
            <c:forEach var="p" items="${topProducts}" varStatus="loop">
                <c:out value="${p.totalSold}" /><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        const ctx2 = document.getElementById('topProductChart').getContext('2d');
        const topProductChart = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: topProductLabels,
                datasets: [{
                    label: 'Số Lượng Bán',
                    data: topProductData,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
