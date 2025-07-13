/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author SUPPER LOQ
 */
public class CartItemDTO {

    private int cart_item_id;
    private int cart_id;
    private int product_id;
    private int product_variant_id;
    private int quantity;
    private ProductDTO product;
    private ProductVariantDTO variant;

    public CartItemDTO() {
    }

    public CartItemDTO(int cart_item_id, int cart_id, int product_id, int product_variant_id, int quantity) {
        this.cart_item_id = cart_item_id;
        this.cart_id = cart_id;
        this.product_id = product_id;
        this.product_variant_id = product_variant_id;
        this.quantity = quantity;
    }

    public CartItemDTO(int cart_item_id, int cart_id, int product_id, int quantity, ProductDTO product) {
        this.cart_item_id = cart_item_id;
        this.cart_id = cart_id;
        this.product_id = product_id;
        this.quantity = quantity;
        this.product = product;
    }

    public CartItemDTO(int cart_item_id, int cart_id, int product_id, int product_variant_id, int quantity, ProductDTO product, ProductVariantDTO variant) {
        this.cart_item_id = cart_item_id;
        this.cart_id = cart_id;
        this.product_id = product_id;
        this.product_variant_id = product_variant_id;
        this.quantity = quantity;
        this.product = product;
        this.variant = variant;
    }

    public int getCart_item_id() {
        return cart_item_id;
    }

    public void setCart_item_id(int cart_item_id) {
        this.cart_item_id = cart_item_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public int getProduct_variant_id() {
        return product_variant_id;
    }

    public void setProduct_variant_id(int product_variant_id) {
        this.product_variant_id = product_variant_id;
    }

    public ProductVariantDTO getVariant() {
        return variant;
    }

    public void setVariant(ProductVariantDTO variant) {
        this.variant = variant;
    }

    @Override
    public String toString() {
        return "CartItemDTO{" + "cart_item_id=" + cart_item_id + ", cart_id=" + cart_id + ", product_id=" + product_id + ", product_variant_id=" + product_variant_id + ", quantity=" + quantity + '}';
    }

}
