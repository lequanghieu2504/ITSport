/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

/**
 *
 * @author ASUS
 */
public class ImageConfig {


    public static final String BASE_IMAGE_PATH = "/images";

    public static String getFolderByType(String imageType) {
        if (imageType == null) {
            return "/others";
        }

        switch (imageType) {
            case "PRODUCT_MAIN":
                return "/product/main";
            case "PRODUCT_VARIANT":
                return "/product/variant";
            case "CATEGORY":
                return "/category";
            case "BRAND":
                return "/brand";
            default:
                return "/others";
        }
    }
    
}
