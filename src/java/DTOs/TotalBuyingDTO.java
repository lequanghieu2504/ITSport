package DTOs;

import Enums.PaymentMethod;
import Enums.Status;
import java.time.LocalDateTime;
import java.util.List;

public class TotalBuyingDTO {

    private Long buyingId;
    private Long userId;
    private List<ItemDTO> items; // danh sách sản phẩm
    private Double totalPrice;
    private PaymentMethod paymentMethod;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ✅ Thêm các trường shipping mới:
    private String shippingName;
    private String shippingPhone;
    private String shippingStreet;
    private String shippingWard;
    private String shippingDistrict;
    private String shippingProvince;

    public TotalBuyingDTO() {
    }

    public TotalBuyingDTO(Long buyingId, Long userId, List<ItemDTO> items, Double totalPrice,
            PaymentMethod paymentMethod, Status status,
            LocalDateTime createdAt, LocalDateTime updatedAt,
            String shippingName, String shippingPhone,
            String shippingStreet, String shippingWard,
            String shippingDistrict, String shippingProvince) {
        this.buyingId = buyingId;
        this.userId = userId;
        this.items = items;
        this.totalPrice = totalPrice;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.shippingName = shippingName;
        this.shippingPhone = shippingPhone;
        this.shippingStreet = shippingStreet;
        this.shippingWard = shippingWard;
        this.shippingDistrict = shippingDistrict;
        this.shippingProvince = shippingProvince;
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

    public String getShippingName() {
        return shippingName;
    }

    public void setShippingName(String shippingName) {
        this.shippingName = shippingName;
    }

    public String getShippingPhone() {
        return shippingPhone;
    }

    public void setShippingPhone(String shippingPhone) {
        this.shippingPhone = shippingPhone;
    }

    public String getShippingStreet() {
        return shippingStreet;
    }

    public void setShippingStreet(String shippingStreet) {
        this.shippingStreet = shippingStreet;
    }

    public String getShippingWard() {
        return shippingWard;
    }

    public void setShippingWard(String shippingWard) {
        this.shippingWard = shippingWard;
    }

    public String getShippingDistrict() {
        return shippingDistrict;
    }

    public void setShippingDistrict(String shippingDistrict) {
        this.shippingDistrict = shippingDistrict;
    }

    public String getShippingProvince() {
        return shippingProvince;
    }

    public void setShippingProvince(String shippingProvince) {
        this.shippingProvince = shippingProvince;
    }
}
