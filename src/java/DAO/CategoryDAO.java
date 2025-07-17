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
import java.sql.Statement;
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
    private final String DELETE_CATEGORY = "delete from Categories ";
    private final String INSERT_CATEGORY = " insert into Categories ";

    public List<CategoryDTO> getAllCategories() {
        List<CategoryDTO> listC = new ArrayList<>();
        String sql = "SELECT "
                + " c.category_id,"
                + " c.name,"
                + " c.parent_id,"
                + " i.image_id,"
                + " i.file_name,"
                + " i.target_type, "
                + " i.uploaded_at "
                + " FROM "
                + "    Categories c  "
                + " LEFT JOIN "
                + "    image i ON i.target_id = c.category_id AND i.target_type = 'CATEGORY'";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CategoryDTO categoryDTO = CategoryMapper.toCategoryDTOFromResultSet(rs);

                listC.add(categoryDTO);
            }

            return listC;

        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean deleteCategoryById(long categoryId) {
        String sql = DELETE_CATEGORY + "where category_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, categoryId);
            int success = ps.executeUpdate();
            if (success > 0) {
                return true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean hasChildCategory(long categoryId) {
        String sql = "SELECT COUNT(*) FROM Categories WHERE parent_id = ?";
        try ( Connection con = JDBCConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, categoryId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public long addCategory(String categoryName, long parentId) {
        long generatedId = -1;

        String sql = "INSERT INTO Categories (name) VALUES (?)";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, categoryName);
  

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try ( ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getLong(1);
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return generatedId; // -1 nếu lỗi
    }

}
