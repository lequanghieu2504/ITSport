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

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-color: #8B0000;
                --bg-color: #121212;
                --card-bg: #1c1c1c;
                --text-color: #f0f0f0;
                --muted-text: #aaa;
                --thead-bg: #222;
                --row-hover: #2a2a2a;
                --row-even: #181818;
                --border-color: #333;
            }

            body {
                background-color: var(--bg-color);
                color: var(--text-color);
                font-family: 'Roboto', sans-serif;
            }

            h1, h5, h3 {
                color: var(--primary-color);
            }

            .card {
                background-color: var(--card-bg);
                border: none;
                color: var(--text-color);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
            }

            .card-title {
                color: var(--primary-color);
            }

            .table {
                background-color: var(--card-bg);
                color: var(--text-color);
            }

            .table thead,
            .table thead th {
                background-color: var(--thead-bg) !important;
                color: var(--text-color) !important;
            }

            .table tbody tr {
                background-color: var(--card-bg) !important;
                transition: background-color 0.2s ease;
            }

            .table tbody tr:nth-child(even) {
                background-color: var(--row-even) !important;
            }

            .table tbody tr:hover {
                background-color: var(--row-hover) !important;
            }

            .table-bordered th,
            .table-bordered td {
                border-color: var(--border-color) !important;
            }

            .table td,
            .table th {
                color: var(--text-color) !important;
            }
            .table tbody,
            .table tbody tr,
            .table tbody td {
                background-color: var(--card-bg) !important;
                color: var(--text-color) !important;
            }

            .table tbody tr:nth-child(even) td {
                background-color: var(--row-even) !important;
            }

            .table tbody tr:hover td {
                background-color: var(--row-hover) !important;
            }

        </style>
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
                <table class="table table-bordered table-hover">
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
                <table class="table table-bordered table-hover">
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
                    height: 350,
                    foreColor: '#f0f0f0'
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
                    height: 350,
                    foreColor: '#f0f0f0'
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
