/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.CartItemDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import Enums.Size;
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

    private static final ProductDAO productDAO = new ProductDAO();

    // SQL cập nhật để lấy thông tin từ Cart_Item, ProductVariant, và Product
    private static final String GET_ALL_CART_ITEMS
            = "SELECT ci.cart_item_id, ci.cart_id, ci.quantity, "
            + "pv.product_variant_id, pv.size, pv.quantity AS variant_quantity, pv.sku, "
            + "p.product_id, p.product_name, p.price "
            + "FROM Cart_Item ci "
            + "JOIN ProductVariant pv ON ci.product_variant_id = pv.product_variant_id "
            + "JOIN Product p ON pv.product_id = p.product_id "
            + "WHERE ci.cart_id = ?";

    public static List<CartItemDTO> getAllCartItems(int cartId) {
        List<CartItemDTO> cartItems = new ArrayList<>();

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(GET_ALL_CART_ITEMS)) {

            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Product
                ProductDTO product = new ProductDTO();
                product.setProduct_id(rs.getLong("product_id"));
                product.setProduct_name(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));

                // Variant
                ProductVariantDTO variant = new ProductVariantDTO();
                variant.setProduct_variant_id(rs.getLong("product_variant_id"));
                variant.setProduct_id(rs.getLong("product_id"));
                variant.setSize(Size.valueOf(rs.getString("size")));
                variant.setQuantity(rs.getInt("variant_quantity"));
                variant.setSku(rs.getString("sku"));

                // CartItem
                CartItemDTO item = new CartItemDTO();
                item.setCart_item_id(rs.getInt("cart_item_id"));
                item.setCart_id(rs.getInt("cart_id"));
                item.setProduct_id(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setVariant(variant);
                item.setProduct(product);

                cartItems.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    public static double calculateTotalPrice(List<CartItemDTO> items) {
        double total = 0;
        for (CartItemDTO item : items) {
            double price = item.getVariant().getProduct().getPrice();
            total += price * item.getQuantity();
        }
        return total;
    }

    public static void main(String[] args) {
        int cartIdToTest = 2; // thay đổi ID tùy dữ liệu test

        List<CartItemDTO> cartItems = CartItemDAO.getAllCartItems(cartIdToTest);

        if (cartItems.isEmpty()) {
            System.out.println("Không có sản phẩm nào trong giỏ hàng.");
        } else {
            for (CartItemDTO item : cartItems) {
                ProductVariantDTO variant = item.getVariant();
                ProductDTO product = variant.getProduct();

                System.out.println("CartItem ID: " + item.getCart_item_id());
                System.out.println("Cart ID: " + item.getCart_id());
                System.out.println("Quantity: " + item.getQuantity());
                System.out.println("Product: " + product.getProduct_name());
                System.out.println("Price: " + product.getPrice());
                System.out.println("Variant ID: " + variant.getProduct_variant_id());
                System.out.println("Size: " + variant.getSize());
                System.out.println("SKU: " + variant.getSku());
                System.out.println("------");
            }
        }
    }
}
