<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chính Sách Mua Hàng</title>
    <!-- Bootstrap CSS (nếu cần) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- CSS riêng -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/policy.css"/>
</head>
<body>

    <!-- header -->
    <jsp:include page="/common/header.jsp"/>

    <main class="container my-5">
        <h1 class="text-center mb-4">Chính Sách Mua Hàng</h1>

        <!-- Đặt Hàng -->
        <section class="mb-5">
            <h3>1. Quy Trình Đặt Hàng</h3>
            <ol>
                <li>Chọn sản phẩm và thêm vào giỏ hàng.</li>
                <li>Kiểm tra giỏ hàng, điều chỉnh số lượng, bấm “Thanh toán”.</li>
                <li>Điền thông tin giao nhận và phương thức thanh toán.</li>
                <li>Xác nhận đơn hàng và sẽ có nhân viên gọi để xác nhận đơn hàng.</li>
            </ol>
        </section>

        <!-- Thanh Toán -->
        <section class="mb-5">
            <h3>2. Phương Thức Thanh Toán</h3>
            <ul>
                <li><strong>Thanh toán khi nhận hàng (COD):</strong> Áp dụng cho đơn nội thành Hồ Chí Minh và Hà Nội.</li>
                <li><strong>Ví điện tử & Gateways:</strong> Hỗ trợ VNPAY, Momo, ZaloPay... (tuỳ thời điểm).</li>
            </ul>
        </section>

        <!-- Vận Chuyển -->
        <section class="mb-5">
            <h3>3. Vận Chuyển & Giao Nhận</h3>
            <ul>
                <li><strong>Thời gian xử lý:</strong> 1–2 ngày làm việc.</li>
                <li><strong>Thời gian giao hàng:</strong> 2–5 ngày tuỳ khu vực.</li>
                <li><strong>Phí vận chuyển:</strong> Miễn phí toàn quốc.</li>
                <li><strong>Theo dõi đơn hàng:</strong> Sẽ có nhân viên liên hệ để trao đổi với bạn.</li>
            </ul>
        </section>

        <!-- Đổi Trả -->
        <section class="mb-5">
            <h3>4. Chính Sách Đổi Trả</h3>
            <p>
                Trong vòng 7 ngày kể từ khi nhận hàng, nếu sản phẩm có lỗi do nhà sản xuất hoặc sai màu, sai kích cỡ, 
                bạn có thể yêu cầu đổi/trả với điều kiện:
            </p>
            <ul>
                <li>Sản phẩm chưa qua sử dụng, còn nguyên tem mác, hộp, và bao bì đi kèm.</li>
                <li>Có hóa đơn, biên nhận hoặc thông báo xác nhận đơn hàng.</li>
                <li>Chi phí vận chuyển đổi/trả bên mua chịu trừ trường hợp lỗi do bên bán.</li>
            </ul>
        </section>

        <!-- Bảo Hành -->
        <section class="mb-5">
            <h3>5. Bảo Hành</h3>
            <p>
                Các sản phẩm thể thao không thuộc đối tượng bảo hành (vải, giày dép, phụ kiện…), 
                tuy nhiên nếu phát hiện lỗi kỹ thuật (rách chỉ, đế giày bung keo), liên hệ chúng tôi trong 30 ngày để được hỗ trợ.
            </p>
        </section>

        <!-- Liên Hệ -->
        <section>
            <h3>6. Liên Hệ Hỗ Trợ</h3>
            <p>Mọi thắc mắc về đặt hàng, thanh toán, vận chuyển hay đổi trả, vui lòng liên hệ:</p>
            <ul>
                <li>Email: <a href="mailto:support@itsport.vn">support@itsport.vn</a></li>
                <li>Hotline: <strong>1900 1234 (8:00–21:00)</strong></li>
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
