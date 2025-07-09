/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.CartItemDTO;
import DTOs.ProductDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.JDBCConnection;

/**
 *
 * @author SUPPER LOQ
 */
public class CartItemDAO {

    private static final String GET_ITEM_BY_CART_ID
            = "SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.quantity, p.price "
            + "FROM Cart_Item ci "
            + "JOIN Product p ON ci.product_id = p.product_id "
            + "WHERE ci.cart_id = ?";

    private static final ProductDAO productDAO = new ProductDAO();

    public static List<CartItemDTO> getItemsByCartId(int cartId) {
        List<CartItemDTO> list = new ArrayList<>();

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(GET_ITEM_BY_CART_ID)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItemDTO item = new CartItemDTO();
                item.setCart_item_id(rs.getInt("cart_item_id"));
                item.setCart_id(rs.getInt("cart_id"));
                item.setProduct_id(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static double calculateTotalPrice(List<CartItemDTO> items) {
        double total = 0;
        for (CartItemDTO item : items) {
            ProductDTO product = productDAO.getProductById(String.valueOf(item.getProduct_id()));
            double price = product.getPrice();
            total += price * item.getQuantity();
        }
        return total;
    }
}
