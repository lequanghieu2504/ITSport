/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.BrandDTO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class BrandMapper {

    public static BrandDTO toBrandDTOFromResultSet(ResultSet rs) {
        try {
            BrandDTO brandDTO = new BrandDTO();
            Long brand_id = rs.getLong("brand_id");
            String brand_name = rs.getString("brand_name");
            String image_url = rs.getString("image_url");
            long image_id = rs.getLong("image_id");
            
            
            System.out.println(brand_id);
            System.out.println(brand_name);
            System.out.println(image_url);
            System.out.println(image_id);
            
            
            brandDTO.setBrand_id(brand_id);
            brandDTO.setBrand_name(brand_name);
            brandDTO.setImage_id(image_id);
            brandDTO.setImage_url(image_url);
            
            return brandDTO;
        } catch (SQLException ex) {
            Logger.getLogger(BrandMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}