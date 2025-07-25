<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hướng Dẫn Chọn Size</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- CSS riêng -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sizeguide.css"/>
</head>
<body>

    <!-- header -->
    <jsp:include page="/common/header.jsp"/>

    <main class="container my-5">
        <h1 class="text-center mb-4">Hướng Dẫn Chọn Size Quần Áo & Giày Dép</h1>

        <!-- Phần 1: Cách Đo Cơ Thể -->
        <section class="mb-5">
            <h3>1. Cách Đo Số Đo Cơ Thể</h3>
            <ul>
                <li><strong>Vòng ngực:</strong> Đo quanh phần rộng nhất của ngực.</li>
                <li><strong>Vòng eo:</strong> Đo quanh eo tự nhiên (chỗ lõm nhất) khi đứng thẳng.</li>
                <li><strong>Vòng mông:</strong> Đo quanh phần rộng nhất của mông, giữ thước song song mặt đất.</li>
                <li><strong>Chiều dài chân:</strong> Đo từ eo xuống cổ chân nếu cần mua quần dài.</li>
            </ul>
        </section>

        <!-- Phần 2: Bảng Size Quần Áo -->
        <section class="mb-5">
            <h3>2. Bảng Size Quần Áo (Centimet)</h3>
            <div class="table-responsive">
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr>
                            <th>Size</th>
                            <th>Ngực (cm)</th>
                            <th>Eo (cm)</th>
                            <th>Mông (cm)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>XS</td><td>80–84</td><td>60–64</td><td>86–90</td></tr>
                        <tr><td>S</td><td>85–89</td><td>65–69</td><td>91–95</td></tr>
                        <tr><td>M</td><td>90–94</td><td>70–74</td><td>96–100</td></tr>
                        <tr><td>L</td><td>95–99</td><td>75–79</td><td>101–105</td></tr>
                        <tr><td>XL</td><td>100–104</td><td>80–84</td><td>106–110</td></tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Phần 3: Bảng Size Giày Dép -->
        <section class="mb-5">
            <h3>3. Bảng Size Giày Dép (Centimet & EU/US)</h3>
            <div class="table-responsive">
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr>
                            <th>Dài Chân (cm)</th>
                            <th>EU</th>
                            <th>US Nam</th>
                            <th>US Nữ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>24.0</td><td>38</td><td>6.5</td><td>8.0</td></tr>
                        <tr><td>24.5</td><td>39</td><td>7.0</td><td>8.5</td></tr>
                        <tr><td>25.0</td><td>40</td><td>7.5</td><td>9.0</td></tr>
                        <tr><td>25.5</td><td>41</td><td>8.0</td><td>9.5</td></tr>
                        <tr><td>26.0</td><td>42</td><td>8.5</td><td>10.0</td></tr>
                        <tr><td>26.5</td><td>43</td><td>9.0</td><td>10.5</td></tr>
                    </tbody>
                </table>
            </div>
            <p class="text-muted">* Đặt thước sát bàn chân, đo từ gót đến ngón dài nhất.</p>
        </section>

        <!-- Phần 4: Tips & Lưu Ý -->
        <section>
            <h3>4. Tips &amp; Lưu Ý</h3>
            <ul>
                <li>Luôn đo khi mặc đồ lót mỏng để số đo chính xác hơn.</li>
                <li>So sánh số đo với bảng size của từng thương hiệu, vì cắt may có thể khác nhau.</li>
                <li>Với quần dài, cộng thêm 1–2 cm để dễ vận động.</li>
                <li>Với giày thể thao, nên chọn lớn hơn 0.5 size nếu bạn hay vận động mạnh.</li>
            </ul>
        </section>
    </main>

    <!-- footer -->
    <jsp:include page="/common/footer.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
