<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ApexCharts CDN -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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
            <div id="dailyRevenueChart"></div>
        </div>
    </div>

    <!-- Biểu đồ Top 5 Sản Phẩm Bán Chạy -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Top 5 Sản Phẩm Bán Chạy</h5>
            <div id="topProductChart"></div>
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

    <!-- Script ApexCharts -->
    <script>
        // Data từ server
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

        // Biểu đồ Doanh Thu Theo Ngày - Area Chart
        var optionsDaily = {
            chart: {
                type: 'area',
                height: 350
            },
            series: [{
                name: 'Doanh Thu (VNĐ)',
                data: dailyData
            }],
            xaxis: {
                categories: dailyLabels
            },
            dataLabels: {
                enabled: false
            },
            stroke: {
                curve: 'smooth'
            },
            colors: ['#00E396'],
            fill: {
                type: 'gradient',
                gradient: {
                    shadeIntensity: 1,
                    opacityFrom: 0.4,
                    opacityTo: 0.1,
                    stops: [0, 90, 100]
                }
            }
        };

        var chartDaily = new ApexCharts(document.querySelector("#dailyRevenueChart"), optionsDaily);
        chartDaily.render();

        // Biểu đồ Top 5 Sản Phẩm Bán Chạy - Bar Chart
        var optionsTopProduct = {
            chart: {
                type: 'bar',
                height: 350
            },
            series: [{
                name: 'Số Lượng Bán',
                data: topProductData
            }],
            xaxis: {
                categories: topProductLabels
            },
            colors: ['#008FFB'],
            plotOptions: {
                bar: {
                    borderRadius: 4,
                    horizontal: false
                }
            },
            dataLabels: {
                enabled: true
            }
        };

        var chartTopProduct = new ApexCharts(document.querySelector("#topProductChart"), optionsTopProduct);
        chartTopProduct.render();
    </script>
</body>
</html>
