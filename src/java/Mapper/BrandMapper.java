/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.BrandDTO;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author SUPPER LOQ
 */
public class BrandMapper {

    public static BrandDTO mapToBrand(ResultSet rs) throws SQLException {
        BrandDTO brand = new BrandDTO();
        brand.setBrandId(rs.getInt("brand_id"));
        brand.setName(rs.getString("name"));
        return brand;
    }
}


