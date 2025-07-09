/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import DTOs.CartItemDTO;

/**
 *
 * @author SUPPER LOQ
 */
public class CartItemMapper {

    public static CartItemDTO toCartItemDTOFromResultSet(ResultSet rs) throws SQLException {
        CartItemDTO item = new CartItemDTO();
        item.setCart_item_id(rs.getInt("cart_item_id"));
        item.setCart_id(rs.getInt("cart_id"));
        item.setProduct_id(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        return item;
    }
}
