/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;
import Enums.Status;
import Enums.PaymentMethod;
import java.time.LocalDateTime;


/**
 *
 * @author hieuh
 */
public class BuyingDTO {
    private Integer buyingId;
    private Integer userId;
    private Integer productId;
    private Integer variantId;
    private Integer quantity;
    private Double totalPrice;
    private Integer addressId;
    private PaymentMethod paymentMethod;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public BuyingDTO() {
    }

    public BuyingDTO(Integer buyingId, Integer userId, Integer productId, Integer variantId, Integer quantity, Double totalPrice, Integer addressId, PaymentMethod paymentMethod, Status status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.buyingId = buyingId;
        this.userId = userId;
        this.productId = productId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.addressId = addressId;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double price) {
        this.totalPrice = price;
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
