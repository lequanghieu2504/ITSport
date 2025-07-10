/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.ProductVariantDTO;
import Mapper.ProductVariantMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;
import util.JDBCConnection;

/**
 *
 * @author ASUS
 */
public class ProductVariantDAO {

    public ProductVariantDAO() {
    }

    private final String GET_PRODUCT_VARIANT = "select * from ProductVariant ";
    private final String INSERT_PRODUCT_VARIANT = "Insert into ProductVariant ";

    public List<ProductVariantDTO> getByProductVariantId(long productId) {
        String sql = GET_PRODUCT_VARIANT + " WHERE product_id = ?";
        List<ProductVariantDTO> listV = new ArrayList<>();

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductVariantDTO productVariantDTO = ProductVariantMapper.toProductVariantDTOFromResultSet(rs);
                listV.add(productVariantDTO);
            }

            return listV;

        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    
    public int getStock(Connection conn, int variantId) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT quantity FROM ProductVariant  WHERE product_variant_id = ?")) {
            ps.setInt(1, variantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("quantity");
                }
                throw new SQLException("Variant không tồn tại: " + variantId);
            }
        }
    }

    public void updateStock(Connection conn, int variantId, int newStock) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement( "UPDATE ProductVariant SET quantity = ? WHERE product_variant_id = ?")) {
            ps.setInt(1, newStock);
            ps.setInt(2, variantId);
            if (ps.executeUpdate() != 1) {
                throw new SQLException("Cập nhật stock thất bại cho variant: " + variantId);
            }
        }
    }

    public boolean InsertProductVariant(ProductVariantDTO productVariantDTO) {
        String sql = INSERT_PRODUCT_VARIANT + " (product_id,size,quantity,color,sku) values (?,?,?,?,?)";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, productVariantDTO.getProduct_id());
            ps.setString(2, productVariantDTO.getSize().toString());
            ps.setInt(3, productVariantDTO.getQuantity());
            ps.setString(4, productVariantDTO.getColor());
            ps.setString(5, productVariantDTO.getSku());
            int success = ps.executeUpdate();
            if(success>0){
                return true;
            }
            else return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductVariantDAO.class.getName()).log(Level.SEVERE, null, ex);

        }
        return false;
    }

}
