<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Hồ sơ cá nhân | ITSPORT</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              crossorigin="anonymous">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css"/>

        <style>
            .toggle-icon {
                transition: transform 0.3s ease;
            }
            .rotate {
                transform: rotate(180deg);
            }
        </style>

        <!-- jQuery + Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        crossorigin="anonymous"></script>
    </head>

    <body>

        <jsp:include page="/common/header.jsp"/>

        <div class="profile-page">
            <div class="profile-container">
                <div class="profile-header">
                    <i class="fa fa-user-circle"></i>
                    <h2>Hồ sơ của bạn</h2>
                </div>

                <div class="profile-info">
                    <div class="info-item">
                        <i class="fa fa-id-badge"></i>
                        <span><strong>Họ và tên:</strong> ${sessionScope.user.fullName}</span>
                    </div>

                    <div class="info-item">
                        <i class="fa fa-user"></i>
                        <span><strong>Tên đăng nhập:</strong> ${sessionScope.user.username}</span>
                    </div>

                    <c:if test="${not empty sessionScope.user.email}">
                        <div class="info-item">
                            <i class="fa fa-envelope"></i>
                            <span><strong>Email:</strong> ${sessionScope.user.email}</span>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Danh sách địa chỉ giao hàng -->
            <!-- Danh sách địa chỉ giao hàng -->
            <c:if test="${not empty requestScope.userBuyingInfoList}">
                <div class="profile-container mt-4">
                    <div class="profile-header">
                        <i class="fa fa-truck"></i>
                        <h2>Địa chỉ giao hàng</h2>
                    </div>

                    <div class="profile-info">
                        <c:forEach var="info" items="${requestScope.userBuyingInfoList}" varStatus="status">
                            <!-- Hàng tóm tắt -->
                            <div class="info-item d-flex justify-content-between align-items-center"
                                 data-toggle="collapse"
                                 data-target="#collapse${status.index}"
                                 aria-expanded="false"
                                 aria-controls="collapse${status.index}"
                                 style="cursor: pointer;">
                                <div>
                                    <i class="fa fa-user"></i>
                                    <span><strong>${info.recipientName}</strong></span>
                                    <br>
                                    <small style="color: #888;">
                                        ${info.street}, ${info.ward}, ${info.district}, ${info.province}
                                    </small>
                                </div>
                                <i class="fa fa-caret-down toggle-icon" id="icon${status.index}"></i>
                            </div>

                            <!-- Nội dung chi tiết -->
                            <div class="collapse mt-2" id="collapse${status.index}">
                                <div class="info-item">
                                    <i class="fa fa-map-marker-alt"></i>
                                    <span><strong>Địa chỉ chi tiết:</strong>
                                        ${info.street}, ${info.ward}, ${info.district}, ${info.province}
                                    </span>
                                </div>

                                <div class="info-item">
                                    <i class="fa fa-phone"></i>
                                    <span><strong>Điện thoại:</strong> ${info.phone}</span>
                                </div>

                                <!-- Nút hành động -->
                                <div class="info-item d-flex justify-content-end">
                                    <button class="btn btn-sm btn-outline-primary mr-2">
                                        <i class="fa fa-edit"></i> Sửa
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="fa fa-trash"></i> Xóa
                                    </button>
                                </div>
                            </div>
                            <hr style="border: 0; border-top: 1px solid #ddd; margin: 20px 0;">
                        </c:forEach>
                    </div>
                </div>
            </c:if>

        </div>

        <jsp:include page="/common/footer.jsp"/>

        <script>
            // Gắn sự kiện cho tất cả .collapse
            $('.collapse').on('show.bs.collapse', function () {
                var id = $(this).attr('id').replace('collapse', '');
                $('#icon' + id).addClass('rotate');
            }).on('hide.bs.collapse', function () {
                var id = $(this).attr('id').replace('collapse', '');
                $('#icon' + id).removeClass('rotate');
            });
        </script>


    </body>
</html>
