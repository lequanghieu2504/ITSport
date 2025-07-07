/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.CategoryDTO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class CategoryMapper {

    public static CategoryDTO toCategoryDTOFromResultSet(ResultSet rs) {
        try {
            Long category_id = rs.getLong("category_id");
            String category_name = rs.getString("name");
            Long parent_id = rs.getLong("parent_id");
            return new CategoryDTO(category_id, category_name, parent_id);
        } catch (SQLException ex) {
            Logger.getLogger(CategoryMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
