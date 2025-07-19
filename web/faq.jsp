<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>FAQ – Câu Hỏi Thường Gặp</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- CSS riêng -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/faq.css"/>
</head>
<body>

    <!-- header -->
    <jsp:include page="/common/header.jsp"/>

    <main class="container my-5">
        <h1 class="text-center mb-4">Câu Hỏi Thường Gặp (FAQ)</h1>
        <div id="faqAccordion">
            <!-- 1 -->
            <div class="card mb-3">
                <div class="card-header" id="headingOne">
                    <h5 class="mb-0">
                        <button class="btn btn-link text-left w-100" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            1. Làm sao để đặt hàng trên ITSport?
                        </button>
                    </h5>
                </div>
                <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#faqAccordion">
                    <div class="card-body">
                        Bạn thêm sản phẩm vào giỏ, kiểm tra giỏ hàng, điền thông tin giao nhận và thanh toán là hoàn tất đặt hàng.
                    </div>
                </div>
            </div>
            <!-- 2 -->
            <div class="card mb-3">
                <div class="card-header" id="headingTwo">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            2. ITSport có hỗ trợ đổi trả không?
                        </button>
                    </h5>
                </div>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#faqAccordion">
                    <div class="card-body">
                        Chúng tôi hỗ trợ đổi/trả trong 7 ngày nếu sản phẩm còn nguyên tem, còn hóa đơn và lỗi do nhà sản xuất.
                    </div>
                </div>
            </div>
            <!-- 3 -->
            <div class="card mb-3">
                <div class="card-header" id="headingThree">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            3. Thời gian giao hàng mất bao lâu?
                        </button>
                    </h5>
                </div>
                <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#faqAccordion">
                    <div class="card-body">
                        Thời gian xử lý đơn 1–2 ngày, giao hàng 2–5 ngày tuỳ khu vực bạn sinh sống.
                    </div>
                </div>
            </div>
            <!-- 4 -->
            <div class="card mb-3">
                <div class="card-header" id="headingFour">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                            4. Phương thức thanh toán nào được hỗ trợ?
                        </button>
                    </h5>
                </div>
                <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#faqAccordion">
                    <div class="card-body">
                        Hỗ trợ COD, chuyển khoản ngân hàng, VNPAY, Momo, ZaloPay (tuỳ thời điểm).
                    </div>
                </div>
            </div>
            <!-- 5 -->
            <div class="card mb-3">
                <div class="card-header" id="headingFive">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                            5. Làm sao để chọn size quần áo phù hợp?
                        </button>
                    </h5>
                </div>
                <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#faqAccordion">
                    <div class="card-body">
                        Bạn tham khảo bảng kích thước đi kèm mỗi sản phẩm, đo số đo cơ thể (ngực – eo – mông) theo hướng dẫn và so sánh để chọn size sát nhất.
                    </div>
                </div>
            </div>
            <!-- 6 -->
            <div class="card mb-3">
                <div class="card-header" id="headingSix">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                            6. Giày thể thao có đổi size được không?
                        </button>
                    </h5>
                </div>
                <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#faqAccordion">
                    <div class="card-body">
                        Có. Nếu giày không vừa, bạn có 7 ngày để đổi size (chưa qua sử dụng, còn nguyên hộp và tem mác).
                    </div>
                </div>
            </div>
            <!-- 7 -->
            <div class="card mb-3">
                <div class="card-header" id="headingSeven">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                            7. Sản phẩm tại ITSport có phải chính hãng?
                        </button>
                    </h5>
                </div>
                <div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#faqAccordion">
                    <div class="card-body">
                        Tất cả đều là hàng chính hãng – chúng tôi cam kết chỉ nhập từ nhà phân phối ủy quyền và kiểm định chất lượng.
                    </div>
                </div>
            </div>
            <!-- 8 -->
            <div class="card mb-3">
                <div class="card-header" id="headingEight">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
                            8. Chất liệu vải có thoáng mát không?
                        </button>
                    </h5>
                </div>
                <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#faqAccordion">
                    <div class="card-body">
                        Chúng tôi sử dụng vải công nghệ cao (dry-fit, mesh) giúp thấm hút mồ hôi và thoáng khí tối ưu khi tập luyện.
                    </div>
                </div>
            </div>
            <!-- 9 -->
            <div class="card mb-3">
                <div class="card-header" id="headingNine">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
                            9. Làm sao vệ sinh giày thể thao đúng cách?
                        </button>
                    </h5>
                </div>
                <div id="collapseNine" class="collapse" aria-labelledby="headingNine" data-parent="#faqAccordion">
                    <div class="card-body">
                        Dùng bàn chải mềm và xà phòng nhẹ, làm ướt nhẹ, chải sạch, sau đó phơi nơi thoáng – tránh ánh nắng trực tiếp.
                    </div>
                </div>
            </div>
            <!-- 10 -->
            <div class="card mb-3">
                <div class="card-header" id="headingTen">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#collapseTen" aria-expanded="false" aria-controls="collapseTen">
                            10. Phụ kiện thể thao nào đang được ưa chuộng?
                        </button>
                    </h5>
                </div>
                <div id="collapseTen" class="collapse" aria-labelledby="headingTen" data-parent="#faqAccordion">
                    <div class="card-body">
                        Đai lưng tập gym, găng tay chống trượt, tất thể thao compression, băng đô thấm mồ hôi… là những món hot gần đây.
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- footer -->
    <jsp:include page="/common/footer.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
