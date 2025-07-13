/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.CartDTO;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author SUPPER LOQ
 */
public class CartMapper {
    public static CartDTO map(ResultSet rs) throws SQLException {
        CartDTO cart = new CartDTO();
        cart.setCart_id(rs.getInt("cart_id"));
        cart.setClient_id(rs.getInt("client_id"));

        return cart;
    }
}
