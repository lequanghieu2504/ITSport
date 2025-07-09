/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DAO.CartItemDAO;
import DTOs.CartDTO;
import DTOs.CartItemDTO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author SUPPER LOQ
 */
public class CartMapper {
    public static CartDTO map(ResultSet rs) throws SQLException {
        int cartId = rs.getInt("cart_id");
        int clientId = rs.getInt("client_id");

        // list CartItem
        List<CartItemDTO> items = CartItemDAO.getItemsByCartId(cartId);

        // tota price
        double total = CartItemDAO.calculateTotalPrice(items);

        CartDTO cart = new CartDTO();
        cart.setCart_id(cartId);
        cart.setClient_id(clientId);
        cart.setItems(items);
        cart.setTotalPrice(total);

        return cart;
    }
}
