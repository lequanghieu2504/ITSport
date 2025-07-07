/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.ProductDTO;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class ProductMapper {

    public static ProductDTO toProductDTOFromResultSet(ResultSet rs) throws SQLException {
        Long product_id = rs.getLong("product_id");
        String product_name = rs.getString("product_name");
        String description = rs.getString("description");
        double price = rs.getDouble("price");
        String img_url = rs.getString("img_url");
        int category_id = rs.getInt("category_id");
        int brand_id = rs.getInt("brand_id");
        boolean status = rs.getBoolean("status");

        // Tạo ProductDTO
        ProductDTO product = new ProductDTO();
        product.setProduct_id(product_id);
        product.setProduct_name(product_name);
        product.setDescription(description);
        product.setPrice(price);
        product.setImg_url(img_url);
        product.setCategory_id(category_id);
        product.setBrand_id(brand_id);
        product.setStatus(status);

        return product;
    }

}
