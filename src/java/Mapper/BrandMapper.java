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
            Long brand_id = rs.getLong("brand_id");
            String brand_name = rs.getString("name");
            return new BrandDTO(brand_id, brand_name);
        } catch (SQLException ex) {
            Logger.getLogger(BrandMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}