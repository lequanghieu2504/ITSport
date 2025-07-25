<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Về Chúng Tôi</title>
    <!-- Bootstrap CSS (nếu bạn đã include chung rồi thì có thể bỏ) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- CSS riêng của bạn -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/aboutUs.css"/>
    
</head>
<body>

    <!-- include header -->
    <jsp:include page="/common/header.jsp"/>

    <main class="container my-5">
        <h1 class="text-center mb-4">Về Chúng Tôi</h1>

        <section class="mb-5">
            <h3>Chúng Tôi Là Ai?</h3>
            <p>
                Chào mừng bạn đến với <strong>ITSport</strong> – nơi hội tụ đầy đủ trang phục và phụ kiện thể thao cho mọi lứa tuổi và phong cách. 
                Từ quần áo tập gym, giày chạy bộ đến balo, mũ nón, chúng tôi luôn chọn lọc sản phẩm chất lượng, đa dạng mẫu mã.
            </p>
        </section>

        <section class="mb-5">
            <h3>Sứ Mệnh &amp; Tầm Nhìn</h3>
            <ul>
                <li><strong>Sứ mệnh:</strong> Mang đến trải nghiệm mua sắm thể thao nhanh chóng, chuyên nghiệp và thân thiện.</li>
                <li><strong>Tầm nhìn:</strong> Trở thành thương hiệu tiên phong trong cộng đồng yêu thể thao Việt Nam.</li>
            </ul>
        </section>

        <section class="mb-5">
            <h3>Giá Trị Cốt Lõi</h3>
            <div class="row">
                <div class="col-md-4">
                    <i class="fa fa-check-circle fa-2x mb-2 text-success"></i>
                    <h5>Chất Lượng</h5>
                    <p>Chỉ hợp tác với nhà sản xuất uy tín, kiểm định nghiêm ngặt trước khi bán ra.</p>
                </div>
                <div class="col-md-4">
                    <i class="fa fa-bolt fa-2x mb-2 text-warning"></i>
                    <h5>Đổi Mới</h5>
                    <p>Luôn cập nhật xu hướng và công nghệ vải mới nhất.</p>
                </div>
                <div class="col-md-4">
                    <i class="fa fa-heart fa-2x mb-2 text-danger"></i>
                    <h5>Chân Thành</h5>
                    <p>Lắng nghe khách hàng để phục vụ chu đáo, tận tâm.</p>
                </div>
            </div>
        </section>

        <section>
            <h3>Liên Hệ Với Chúng Tôi</h3>
            <p>Nếu bạn có bất kỳ thắc mắc hay góp ý nào, vui lòng liên hệ:</p>
            <ul>
                <li>Email: <a href="mailto:info@itsport.vn">info@itsport.vn</a></li>
                <li>Hotline: <strong>1900 1234</strong></li>
                <li>Địa chỉ: 123 Phố Thể Thao, Quận 1, TP. Hồ Chí Minh</li>
            </ul>
        </section>
    </main>

    <!-- include footer (nếu có) -->
    <jsp:include page="/common/footer.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
