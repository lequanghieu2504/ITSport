package DAO;

import DTOs.TotalBuyingDTO;
import DTOs.ItemDTO;

import java.math.BigDecimal;
import java.sql.*;

public class BuyingDAO {

   public int insertBuying(TotalBuyingDTO dto, Connection conn) throws SQLException {
    System.out.println("Đang ở BuyingDAO");
    String sqlOrder = ""
            + "INSERT INTO Buyings "
            + "(user_id, total_price, payment_method, status, created_at, updated_at, "
            + "shippingName, shippingPhone, shippingStreet, shippingWard, shippingDistrict, shippingProvince) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    String sqlItem = ""
            + "INSERT INTO BuyingItems "
            + "(buying_id, product_id, variant_id, quantity, price_each) "
            + "VALUES (?, ?, ?, ?, ?)";
    
    // 1) Insert order
    int buyingId;
    try (PreparedStatement ps = conn.prepareStatement(
            sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
        ps.setLong(1, dto.getUserId());
        ps.setDouble(2, dto.getTotalPrice());
        ps.setString(3, dto.getPaymentMethod().name());
        ps.setString(4, dto.getStatus().name());
        ps.setTimestamp(5, Timestamp.valueOf(dto.getCreatedAt()));
        ps.setTimestamp(6, Timestamp.valueOf(dto.getUpdatedAt()));
        ps.setString(7, dto.getShippingName());
        ps.setString(8, dto.getShippingPhone());
        ps.setString(9, dto.getShippingStreet());
        ps.setString(10, dto.getShippingWard());
        ps.setString(11, dto.getShippingDistrict());
        ps.setString(12, dto.getShippingProvince());
        ps.executeUpdate();
        
        try (ResultSet rs = ps.getGeneratedKeys()) {
            if (!rs.next()) {
                throw new SQLException("Không lấy được ID đơn mua");
            }
            buyingId = rs.getInt(1);
        }
    }
    
    // 2) Insert items
    try (PreparedStatement ps = conn.prepareStatement(sqlItem)) {
        for (ItemDTO it : dto.getItems()) {
            ps.setInt(1, buyingId);
            ps.setInt(2, it.getProductId());
            ps.setInt(3, it.getVariantId());
            ps.setInt(4, it.getQuantity());
            ps.setDouble(5, it.getPriceEach());
            ps.addBatch();
        }
        ps.executeBatch();
    }
    
    return buyingId;
}

}
