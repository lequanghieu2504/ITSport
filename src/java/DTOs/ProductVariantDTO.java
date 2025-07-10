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
    private Long product_variant_id;
    private Long product_id;
    private Size size;
    private int quantity;
    private String sku;
    private String color;
    private List<ImageDTO> listImage;

    public ProductVariantDTO() {
    }

    public ProductVariantDTO(Long product_variant_id, Long product_id, Size size, int quantity, String sku) {
        this.product_variant_id = product_variant_id;
        this.product_id = product_id;
        this.size = size;
        this.quantity = quantity;
        this.sku = sku;
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
    
}
