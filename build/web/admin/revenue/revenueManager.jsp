<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    --primary-color: #E53935;        /* đỏ nổi bật */
    --bg-color: #121212;             /* nền chính */
    --card-bg: #1E1E1E;              /* nền thẻ nhạt hơn chút */
    --text-color: #ECEFF1;           /* chữ sáng */
    --muted-text: #200826;           /* chữ phụ */
    --thead-bg: #2A2A2A;             /* header bảng */
    --row-even: #242424;             /* hàng chẵn */
    --row-hover: #333333;            /* hover */
    --border-color: #424242;         /* viền */
    --accent-color: #00E676;         /* highlight chart */
    --accent2-color: #1E88E5;        /* highlight nút/tiêu đề */
    --radius: 0.75rem;
    --transition: 0.25s ease;
    --shadow: 0 4px 16px rgba(0, 0, 0, 0.7);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: var(--bg-color);
    color: var(--text-color);
    font-family: 'Roboto', sans-serif;
    padding: 2rem;
    line-height: 1.5;
}

h1 {
    color: var(--primary-color);
    font-size: 2.5rem;
    margin-bottom: 1.5rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.7);
}

/* CARD */
.card {
    background: var(--card-bg);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    transition: transform var(--transition), box-shadow var(--transition);
    overflow: hidden;
    margin-bottom: 2rem;
}
.card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.8);
}
.card-body {
    padding: 1.5rem;
}
.card-title {
    color: var(--accent2-color);
    font-size: 1.3rem;
    margin-bottom: 1rem;
    position: relative;
}
.card-title::after {
    content: '';
    display: block;
    width: 40px;
    height: 3px;
    background: var(--accent2-color);
    margin-top: 0.3rem;
    border-radius: 2px;
}

/* TABLE */
.table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border-radius: var(--radius);
    overflow: hidden;
    box-shadow: var(--shadow);
    background: var(--card-bg);
}
.table thead th {
    background: var(--thead-bg);
    color: var(--text-color);
    padding: 1rem;
    text-transform: uppercase;
    font-size: 0.9rem;
    letter-spacing: 0.5px;
    border: none;
}
.table tbody tr {
    transition: background var(--transition);
}
.table tbody tr:nth-child(even) {
    background: var(--row-even);
}
.table tbody tr:hover {
    background: var(--row-hover);
}
.table td {
    padding: 0.75rem 1rem;
    color: var(--muted-text);
    border-bottom: 1px solid var(--border-color);
}

/* ApexCharts */
#dailyRevenueChart,
#topProductChart {
    background: var(--card-bg);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    padding: 1rem;
    min-height: 360px;
    margin-top: 1rem;
}

/* LINKS & BUTTONS */
a, button {
    transition: color var(--transition), background var(--transition);
}
button:hover, a:hover {
    opacity: 0.9;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    body { padding: 1rem; }
    h1 { font-size: 2rem; }
    .card-body { padding: 1rem; }
    .table thead th,
    .table td { padding: 0.6rem 0.8rem; }
}

        </style>
    </head>
    <body class="p-4">
        <h1>Admin Dashboard</h1>

        <!-- Tổng doanh thu -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Tổng Doanh Thu</h5>
                <h3><strong>
                    <fmt:formatNumber value="${totalRevenue}" pattern="#,###" /> VNĐ
                </strong></h3>
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
