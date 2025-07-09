package DAO;

import DTOs.BuyingDTO;
import Enums.PaymentMethod;
import Enums.Status;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;

public class BuyingDAO {
    private static final String SQL_INSERT =
        "INSERT INTO Buying " +
        "(user_id, product_id, variant_id, quantity, price, address_id, payment_method, status, created_at, updated_at) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SQL_FIND_BY_ID =
        "SELECT * FROM Buying WHERE buying_id = ?";

    private static final String SQL_UPDATE_STATUS =
        "UPDATE Buying SET status = ?, updated_at = ? WHERE buying_id = ?";

    public BuyingDTO BuyNow(Connection conn, BuyingDTO dto) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, dto.getUserId());
            ps.setInt(2, dto.getProductId());
            ps.setInt(3, dto.getVariantId());
            ps.setInt(4, dto.getQuantity());
            ps.setBigDecimal(5, BigDecimal.valueOf(dto.getPrice()));
            if (dto.getAddressId() != null) {
                ps.setInt(6, dto.getAddressId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            ps.setString(7, dto.getPaymentMethod().name());
            ps.setString(8, dto.getStatus().name());
            Timestamp now = Timestamp.valueOf(LocalDateTime.now());
            ps.setTimestamp(9, now);
            ps.setTimestamp(10, now);

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int generatedId = rs.getInt(1);
                    dto.setBuyingId(generatedId);
                    dto.setCreatedAt(now.toLocalDateTime());
                    dto.setUpdatedAt(now.toLocalDateTime());
                    return dto;
                } else {
                    throw new SQLException("Không lấy được ID mới của Buying");
                }
            }
        }
    }


    public BuyingDTO findById(Connection conn, int buyingId) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, buyingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BuyingDTO dto = new BuyingDTO();
                    dto.setBuyingId(rs.getInt("buying_id"));
                    dto.setUserId(rs.getInt("user_id"));
                    dto.setProductId(rs.getInt("product_id"));
                    dto.setVariantId(rs.getInt("variant_id"));
                    dto.setQuantity(rs.getInt("quantity"));
                    dto.setPrice(rs.getBigDecimal("price").doubleValue());
                    int addr = rs.getInt("address_id");
                    dto.setAddressId(rs.wasNull() ? null : addr);
                    dto.setPaymentMethod(PaymentMethod.valueOf(rs.getString("payment_method")));
                    dto.setStatus(Status.valueOf(rs.getString("status")));
                    dto.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    dto.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    return dto;
                }
                return null;
            }
        }
    }

    public boolean updateStatus(Connection conn, int buyingId, Status newStatus) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(SQL_UPDATE_STATUS)) {
            ps.setString(1, newStatus.name());
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, buyingId);
            return ps.executeUpdate() > 0;
        }
    }
}
