<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
        <style>
            .product-img {
                width: 100%;
                max-height: 500px;
                object-fit: contain;
                border: 1px solid #ddd;
                margin-bottom: 15px;
            }
            .variant-thumb {
                cursor: pointer;
                border: 2px solid #eee;
                width: 100%;
                height: auto;
            }
            .variant-thumb:hover {
                border: 2px solid #3498db;
            }
            .filter-option {
                display: inline-block;
                margin: 5px;
                padding: 8px 16px;
                border: 2px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                color: #333;
                background-color: #fff;
                transition: all 0.3s ease;
            }
            .filter-option:hover {
                border-color: #3498db;
                text-decoration: none;
                color: #3498db;
            }
            .filter-option.active {
                border-color: #3498db;
                background-color: #3498db;
                color: #fff;
            }
            .filter-section {
                margin-bottom: 20px;
            }
            .filter-title {
                font-weight: bold;
                margin-bottom: 10px;
            }
            .clear-filter {
                color: #dc3545;
                font-size: 14px;
                margin-left: 10px;
            }
            .d-flex {
                display: flex;
            }
            .gap-2 {
                gap: 0.5rem;
            }
            .mr-2 {
                margin-right: 0.5rem;
            }
            .required-selection {
                color: #dc3545;
                font-size: 14px;
                margin-top: 5px;
            }
            .selection-warning {
                background-color: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 15px;
                color: #856404;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/common/header.jsp"/>
        <div class="container my-5">
            <div class="row">
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
                    
                    <!-- Thông tin variants hiện tại -->
                    <div class="mt-3">
                        <p><strong>Số lượng có sẵn:</strong> 
                            <c:set var="totalQuantity" value="0"/>
                            <c:forEach var="variant" items="${variantList}">
                                <c:set var="totalQuantity" value="${totalQuantity + variant.quantity}"/>
                            </c:forEach>
                            ${totalQuantity} sản phẩm
                        </p>
                    </div>
                    
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
                        <form action="MainController" method="post" class="mr-2" onsubmit="return validateSelection('cart')">
                            <input type="hidden" name="action" value="addToCart"/>
                            <input type="hidden" name="pid" value="${product.product_id}"/>
                            <input type="hidden" name="color" value="${selectedColor}"/>
                            <input type="hidden" name="size" value="${selectedSize}"/>
                            <input type="hidden" name="quantity" id="cartQuantity" value="1"/>
                            
                            <button type="submit" class="btn btn-outline-primary" ${canPurchase ? '' : 'disabled'}>
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
                            
                            <button type="submit" class="btn btn-primary btn-lg" ${canPurchase ? '' : 'disabled'}>
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
            
            <!-- Danh sách variants chi tiết -->
            <div class="row mt-5">
                <div class="col-12">
                    <h4>Chi tiết variants</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>SKU</th>
                                    <th>Màu sắc</th>
                                    <th>Kích thước</th>
                                    <th>Số lượng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="variant" items="${variantList}">
                                    <tr>
                                        <td>${variant.sku}</td>
                                        <td>${variant.color}</td>
                                        <td>${variant.size}</td>
                                        <td>${variant.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="/common/footer.jsp"/>
        
        <script>
            function changeMainImage(thumb) {
                const mainImg = document.getElementById('mainProductImg');
                // Lưu URL hiện tại của main
                const mainSrc = mainImg.src;
                // Hoán đổi src
                mainImg.src = thumb.src;
                // Đổi lại ảnh thumb thành main cũ
                thumb.src = mainSrc;
            }
            
            // Sync quantity giữa 2 forms
            document.getElementById('quantity').addEventListener('change', function() {
                const quantity = this.value;
                document.getElementById('cartQuantity').value = quantity;
                document.getElementById('buyQuantity').value = quantity;
            });
            
            // Validate selection trước khi submit
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
                    alert("Vui lòng chọn " + missingSelections.join(" và ") + " trước khi " + 
                          (action === 'buy' ? 'mua hàng' : 'thêm vào giỏ hàng') + "!");
                    return false;
                }
                
                return true;
            }
        </script>
    </body>
</html>