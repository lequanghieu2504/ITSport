package DTOs;

import Enums.PaymentMethod;
import Enums.Status;
import java.time.LocalDateTime;
import java.util.List;

public class BuyingDTO {
    private Integer buyingId;
    private Integer userId;
    private List<Item> items;           // danh sách sản phẩm (1 phần tử nếu mua ngay)
    private Double totalPrice;
    private Integer addressId;
    private PaymentMethod paymentMethod;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Inner class để chứa từng dòng hàng
    public static class Item {
        private Integer productId;
        private Integer variantId;
        private Integer quantity;
        private Double priceEach;

        public Item(Integer productId, Integer variantId, Integer quantity, Double priceEach) {
            this.productId  = productId;
            this.variantId  = variantId;
            this.quantity   = quantity;
            this.priceEach  = priceEach;
        }

        public Integer getProductId() {
            return productId;
        }

        public void setProductId(Integer productId) {
            this.productId = productId;
        }

        public Integer getVariantId() {
            return variantId;
        }

        public void setVariantId(Integer variantId) {
            this.variantId = variantId;
        }

        public Integer getQuantity() {
            return quantity;
        }

        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }

        public Double getPriceEach() {
            return priceEach;
        }

        public void setPriceEach(Double priceEach) {
            this.priceEach = priceEach;
        }
       
    }

    public BuyingDTO(Integer buyingId,
                     Integer userId,
                     List<Item> items,
                     Double totalPrice,
                     Integer addressId,
                     PaymentMethod paymentMethod,
                     Status status,
                     LocalDateTime createdAt,
                     LocalDateTime updatedAt) {
        this.buyingId      = buyingId;
        this.userId        = userId;
        this.items         = items;
        this.totalPrice    = totalPrice;
        this.addressId     = addressId;
        this.paymentMethod = paymentMethod;
        this.status        = status;
        this.createdAt     = createdAt;
        this.updatedAt     = updatedAt;
    }

    public BuyingDTO() {
    }

    public Integer getBuyingId() {
        return buyingId;
    }

    public void setBuyingId(Integer buyingId) {
        this.buyingId = buyingId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
}
