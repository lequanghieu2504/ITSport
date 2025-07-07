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
    private final String GET_PRODUCT = "select * from Categories ";
    
    
    public List<ProductDTO> getNewProducts() {
        String sql = GET_PRODUCT;
        List<ProductDTO> listP = new ArrayList<>();
        try(Connection conn = JDBCConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){

            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getProductsByCategoryId(long category_id) {
        
        String sql = GET_PRODUCT + " where category_id = ?";
        List<ProductDTO> listP = new ArrayList<>();
        try(Connection conn = JDBCConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getSuggestedProducts() {
        List<ProductDTO> listP = new ArrayList<>();
        String sql = GET_PRODUCT + "ORDER BY product_id DESC";
        
        try(Connection conn = JDBCConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
