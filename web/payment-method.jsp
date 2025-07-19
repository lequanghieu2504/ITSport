<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hình Thức Thanh Toán</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- CSS riêng -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/payment-methods.css"/>
</head>
<body>

    <!-- header -->
    <jsp:include page="/common/header.jsp"/>

    <main class="container my-5">
        <h1 class="text-center mb-4">Hình Thức Thanh Toán</h1>

        <div class="row">
            <!-- QR Code -->
            <div class="col-md-4 text-center mb-4">
                <div class="qr-box p-3 bg-white rounded shadow-sm">
                    <h5 class="mb-3">Quét QR để thanh toán</h5>
                    <!-- Thay src bằng đường dẫn ảnh QR thực tế -->
                    <img src="${pageContext.request.contextPath}/assets/images/qr-code.png" 
                         alt="QR Code" class="img-fluid"/>
                    <p class="mt-2 text-muted small">Hỗ trợ ví Momo, ZaloPay, VNPAY…</p>
                </div>
            </div>

            <!-- Chuyển khoản ngân hàng -->
            <div class="col-md-8">
                <div class="bg-white rounded shadow-sm p-4 mb-4">
                    <h5><i class="fa fa-university mr-2 text-primary"></i>Chuyển Khoản Ngân Hàng</h5>
                    <ul class="list-unstyled mt-2">
                        <li><strong>Ngân hàng:</strong> Coding Bank</li>
                        <li><strong>Chi nhánh:</strong> Sở Giao Dịch Hồ Chí Minh</li>
                        <li><strong>Số tài khoản:</strong> 0123 456 789</li>
                        <li><strong>Chủ tài khoản:</strong> CÔNG TY TNHH ITSPORT</li>
                    </ul>
                    <p class="mt-3 mb-0">
                        <strong>Cách thức:</strong>  
                        Sau khi chuyển khoản, vui lòng chụp màn hình xác nhận và gửi về Zalo/ZaloPay/SMS: <strong>0909 123 456</strong> hoặc email <a href="mailto:billing@itsport.vn">billing@itsport.vn</a> kèm nội dung:
                    </p>
                    <ul>
                        <li>Mã đơn hàng</li>
                        <li>Họ tên người chuyển</li>
                        <li>Số tiền đã chuyển</li>
                    </ul>
                </div>

                <!-- Thanh toán khi nhận hàng -->
                <div class="bg-white rounded shadow-sm p-4 mb-4">
                    <h5><i class="fa fa-truck mr-2 text-success"></i>Thanh Toán Khi Nhận Hàng (COD)</h5>
                    <p class="mb-0">
                        Khách hàng vui lòng không trả thêm bất kì phí gì.  
                        <br>
                        Nhân viên giao hàng sẽ thu tiền tận nơi.  
                        <br>
                        Quý khách vui lòng kiểm tra hàng trước khi thanh toán.
                    </p>
                </div>

                <!-- Ví điện tử / Gateway -->
                <div class="bg-white rounded shadow-sm p-4">
                    <h5><i class="fa fa-wallet mr-2 text-warning"></i>Ví Điện Tử &amp; Cổng Thanh Toán</h5>
                    <ul class="list-unstyled mt-2">
                        <li>Hỗ trợ: Momo, ZaloPay, VNPAY, VNPTPay…</li>
                        <li>Chọn “Thanh toán bằng ví” trên trang checkout, quét QR hoặc đăng nhập OTP để xác nhận.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Lưu ý pháp lý -->
        <section class="mt-5 text-center text-muted small">
            <p>
                Mọi giao dịch chuyển khoản và thanh toán đều tuân thủ quy định của Ngân hàng Nhà nước Việt Nam và Luật Giao dịch Điện tử.  
                ITSport cam kết bảo mật thông tin khách hàng theo Chính sách Bảo mật.
            </p>
        </section>
    </main>

    <!-- footer -->
    <jsp:include page="/common/footer.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
