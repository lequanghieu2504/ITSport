/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author hieuh
 */
public class ItemDTO {

    private Integer productId;
    private Integer variantId;
    private Integer quantity;
    private Double priceEach;
    private long cartItemId;
    private String productName;

    public long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public ItemDTO(int productId, int variantId, int quantity, double priceEach) {
        this.productId = productId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.priceEach = priceEach;
    }

    // getter/setter cũ...
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

public ItemDTO(Integer productId, Integer variantId, Integer quantity, Double priceEach) {
        this.productId = productId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.priceEach = priceEach;
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
