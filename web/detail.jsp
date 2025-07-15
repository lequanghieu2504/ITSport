<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detail.css"/>
    </head>
    <body>
        <jsp:include page="/common/header.jsp"/>

        <main>
            <div class="container my-5">
                <div class="row mb-3">
                    <!-- Ảnh chính + Gallery -->
                    <div class="col-md-6">
                        <img id="mainProductImg"
                             src="${pageContext.request.contextPath}/${mainImage.file_name}"
                             alt="${product.product_name}" class="product-img"/>
                        <div class="row">
                            <c:forEach var="img" items="${variantImageList}">
                                <div class="col-3 mb-2">
                                    <img src="${pageContext.request.contextPath}/${img.file_name}"
                                         alt="Variant"
                                         class="variant-thumb"
                                         onclick="changeMainImage(this)"/>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Thông tin sản phẩm -->
                    <div class="col-md-6">
                        <h2>${product.product_name}</h2>
                        <h4 class="text-danger">${product.price} &#8363;</h4>
                        <p>${product.description}</p>

                        <!-- Cảnh báo nếu chưa chọn đủ màu/size -->
                        <c:if test="${(not empty availableColors and empty selectedColor) or (not empty availableSizes and empty selectedSize)}">
                            <div class="selection-warning">
                                <strong>Lưu ý:</strong> Vui lòng chọn 
                                <c:if test="${not empty availableColors and empty selectedColor}">màu sắc</c:if>
                                <c:if test="${(not empty availableColors and empty selectedColor) and (not empty availableSizes and empty selectedSize)}"> và </c:if>
                                <c:if test="${not empty availableSizes and empty selectedSize}">kích thước</c:if>
                                    để có thể mua hàng.
                                </div>
                        </c:if>

                        <!-- Filter Color -->
                        <c:if test="${not empty availableColors}">
                            <div class="filter-section">
                                <div class="filter-title">
                                    Màu sắc: <span class="text-danger">*</span>
                                    <c:if test="${not empty selectedColor}">
                                        <a href="MainController?action=viewDetailProduct&pid=${pid}" class="clear-filter">
                                            (Xóa bộ lọc)
                                        </a>
                                    </c:if>
                                </div>
                                <c:forEach var="color" items="${availableColors}">
                                    <a href="MainController?action=viewDetailProduct&pid=${pid}&color=${color}<c:if test='${not empty selectedSize}'>&size=${selectedSize}</c:if>"
                                       class="filter-option ${selectedColor eq color ? 'active' : ''}">
                                        ${color}
                                    </a>
                                </c:forEach>
                                <c:if test="${empty selectedColor}">
                                    <div class="required-selection">Vui lòng chọn màu sắc</div>
                                </c:if>
                            </div>
                        </c:if>

                        <!-- Filter Size -->
                        <c:if test="${not empty availableSizes}">
                            <div class="filter-section">
                                <div class="filter-title">
                                    Kích thước: <span class="text-danger">*</span>
                                    <c:if test="${not empty selectedSize}">
                                        <a href="MainController?action=viewDetailProduct&pid=${pid}<c:if test='${not empty selectedColor}'>&color=${selectedColor}</c:if>" class="clear-filter">
                                                (Xóa bộ lọc)
                                            </a>
                                    </c:if>
                                </div>
                                <c:forEach var="size" items="${availableSizes}">
                                    <a href="MainController?action=viewDetailProduct&pid=${pid}&size=${size}<c:if test='${not empty selectedColor}'>&color=${selectedColor}</c:if>"
                                       class="filter-option ${selectedSize eq size ? 'active' : ''}">
                                        ${size}
                                    </a>
                                </c:forEach>
                                <c:if test="${empty selectedSize}">
                                    <div class="required-selection">Vui lòng chọn kích thước</div>
                                </c:if>
                            </div>
                        </c:if>

                        <p><strong>Số lượng có sẵn:</strong> 
                            <c:choose>
                                <c:when test="${not empty selectedVariant}">
                                    ${selectedVariant.quantity} sản phẩm
                                </c:when>
                                <c:otherwise>
                                    <c:set var="totalQuantity" value="0"/>
                                    <c:forEach var="variant" items="${variantList}">
                                        <c:set var="totalQuantity" value="${totalQuantity + variant.quantity}"/>
                                    </c:forEach>
                                    ${totalQuantity} sản phẩm
                                </c:otherwise>
                            </c:choose>
                        </p>


                        <!-- Form thêm giỏ hàng và mua ngay -->
                        <div class="form-group">
                            <label for="quantity">Số lượng:</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" value="1" min="1" max="${totalQuantity}" style="width: 100px;">
                        </div>

                        <!-- Kiểm tra điều kiện cho phép mua -->
                        <c:set var="canPurchase" value="true"/>
                        <c:if test="${not empty availableColors and empty selectedColor}">
                            <c:set var="canPurchase" value="false"/>
                        </c:if>
                        <c:if test="${not empty availableSizes and empty selectedSize}">
                            <c:set var="canPurchase" value="false"/>
                        </c:if>
                        <c:if test="${totalQuantity <= 0}">
                            <c:set var="canPurchase" value="false"/>
                        </c:if>

                        <div class="d-flex gap-2">
                            <!-- Form thêm giỏ hàng -->
                            <form id="addToCartForm" class="mr-2" onsubmit="return addToCartAjax(event)">
                                <input type="hidden" name="action" value="addToCart"/>
                                <input type="hidden" name="product_id" value="${product.product_id}"/>
                                <c:if test="${not empty selectedVariant}">
                                    <input type="hidden" name="variant_id" value="${selectedVariant.product_variant_id}"/>
                                </c:if>
                                <input type="hidden" name="color" value="${selectedColor}"/>
                                <input type="hidden" name="quantity" id="cartQuantity" value="1"/>

                                <button type="submit"
                                        class="btn btn-cart btn-purchase"
                                        ${canPurchase ? '' : 'disabled'}>
                                    <c:choose>
                                        <c:when test="${totalQuantity <= 0}">Hết hàng</c:when>
                                        <c:when test="${not canPurchase}">Chọn màu/size</c:when>
                                        <c:otherwise>Thêm vào giỏ hàng</c:otherwise>
                                    </c:choose>
                                </button>
                            </form>


                            <!-- Form mua ngay -->
                            <form action="MainController" method="post" onsubmit="return validateSelection('buy')">
                                <input type="hidden" name="action" value="buyNow"/>
                                <input type="hidden" name="StrProductId" value="${product.product_id}"/>
                                <input type="hidden" name="StrColor" value="${selectedColor}"/>
                                <input type="hidden" name="StrSize" value="${selectedSize}"/>
                                <input type="hidden" name="StrQuantity" id="buyQuantity" value="1"/>

                                <button type="submit"
                                        class="btn btn-buy btn-purchase"
                                        ${canPurchase ? '' : 'disabled'}>
                                    <c:choose>
                                        <c:when test="${totalQuantity <= 0}">Hết hàng</c:when>
                                        <c:when test="${not canPurchase}">Chọn màu/size</c:when>
                                        <c:otherwise>Mua ngay</c:otherwise>
                                    </c:choose>
                                </button>
                            </form>
                        </div>

                    </div>
                </div>
        </main>

        <script>
            function changeMainImage(thumb) {
                const mainImg = document.getElementById('mainProductImg');
                const mainSrc = mainImg.src;
                mainImg.src = thumb.src;
                thumb.src = mainSrc;
            }

            // Đồng bộ số lượng giữa các form
            document.getElementById('quantity').addEventListener('change', function () {
                const quantity = this.value;
                document.getElementById('cartQuantity').value = quantity;
                document.getElementById('buyQuantity').value = quantity;
            });

            // Kiểm tra đã chọn màu và size chưa
            function validateSelection(action) {
                const selectedColor = "${selectedColor}";
                const selectedSize = "${selectedSize}";
                const hasColors = ${not empty availableColors};
                const hasSizes = ${not empty availableSizes};

                let missingSelections = [];

                if (hasColors && !selectedColor) {
                    missingSelections.push("màu sắc");
                }

                if (hasSizes && !selectedSize) {
                    missingSelections.push("kích thước");
                }

                if (missingSelections.length > 0) {
                    showToast("Vui lòng chọn " + missingSelections.join(" và ") + " trước khi " +
                            (action === 'buy' ? 'mua hàng' : 'thêm vào giỏ hàng') + "!");
                    return false;
                }

                return true;
            }

            // Gửi form thêm giỏ hàng bằng ajax
            function addToCartAjax(event) {
                event.preventDefault();

                const form = document.getElementById("addToCartForm");
                const formData = new FormData(form);

                fetch("MainController", {
                    method: "POST",
                    body: formData
                })
                        .then(response => {
                            if (response.status === 401) {
                                window.location.href = "login.jsp";
                                return;
                            }

                            if (!response.ok)
                                throw new Error("Lỗi khi thêm giỏ hàng");
                            return response.text();
                        })
                        .then(data => {
                            showToast("Đã thêm vào giỏ hàng!");
                            updateCartIcon();
                        })
                        .catch(error => {
                            console.error(error);
                            showToast("Có lỗi xảy ra khi thêm giỏ hàng!");
                        });

                return false;
            }

            // Cập nhật số lượng giỏ hàng ở icon
            function updateCartIcon() {
                fetch("MainController?action=getCartSize")
                        .then(response => response.json())
                        .then(data => {
                            const cartIcon = document.getElementById("cart-size");
                            if (cartIcon)
                                cartIcon.textContent = data.size;
                        });
            }

            // Hiển thị popup toast
            function showToast(message) {
                let toast = document.getElementById("toast-message");

                if (!toast) {
                    toast = document.createElement("div");
                    toast.id = "toast-message";
                    toast.className = "toast";
                    document.body.appendChild(toast);
                }

                toast.textContent = message;
                toast.style.opacity = "1";
                toast.style.transform = "translateY(0)";

                setTimeout(() => {
                    toast.style.opacity = "0";
                    toast.style.transform = "translateY(-20px)";
                    setTimeout(() => toast.remove(), 500);
                }, 3000);
            }
        </script>
        <jsp:include page="/common/popup.jsp" />

        <div>
            <jsp:include page="/common/footer.jsp" />
        </div>
    </body>
</html>

