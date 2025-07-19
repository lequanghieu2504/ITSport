<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chính Sách Đổi Trả</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- CSS riêng -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/return.css"/>
</head>
<body>

    <!-- header -->
    <jsp:include page="/common/header.jsp"/>

    <main class="container my-5">
        <h1 class="text-center mb-4">Chính Sách Đổi Trả</h1>

        <!-- 1. Điều Kiện Đổi Trả -->
        <section class="mb-5">
            <h3>1. Điều Kiện Đổi Trả</h3>
            <ul>
                <li>Sản phẩm còn nguyên tem mác, chưa qua sử dụng, không bị hư hỏng do tác động bên ngoài.</li>
                <li>Có đầy đủ hóa đơn, phiếu giao hàng hoặc email xác nhận đơn hàng.</li>
                <li>Lỗi sản phẩm do nhà sản xuất (rách chỉ, bung keo, sai màu so với mô tả).</li>
                <li>Không áp dụng đổi trả với sản phẩm khuyến mãi, đồ lót, tất, mũ bảo hộ đã bóc niêm phong.</li>
            </ul>
        </section>

        <!-- 2. Thời Hạn Đổi Trả -->
        <section class="mb-5">
            <h3>2. Thời Hạn Đổi Trả</h3>
            <p>
                Khách hàng có tối đa <strong>7 ngày</strong> kể từ ngày nhận hàng để làm thủ tục đổi hoặc trả sản phẩm.
                Sau thời gian này, ITSport xin phép từ chối mọi yêu cầu đổi trả.
            </p>
        </section>

        <!-- 3. Quy Trình Đổi Trả -->
        <section class="mb-5">
            <h3>3. Quy Trình Đổi Trả</h3>
            <ol>
                <li>Liên hệ bộ phận Chăm sóc Khách hàng qua email <a href="mailto:support@itsport.vn">support@itsport.vn</a> hoặc hotline <strong>1900 1234</strong> để thông báo mã đơn và lý do.</li>
                <li>Đóng gói sản phẩm cẩn thận cùng hóa đơn, phiếu giao hàng.</li>
                <li>Gửi lại sản phẩm qua bưu điện hoặc đối tác vận chuyển mà ITSport chỉ định.</li>
                <li>Khi nhận hàng và xác nhận đủ điều kiện, chúng tôi sẽ:
                    <ul>
                        <li>Hoàn tiền (nếu trả hàng) trong vòng 3–5 ngày làm việc.</li>
                        <li>Gửi sản phẩm mới (nếu đổi hàng) trong vòng 2 ngày làm việc.</li>
                    </ul>
                </li>
            </ol>
        </section>

        <!-- 4. Phí Đổi Trả -->
        <section class="mb-5">
            <h3>4. Phí Đổi Trả</h3>
            <ul>
                <li>Đổi sản phẩm do lỗi từ phía ITSport: MIỄN PHÍ cước vận chuyển hai chiều.</li>
                <li>Đổi sản phẩm do khách chọn sai size/màu: khách chịu phí vận chuyển gửi trả (từ 20.000₫ tuỳ vùng).</li>
                <li>Trả hàng hoàn tiền: khách chịu phí gửi trả, ITSport chịu phí hoàn tiền vào tài khoản.</li>
            </ul>
        </section>

        <!-- 5. Trường Hợp Ngoại Lệ -->
        <section class="mb-5">
            <h3>5. Trường Hợp Ngoại Lệ</h3>
            <p>
                Trong những dịp khuyến mãi đặc biệt (Flash Sale, Combo ưu đãi…), chính sách đổi trả có thể thay đổi. 
                Chúng tôi sẽ thông báo rõ ràng trên trang sự kiện hoặc trong email xác nhận đơn hàng.
            </p>
        </section>

        <!-- 6. Liên Hệ Hỗ Trợ -->
        <section>
            <h3>6. Liên Hệ Hỗ Trợ</h3>
            <p>Mọi thắc mắc hoặc cần hỗ trợ thêm, vui lòng liên hệ:</p>
            <ul>
                <li>Email: <a href="mailto:support@itsport.vn">support@itsport.vn</a></li>
                <li>Hotline: <strong>1900 1234</strong> (8:00–21:00)</li>
                <li>Fanpage: <a href="https://facebook.com/itsport">facebook.com/itsport</a></li>
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
