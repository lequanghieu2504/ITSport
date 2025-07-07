/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.ProductDTO;
import jakarta.servlet.http.HttpServletRequest;
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

    public static ProductDTO toProductDTOFromRequest(HttpServletRequest request) {

        String product_name = request.getParameter("StrProductName");

        String description = request.getParameter("StrDescription");

        String price = request.getParameter("StrPrice");

        String img_url = request.getParameter("StrImgUrl");

        String category_id = request.getParameter("StrCategoryId");

        String brand_id = request.getParameter("StrBrandId");

        String status = request.getParameter("StrStatus");

        ProductDTO dto = new ProductDTO();

        dto.setProduct_name(product_name);
        dto.setDescription(description);

        if (price != null && !price.isEmpty()) {
            try {
                dto.setPrice(Double.parseDouble(price));
            } catch (NumberFormatException e) {
                dto.setPrice(0.0);
            }
        } else {
            dto.setPrice(0.0);
        }

        if (img_url != null) {
            dto.setImg_url(img_url);
        }
        if (category_id != null && !category_id.isEmpty()) {
            try {
                dto.setCategory_id(Integer.parseInt(category_id));
            } catch (NumberFormatException e) {
                dto.setCategory_id(0);
            }
        } else {
            dto.setCategory_id(0);
        }

        if (brand_id != null && !brand_id.isEmpty()) {
            try {
                dto.setBrand_id(Integer.parseInt(brand_id));
            } catch (NumberFormatException e) {
                dto.setBrand_id(0);
            }
        } else {
            dto.setBrand_id(0);
        }

        dto.setStatus(status != null && Boolean.parseBoolean(status));

        return dto;
    }
}
