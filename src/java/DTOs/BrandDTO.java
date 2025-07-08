/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author SUPPER LOQ
 */
public class BrandDTO {

    private int brandId;
    private String name;

    public BrandDTO() {
    }

    public BrandDTO(int brandId, String name) {
        this.brandId = brandId;
        this.name = name;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "BrandDTO{" + "brandId=" + brandId + ", name=" + name + '}';
    }
}
