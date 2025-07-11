package DTOs;

import Enums.PaymentMethod;
import Enums.Status;
import java.time.LocalDateTime;
import java.util.List;

public class TotalBuyingDTO {
    private Long buyingId;
    private Long userId;
    private List<ItemDTO> items;           // danh sách sản phẩm (1 phần tử nếu mua ngay)
    private Double totalPrice;
    private Long addressId;
    private PaymentMethod paymentMethod;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public TotalBuyingDTO() {
    }

    public TotalBuyingDTO(Long buyingId, Long userId, List<ItemDTO> items, Double totalPrice, Long addressId, PaymentMethod paymentMethod, Status status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.buyingId = buyingId;
        this.userId = userId;
        this.items = items;
        this.totalPrice = totalPrice;
        this.addressId = addressId;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getBuyingId() {
        return buyingId;
    }

    public void setBuyingId(Long buyingId) {
        this.buyingId = buyingId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public List<ItemDTO> getItems() {
        return items;
    }

    public void setItems(List<ItemDTO> items) {
        this.items = items;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
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
