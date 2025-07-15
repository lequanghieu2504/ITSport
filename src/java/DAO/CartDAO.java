package DAO;

import DTOs.CartItemDTO;
import java.sql.*;
import java.util.*;
import java.util.logging.*;
import util.JDBCConnection;

public class CartDAO {

    public void insertCartItem(int cart_id, int product_id, int variant_id, int quantity) {
        String sql = "INSERT INTO Cart_Item (cart_id, product_id, product_variant_id, quantity) VALUES (?, ?, ?, ?)";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart_id);
            ps.setInt(2, product_id);
            ps.setInt(3, variant_id);
            ps.setInt(4, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void updateCartItemQuantity(int cart_id, int product_id, int variant_id, int quantity) {
        String sql = "UPDATE Cart_Item SET quantity = ? WHERE cart_id = ? AND product_id = ? AND product_variant_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cart_id);
            ps.setInt(3, product_id);
            ps.setInt(4, variant_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteCartItem(int cart_id, int product_id, int variant_id) {
        String sql = "DELETE FROM Cart_Item WHERE cart_id = ? AND product_id = ? AND product_variant_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart_id);
            ps.setInt(2, product_id);
            ps.setInt(3, variant_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public CartItemDTO getCartItem(int cart_id, int product_id, int variant_id) {
        String sql = "SELECT * FROM Cart_Item WHERE cart_id = ? AND product_id = ? AND product_variant_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart_id);
            ps.setInt(2, product_id);
            ps.setInt(3, variant_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CartItemDTO(
                        rs.getInt("cart_item_id"),
                        rs.getInt("cart_id"),
                        rs.getInt("product_id"),
                        rs.getInt("product_variant_id"),
                        rs.getInt("quantity")
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public List<CartItemDTO> getAllCartItems(int cart_id) {
        List<CartItemDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Cart_Item WHERE cart_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CartItemDTO(
                        rs.getInt("cart_item_id"),
                        rs.getInt("cart_id"),
                        rs.getInt("product_id"),
                        rs.getInt("product_variant_id"),
                        rs.getInt("quantity")
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public int getCartSize(int cartId) {
        String sql = "SELECT SUM(quantity) FROM Cart_Item WHERE cart_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
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
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cart_id;
    }

    public static void main(String[] args) {
        CartDAO dao = new CartDAO();

        // Dữ liệu thực tế trong DB
        int cartId = 1;
        int productId = 1;
        int variantId = 1;

        // In trước khi update
        System.out.println("Before update:");
        CartItemDTO before = dao.getCartItem(cartId, productId, variantId);
        System.out.println(before);

        // Gọi update
        int newQuantity = 7;
        dao.updateCartItemQuantity(cartId, productId, variantId, newQuantity);

        // In sau khi update
        System.out.println("After update:");
        CartItemDTO after = dao.getCartItem(cartId, productId, variantId);
        System.out.println(after);
    }

}
