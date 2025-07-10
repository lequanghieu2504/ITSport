package DAO;

import DTOs.BuyingDTO;
import DTOs.BuyingDTO.Item;

import java.math.BigDecimal;
import java.sql.*;

public class BuyingDAO {

    public int insertBuying(BuyingDTO dto, Connection conn) throws SQLException {
        
        System.out.println("dang o buyingdao");
        String sqlOrder = ""
          + "INSERT INTO Buyings "
          + "(user_id, total_price, address_id, payment_method, status, created_at, updated_at) "
          + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlItem  = ""
          + "INSERT INTO BuyingItems "
          + "(buying_id, product_id, variant_id, quantity, price_each) "
          + "VALUES (?, ?, ?, ?, ?)";

        // 1) Insert order
        int buyingId;
        try (PreparedStatement ps = conn.prepareStatement(
                 sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, dto.getUserId());
            ps.setDouble(2, dto.getTotalPrice());
            ps.setInt(3, dto.getAddressId());
            ps.setString(4, dto.getPaymentMethod().name());
            ps.setString(5, dto.getStatus().name());
            ps.setTimestamp(6, Timestamp.valueOf(dto.getCreatedAt()));
            ps.setTimestamp(7, Timestamp.valueOf(dto.getUpdatedAt()));
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
            for (Item it : dto.getItems()) {
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
