/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.CategoryDTO;
import Mapper.CategoryMapper;
import jakarta.servlet.jsp.jstl.sql.Result;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author ASUS
 */
public class CategoryDAO {
    private final String GET_CATEGORY = "select * from Categories ";
    public List<CategoryDTO> getAllCategories() {
        List<CategoryDTO> listC = new ArrayList<>();
        String sql = GET_CATEGORY;
        try(Connection conn = JDBCConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){

            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                CategoryDTO categoryDTO = new CategoryDTO();
                categoryDTO = CategoryMapper.toCategoryDTOFromResultSet(rs);
                listC.add(categoryDTO);
            }

            return listC;
            
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
