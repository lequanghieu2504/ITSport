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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author SUPPER LOQ
 */
public class CartItemDAO {

    private static final ProductDAO productDAO = new ProductDAO();

    // SQL cập nhật để lấy thông tin từ Cart_Item, ProductVariant, và Product
    private static final String GET_ALL_CART_ITEMS
            = "SELECT "
            + "  ci.cart_item_id,"
            + "  ci.cart_id,"
            + "  ci.quantity,"
            + "  pv.product_variant_id,"
            + "  pv.size,"
            + "  pv.color,"
            + "  pv.quantity AS variant_quantity,"
            + "  pv.sku,"
            + "  p.product_id,"
            + "  p.product_name,"
            + "  p.price,"
            + "  img.file_name AS image_name "
            + "FROM Cart_Item ci "
            + "JOIN ProductVariant pv ON ci.product_variant_id = pv.product_variant_id "
            + "JOIN Product p ON pv.product_id = p.product_id "
            + "LEFT JOIN Image img "
            + "  ON img.target_id = pv.product_variant_id "
            + "  AND img.target_type = 'PRODUCT_VARIANT' "
            + "  AND img.uploaded_at = ( "
            + "    SELECT MIN(i2.uploaded_at) "
            + "    FROM Image i2 "
            + "    WHERE i2.target_id = pv.product_variant_id "
            + "      AND i2.target_type = 'PRODUCT_VARIANT' "
            + "  ) "
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
                variant.setColor(rs.getString("color"));
                variant.setQuantity(rs.getInt("variant_quantity"));
                variant.setSku(rs.getString("sku"));

                variant.setProduct(product);

                // CartItem
                CartItemDTO item = new CartItemDTO();
                item.setCart_item_id(rs.getInt("cart_item_id"));
                item.setCart_id(rs.getInt("cart_id"));
                item.setProduct_id(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setVariant(variant);
                item.setProduct(product);
                item.setImage_url(rs.getString("image_name"));

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
                System.out.println("Color: " + variant.getColor());
                System.out.println("SKU: " + variant.getSku());
                System.out.println("------");
            }
        }
    }

    public void updateQuantity(long cartItemId, int quantity) {
        String sql = "update Cart_Item set quantity = ? where cart_item_id  = ?";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setLong(2, cartItemId);

            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    public void deleteCartItemByCartItemId(long cartItemId) {
        String sql = "DELETE FROM Cart_Item WHERE cart_item_id = ?";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, cartItemId);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                System.out.println("❗ Không có Cart_Item nào bị xoá. cart_item_id = " + cartItemId);
            } else {
                System.out.println("✅ Đã xoá Cart_Item với ID = " + cartItemId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Xoá Cart_Item thất bại!", e);
        }
    }
}
