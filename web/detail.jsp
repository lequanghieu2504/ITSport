<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/detail.css" />
</head>

<body>
<jsp:include page="/common/header.jsp" />

<div class="container product-container">
    <div class="row">
        <div class="col-md-6 mb-4">
            <img src="${product.img_url}"
                 alt="${product.product_name}"
                 class="product-img" />
        </div>
        <div class="col-md-6 product-info">
            <h2>${product.product_name}</h2>
            <div class="product-price">${product.price}&#8363;</div>
            <div class="product-desc">${product.description}</div>

            <!-- Add to Cart -->
            <form action="MainController" method="post" class="mt-3">
                <input type="hidden" name="action" value="addToCart" />
                <input type="hidden" name="pid" value="${product.product_id}" />
                <input type="hidden" name="variant_id" id="variantIdInput" />

                <!-- Color -->
                <div class="form-group">
                    <label for="colorSelect">Chọn màu:</label>
                    <select class="form-control" id="colorSelect" name="color">
                        <c:forEach var="color" items="${colors}">
                            <option value="${color}">${color}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Size -->
                <div class="form-group">
                    <label for="sizeSelect">Chọn size:</label>
                    <select class="form-control" id="sizeSelect" name="size"></select>
                </div>

                <button type="submit" class="btn btn-cart">
                    <i class="fas fa-cart-plus mr-1"></i> Thêm vào giỏ hàng
                </button>
            </form>

            <!-- Mua Ngay button -->
            <button type="button"
                    class="btn btn-buy flex-fill mt-2"
                    data-toggle="modal"
                    data-target="#confirmModal"
                    onclick="prepareConfirm()">
                <i class="fas fa-shopping-cart mr-2"></i> Mua Ngay
            </button>
        </div>
    </div>
</div>

<!-- Modal Confirm -->
<div class="modal fade" id="confirmModal" tabindex="-1"
     role="dialog" aria-labelledby="confirmModalLabel"
     aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <form action="MainController" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="confirmModalLabel">
            Xác nhận đơn hàng
          </h5>
          <button type="button" class="close"
                  data-dismiss="modal">
            <span>&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>Sản phẩm: <strong>${product.product_name}</strong></p>
          <p>Màu: <strong><span id="confirmColor"></span></strong></p>
          <p>Size: <strong><span id="confirmSize"></span></strong></p>
          <p>Số lượng: <strong>1</strong></p>
          <p>Giá: <strong>${product.price}&#8363;</strong></p>
        </div>
        <div class="modal-footer">
          <input type="hidden" name="action"    value="buyNow"/>
          <input type="hidden" name="userId"
                 value="${sessionScope.user.user_id}"/>
          <input type="hidden" name="productId"
                 value="${product.product_id}"/>
          <input type="hidden" name="variantId"
                 id="modalVariantId"/>
          <input type="hidden" name="quantity"  value="1"/>
          <input type="hidden" name="priceEach"
                 value="${product.price}"/>
          <button type="button" class="btn btn-secondary"
                  data-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-primary">
            Xác nhận mua
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />
<jsp:include page="/common/popup.jsp" />

<!-- JS đặt cuối body, đúng thứ tự -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script>
    // JSON variants từ server
    const variants = ${variantListJson};
    const colorSelect    = document.getElementById('colorSelect');
    const sizeSelect     = document.getElementById('sizeSelect');
    const variantIdInput = document.getElementById('variantIdInput');

    function updateSizeOptions() {
        const clr = colorSelect.value;
        const sizes = variants
            .filter(v => v.color === clr)
            .map(v => v.size)
            .filter((s,i,a) => a.indexOf(s) === i);
        sizeSelect.innerHTML = '';
        sizes.forEach(s => {
            const opt = document.createElement('option');
            opt.value = s; opt.innerText = s;
            sizeSelect.appendChild(opt);
        });
        updateVariantId();
    }

    function updateVariantId() {
        const clr = colorSelect.value;
        const sz  = sizeSelect.value;
        const v = variants.find(v => v.color === clr && v.size === sz);
        const vid = v ? v.id : '';
        variantIdInput.value    = vid;
        document.getElementById('modalVariantId').value = vid;
        document.getElementById('confirmColor').innerText = clr;
        document.getElementById('confirmSize').innerText  = sz;
    }

    function prepareConfirm() {
        // Force cập nhật trước khi mở modal
        updateSizeOptions();
        // Debug: show modal manually nếu cần
        // $('#confirmModal').modal('show');
    }

    colorSelect.addEventListener('change', updateSizeOptions);
    sizeSelect.addEventListener('change', updateVariantId);
    document.addEventListener('DOMContentLoaded', updateSizeOptions);
</script>
</body>
</html>
