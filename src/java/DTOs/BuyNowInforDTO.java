/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author ASUS
 */
public class BuyNowInforDTO {

    private long productId;
    private String productName;
    private String color;
    private String size;
    private int quantity;
    private double price;
    private double totalPrice;
    private long variantId;

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public long getVariantId() {
        return variantId;
    }

    public void setVariantId(long variantId) {
        this.variantId = variantId;
    }

    public BuyNowInforDTO() {
    }

    public BuyNowInforDTO(long productId, String productName, String color, String size, int quantity, double price, double totalPrice, long variantId) {
        this.productId = productId;
        this.productName = productName;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
        this.price = price;
        this.totalPrice = totalPrice;
        this.variantId = variantId;
    }
    
    
}
