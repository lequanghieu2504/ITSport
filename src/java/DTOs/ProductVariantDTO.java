/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

import Enums.Size;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ProductVariantDTO {

    private long product_variant_id;
    private long product_id;
    private Size size;
    private int quantity;
    private String sku;
    private String color;
    private List<ImageDTO> listImage;
    private ProductDTO product;

    public ProductVariantDTO() {
    }

    public ProductVariantDTO(Long product_variant_id, Long product_id, Size size, int quantity, String sku) {
        this.product_variant_id = product_variant_id;
        this.product_id = product_id;
        this.size = size;
        this.quantity = quantity;
        this.sku = sku;
    }

    public ProductVariantDTO(Long product_variant_id, Long product_id, Size size, int quantity, String sku, String color, ProductDTO product) {
        this.product_variant_id = product_variant_id;
        this.product_id = product_id;
        this.size = size;
        this.quantity = quantity;
        this.sku = sku;
        this.color = color;
        this.product = product;
    }

    public Long getProduct_variant_id() {
        return product_variant_id;
    }

    public void setProduct_variant_id(Long product_variant_id) {
        this.product_variant_id = product_variant_id;
    }

    public Long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Long product_id) {
        this.product_id = product_id;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public List<ImageDTO> getListImage() {
        return listImage;
    }

    public void setListImage(List<ImageDTO> listImage) {
        this.listImage = listImage;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "ProductVariantDTO{" + "product_variant_id=" + product_variant_id + ", product_id=" + product_id + ", size=" + size + ", quantity=" + quantity + ", sku=" + sku + ", color=" + color + '}';
    }
}
