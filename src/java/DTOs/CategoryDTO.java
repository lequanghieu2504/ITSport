/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author ASUS
 */
public class CategoryDTO {
    private long category_id;
    private String category_name;
    private long parent_id;
    private String imageUrl;

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public CategoryDTO(long category_id, String category_name, long parent_id) {
        this.category_id = category_id;
        this.category_name = category_name;
        this.parent_id = parent_id;
    }

    public CategoryDTO() {
    }

    public long getCategory_id() {
        return category_id;
    }

    public void setCategory_id(long category_id) {
        this.category_id = category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public long getParent_id() {
        return parent_id;
    }

    public void setParent_id(long parent_id) {
        this.parent_id = parent_id;
    }

    @Override
    public String toString() {
        return "CategoryDTO{" + "category_id=" + category_id + ", category_name=" + category_name + ", parent_id=" + parent_id + '}';
    }
}
