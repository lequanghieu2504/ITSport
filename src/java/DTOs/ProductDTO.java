/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author ASUS
 */
public class ProductDTO {
    private Long product_id;
    private String product_name;
    private String description;
    private double price;
    private String img_url;
    private long category_id;
    private long brand_id;
    private boolean status;
    
    //chi set khi can thiet
    private String brand_name;
    private String category_name;
  
    public ProductDTO() {
    }

    public ProductDTO(Long product_id, String product_name, String description, double price, String img_url, long category_id, long brand_id, boolean status) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.description = description;
        this.price = price;
        this.img_url = img_url;
        this.category_id = category_id;
        this.brand_id = brand_id;
        this.status = status;
    }

    public ProductDTO(Long product_id, String product_name, String description, double price, String img_url, long category_id, long brand_id, boolean status, String category_name) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.description = description;
        this.price = price;
        this.img_url = img_url;
        this.category_id = category_id;
        this.brand_id = brand_id;
        this.status = status;
        this.category_name = category_name;
    }

    public Long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Long product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    public long getCategory_id() {
        return category_id;
    }

    public void setCategory_id(long category_id) {
        this.category_id = category_id;
    }

    public long getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(long brand_id) {
        this.brand_id = brand_id;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getBrand_name() {
        return brand_name;
    }

    public void setBrand_name(String brand_name) {
        this.brand_name = brand_name;
    }
    
    
}
