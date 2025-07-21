/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.ProductDTO;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        int category_id = rs.getInt("category_id");
        int brand_id = rs.getInt("brand_id");
        boolean status = rs.getBoolean("status");
        String url_Main_Product_Image = rs.getString("img_url");

        // Tạo ProductDTO
        ProductDTO product = new ProductDTO();
        product.setProduct_id(product_id);
        product.setProduct_name(product_name);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategory_id(category_id);
        product.setBrand_id(brand_id);
        product.setStatus(status);
        if(url_Main_Product_Image==null||url_Main_Product_Image.trim().isEmpty()){
            product.setImg_url("images/default.jpg");
        }
        else{
            product.setImg_url(url_Main_Product_Image);
        }
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

    public static ProductDTO toProductDTOFromRequestWithName(ResultSet rs) {
        try {
            ProductDTO dto = new ProductDTO();
            dto.setProduct_id(rs.getLong("product_id"));

            dto.setProduct_name(rs.getString("product_name"));
            dto.setDescription(rs.getString("description"));
            dto.setPrice(rs.getDouble("price"));
            dto.setStatus(rs.getInt("status") == 1);
            dto.setCategory_id(rs.getInt("category_id"));
            dto.setBrand_id(rs.getInt("brand_id"));
            dto.setCategory_name(rs.getString("name"));
            dto.setBrand_name(rs.getString("name"));
            System.out.println(dto.getProduct_id());
            System.out.println(dto.getProduct_name());
            
            return dto;
        } catch (SQLException ex) {
            Logger.getLogger(ProductMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static ProductDTO toProductDTOFromRequestToUpdate(HttpServletRequest request, ProductDTO oldProduct) {
        ProductDTO dto = new ProductDTO();

        dto.setProduct_id(oldProduct.getProduct_id()); // luôn giữ ID

        String name = request.getParameter("StrProductName");
        dto.setProduct_name((name != null && !name.trim().isEmpty()) ? name : oldProduct.getProduct_name());

        String desc = request.getParameter("StrDescription");
        dto.setDescription((desc != null && !desc.trim().isEmpty()) ? desc : oldProduct.getDescription());

        String priceStr = request.getParameter("StrPrice");
        dto.setPrice((priceStr != null && !priceStr.trim().isEmpty())
                ? Double.parseDouble(priceStr)
                : oldProduct.getPrice());

        String img = request.getParameter("StrImgUrl");
        dto.setImg_url((img != null && !img.trim().isEmpty()) ? img : oldProduct.getImg_url());

        String categoryId = request.getParameter("StrCategoryId");
        dto.setCategory_id((categoryId != null && !categoryId.trim().isEmpty())
                ? Long.parseLong(categoryId)
                : oldProduct.getCategory_id());

        String brandId = request.getParameter("StrBrandId");
        dto.setBrand_id((brandId != null && !brandId.trim().isEmpty())
                ? Long.parseLong(brandId)
                : oldProduct.getBrand_id());

        String statusParam = request.getParameter("StrStatus");
        dto.setStatus(statusParam != null);

        return dto;
    }
}
