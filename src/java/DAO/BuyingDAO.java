package DAO;

import DTOs.BuyingForAdminDTO;
import DTOs.DailyRevenueDTO;
import DTOs.TotalBuyingDTO;
import DTOs.ItemDTO;
import DTOs.OrderStatusDTO;
import DTOs.UserOrderDTO;
import Enums.Status;
import Mapper.BuyingMapper;
import com.sun.javafx.scene.control.skin.VirtualFlow;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

public class BuyingDAO {

    private final String GET_BUYING = "select * from Buyings ";
    private final String UPDATE_BUYING = "update Buyings ";

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
        try ( PreparedStatement ps = conn.prepareStatement(
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

            try ( ResultSet rs = ps.getGeneratedKeys()) {
                if (!rs.next()) {
                    throw new SQLException("Không lấy được ID đơn mua");
                }
                buyingId = rs.getInt(1);
            }
        }

        // 2) Insert items
        try ( PreparedStatement ps = conn.prepareStatement(sqlItem)) {
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

    public List<BuyingForAdminDTO> getAllBuyingForAdmin() {
        List<BuyingForAdminDTO> resultList = new ArrayList<>();
        Map<Long, BuyingForAdminDTO> map = new LinkedHashMap<>();

        String sql = "SELECT "
                + "b.buying_id, b.total_price, b.payment_method, b.status, b.created_at, "
                + "b.shippingName, b.shippingPhone, b.shippingStreet, b.shippingWard, "
                + "b.shippingDistrict, b.shippingProvince, "
                + "pv.sku "
                + "FROM Buyings b "
                + "JOIN BuyingItems bi ON b.buying_id = bi.buying_id "
                + "JOIN ProductVariant pv ON bi.variant_id = pv.product_variant_id "
                + "ORDER BY b.buying_id";

        try ( Connection con = JDBCConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                long buyingId = rs.getLong("buying_id");

                BuyingForAdminDTO dto = map.get(buyingId);
                if (dto == null) {
                    dto = new BuyingForAdminDTO();
                    dto.setBuyingId(buyingId);
                    dto.setTotalPrice(rs.getBigDecimal("total_price"));
                    dto.setPaymentMethod(rs.getString("payment_method"));
                    dto.setStatus(Status.valueOf(rs.getString("status").toUpperCase()));
                    dto.setCreatedAt(rs.getTimestamp("created_at"));
                    dto.setShippingName(rs.getString("shippingName"));
                    dto.setShippingPhone(rs.getString("shippingPhone"));
                    dto.setShippingStreet(rs.getString("shippingStreet"));
                    dto.setShippingWard(rs.getString("shippingWard"));
                    dto.setShippingDistrict(rs.getString("shippingDistrict"));
                    dto.setShippingProvince(rs.getString("shippingProvince"));
                    map.put(buyingId, dto);
                }

                dto.addSku(rs.getString("sku"));
            }

            resultList.addAll(map.values());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultList;
    }

    public boolean updateStatusByBuyingId(Long BuyingId, String status) {
        String sql = UPDATE_BUYING + "set status = ? where buying_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setLong(2, BuyingId);

            int success = ps.executeUpdate();
            if (success > 0) {
                return true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(BuyingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT SUM(total_price) as totalBuying "
                + "FROM Buyings "
                + "WHERE status = 'SUCCESS'";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("totalBuying");
            }

        } catch (SQLException ex) {
            Logger.getLogger(BuyingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<OrderStatusDTO> getOrdersByStatus() {
        String sql = "SELECT status, COUNT(*) AS total_orders "
                + "FROM Buyings "
                + "GROUP BY status ";
        List<OrderStatusDTO> listOrder = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderStatusDTO orderStatusDTO = new OrderStatusDTO();
                orderStatusDTO.setStatus(rs.getString("status"));
                orderStatusDTO.setTotalOrders(rs.getInt("total_orders"));
                listOrder.add(orderStatusDTO);
            }
            return listOrder;
        } catch (SQLException ex) {
            Logger.getLogger(BuyingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<DailyRevenueDTO> getDailyRevenue() {
        String sql = "SELECT "
                + "    CAST(created_at AS DATE) AS order_date, "
                + "    SUM(total_price) AS daily_revenue "
                + "FROM Buyings "
                + "WHERE status = 'SUCCESS' "
                + "GROUP BY CAST(created_at AS DATE) "
                + "ORDER BY order_date DESC ";
        List<DailyRevenueDTO> listDaily = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DailyRevenueDTO dailyRevenueDTO = new DailyRevenueDTO();
                dailyRevenueDTO.setDailyRevenue(rs.getDouble("daily_revenue"));
                dailyRevenueDTO.setOrderDate(rs.getString("order_date"));
                listDaily.add(dailyRevenueDTO);
            }
            return listDaily;
        } catch (SQLException ex) {
            Logger.getLogger(BuyingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<UserOrderDTO> getUserBuying(long userId) {
        String sql = "  SELECT "
                + "  b.buying_id, "
                + "  b.user_id, "
                + "  b.total_price, "
                + "  b.payment_method, "
                + "  b.status, "
                + "  b.created_at, "
                + "  b.updated_at, "
                + "  b.shippingName, "
                + "  b.shippingPhone, "
                + "  b.shippingStreet, "
                + "  b.shippingWard, "
                + "  b.shippingDistrict, "
                + "  b.shippingProvince, "
                + "  bi.buying_item_id, "
                + "  bi.product_id, "
                + "  bi.variant_id, "
                + "  bi.quantity AS item_quantity, "
                + "  bi.price_each, "
                + "  pv.size, "
                + "  pv.color, "
                + "  pv.sku, "
                + "  img.file_name AS image_url "
                + "FROM "
                + "  Buyings b "
                + "JOIN "
                + "  BuyingItems bi ON b.buying_id = bi.buying_id "
                + "JOIN "
                + "  ProductVariant pv ON bi.variant_id = pv.product_variant_id "
                + "LEFT JOIN "
                + "  Image img ON pv.product_variant_id = img.target_id AND img.target_type = 'PRODUCT_VARIANT'\n"
                + "WHERE "
                + "  b.user_id = ? "
                + "ORDER BY "
                + "  b.buying_id, bi.buying_item_id ";
        List<UserOrderDTO> userOrderDTOs = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserOrderDTO userOrderDTO = BuyingMapper.toUserOrderDTOFromRequest(rs);
                userOrderDTOs.add(userOrderDTO);
            }
            return userOrderDTOs;
        } catch (SQLException ex) {
            Logger.getLogger(BuyingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateStatusByUser(long userId, long buyingId) {
        String sql = UPDATE_BUYING + " set status = 'CANCEL' WHERE buying_id=? and user_id=?";
        try(Connection conn = JDBCConnection.getConnection();PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setLong(1, buyingId);
            ps.setLong(2, userId);
        ps.executeUpdate();
            } catch (SQLException ex) {
            Logger.getLogger(BuyingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
