/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author SUPPER LOQ
 */
public class CartDAO {

    public void addToCart(int cart_id, int product_id, int quantity) {
        String selectSQL = "SELECT quantity FROM Cart_Item WHERE cart_id = ? AND product_id = ?";
        try ( Connection conn = JDBCConnection.getConnection()) {
            try ( PreparedStatement psSelect = conn.prepareStatement(selectSQL)) {
                psSelect.setInt(1, cart_id);
                psSelect.setInt(2, product_id);
                ResultSet rs = psSelect.executeQuery();

                if (rs.next()) {
                    int existingQty = rs.getInt("quantity");

                    String updateSQL = "UPDATE Cart_Item SET quantity = ? WHERE cart_id = ? AND product_id = ?";
                    try ( PreparedStatement psUpdate = conn.prepareStatement(updateSQL)) {
                        psUpdate.setInt(1, existingQty + quantity);
                        psUpdate.setInt(2, cart_id);
                        psUpdate.setInt(3, product_id);
                        psUpdate.executeUpdate();
                    }

                } else {
                    String insertSQL = "INSERT INTO Cart_Item (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                    try ( PreparedStatement psInsert = conn.prepareStatement(insertSQL)) {
                        psInsert.setInt(1, cart_id);
                        psInsert.setInt(2, product_id);
                        psInsert.setInt(3, quantity);
                        psInsert.executeUpdate();
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static int createCart() {
        String sql = "INSERT INTO Cart DEFAULT VALUES";
        int cart_id = -1;
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                cart_id = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart_id;
    }
}
