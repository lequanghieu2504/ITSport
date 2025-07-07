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

    private final String GET_PRODUCT = "select * from [Product] ";
    private final String INSERT_PRODUCT = "INSERT INTO [Product] ";

    public List<ProductDTO> getNewProducts() {
        String sql = GET_PRODUCT;
        List<ProductDTO> listP = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
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
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
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

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean insertProduct(ProductDTO productDTO) {
        String sql = "INSERT INTO product (product_name, [description], price, category_id, brand_id, [status]) VALUES (?, ?, ?, ?, ?, ?)";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productDTO.getProduct_name());
            ps.setString(2, productDTO.getDescription());
            ps.setDouble(3, productDTO.getPrice());
            ps.setLong(4, productDTO.getCategory_id());
            ps.setLong(5, productDTO.getBrand_id());
            ps.setBoolean(6, productDTO.isStatus()); // Hoặc setInt nếu status là 0/1

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public List<ProductDTO> getAllProduct() {
        List<ProductDTO> listP = new ArrayList<>();
        String sql = GET_PRODUCT;

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getAllProductWithCategoryAndBrandName() {
        List<ProductDTO> list = new ArrayList<>();

        String sql = "SELECT p.product_id, p.product_name, p.description, p.price, p.img_url, "
                + "p.status, p.category_id, p.brand_id, "
                + "c.name AS category_name, b.name AS brand_name "
                + "FROM Product p "
                + "JOIN Categories c ON p.category_id = c.category_id "
                + "JOIN Brand b ON p.brand_id = b.brand_id";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductDTO dto = ProductMapper.toProductDTOFromRequestWithName(rs);
                list.add(dto);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }
}
