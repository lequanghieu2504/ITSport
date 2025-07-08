/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.ProductVariantDTO;
import Enums.Size;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.ProductUtil;

/**
 *
 * @author ASUS
 */
public class ProductVariantMapper {

    public static ProductVariantDTO toProductVariantDTOFromResultSet(ResultSet rs) {
        try {
            ProductVariantDTO productVariantDTO = new ProductVariantDTO();

            Long product_variant_id = rs.getLong("product_variant_id");
            Long product_id = rs.getLong("product_id");
            String size = rs.getString("size").toUpperCase();
            int quantity = rs.getInt("quantity");
            String sku = rs.getString("sku");
            String color = rs.getString("color");
            
            productVariantDTO.setProduct_variant_id(product_variant_id);
            productVariantDTO.setProduct_id(product_id);
            productVariantDTO.setQuantity(quantity);
            productVariantDTO.setSize(Size.valueOf(size));
            productVariantDTO.setSku(sku);
            productVariantDTO.setColor(color);
            return productVariantDTO;
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static ProductVariantDTO toVariantDTOFromRequest(HttpServletRequest request) {
        ProductVariantDTO dto = new ProductVariantDTO();

        try {
            long productId = Long.parseLong(request.getParameter("StrProductId"));
            String size = request.getParameter("StrSize");
            int quantity = Integer.parseInt(request.getParameter("StrQuantity"));
            String color = request.getParameter("StrColor");
            
            
            
            dto.setProduct_id(productId);
            dto.setSize(Size.valueOf(size));
            dto.setQuantity(quantity);
            dto.setColor(color);
            
            String sku = ProductUtil.generateSKU(dto);
            dto.setSku(sku);
        } catch (Exception e) {
            // Log hoặc xử lý lỗi tùy ý
            e.printStackTrace();
        }

        return dto;
    }
}


