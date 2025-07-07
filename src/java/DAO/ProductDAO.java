/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.ProductDTO;
import Mapper.ProductMapper;
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
public class ProductDAO {

    private final String GET_PRODUCT = "SELECT * FROM Product";

    public List<ProductDTO> getNewProducts() {
        List<ProductDTO> listP = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(GET_PRODUCT)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listP.add(ProductMapper.toProductDTOFromResultSet(rs));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listP;
    }

    public List<ProductDTO> getProductsByCategoryId(long category_id) {
        List<ProductDTO> listP = new ArrayList<>();
        String sql = GET_PRODUCT + "WHERE category_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, category_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                listP.add(ProductMapper.toProductDTOFromResultSet(rs));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listP;
    }

    public List<ProductDTO> getSuggestedProducts() {
        List<ProductDTO> listP = new ArrayList<>();
        String sql = GET_PRODUCT + " ORDER BY product_id DESC"; // Đảm bảo đúng tên cột

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listP.add(ProductMapper.toProductDTOFromResultSet(rs));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listP;
    }
}
