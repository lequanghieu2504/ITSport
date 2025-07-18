package Mapper;

import DTOs.TotalBuyingDTO;
import DTOs.UserOrderDTO;
import Enums.PaymentMethod;
import Enums.Status;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class BuyingMapper {

    public static TotalBuyingDTO toTotalBuyingDTOFromResultSet(ResultSet rs) throws SQLException {
        TotalBuyingDTO totalBuyingDTO = new TotalBuyingDTO();

        totalBuyingDTO.setBuyingId(rs.getLong("buying_id"));
        totalBuyingDTO.setUserId(rs.getLong("user_id"));
        totalBuyingDTO.setTotalPrice(rs.getDouble("total_price"));

        String paymentMethodStr = rs.getString("payment_method");
        if (paymentMethodStr != null) {
            totalBuyingDTO.setPaymentMethod(PaymentMethod.valueOf(paymentMethodStr.toUpperCase()));
        }

        String statusStr = rs.getString("status");
        if (statusStr != null) {
            totalBuyingDTO.setStatus(Status.valueOf(statusStr.toUpperCase()));
        }

        totalBuyingDTO.setShippingName(rs.getString("shippingName"));
        totalBuyingDTO.setShippingPhone(rs.getString("shippingPhone"));
        totalBuyingDTO.setShippingStreet(rs.getString("shippingStreet"));
        totalBuyingDTO.setShippingWard(rs.getString("shippingWard"));
        totalBuyingDTO.setShippingDistrict(rs.getString("shippingDistrict"));
        totalBuyingDTO.setShippingProvince(rs.getString("shippingProvince"));

        return totalBuyingDTO;
    }

    public static UserOrderDTO toUserOrderDTOFromRequest(ResultSet rs) throws SQLException {
        UserOrderDTO dto = new UserOrderDTO();
        dto.setBuyingId(rs.getInt("buying_id"));
        dto.setUserId(rs.getInt("user_id"));
        dto.setTotalPrice(rs.getDouble("total_price"));
        dto.setPaymentMethod(rs.getString("payment_method"));
        dto.setStatus(rs.getString("status"));
        dto.setCreatedAt(rs.getString("created_at"));
        dto.setUpdatedAt(rs.getString("updated_at"));

        dto.setShippingName(rs.getString("shippingName"));
        dto.setShippingPhone(rs.getString("shippingPhone"));
        dto.setShippingStreet(rs.getString("shippingStreet"));
        dto.setShippingWard(rs.getString("shippingWard"));
        dto.setShippingDistrict(rs.getString("shippingDistrict"));
        dto.setShippingProvince(rs.getString("shippingProvince"));

        dto.setBuyingItemId(rs.getInt("buying_item_id"));
        dto.setProductId(rs.getInt("product_id"));
        dto.setVariantId(rs.getInt("variant_id"));
        dto.setQuantity(rs.getInt("item_quantity"));
        dto.setPriceEach(rs.getDouble("price_each"));

        dto.setSize(rs.getString("size"));
        dto.setColor(rs.getString("color"));
        dto.setSku(rs.getString("sku"));
        dto.setImage_url(rs.getString("image_url"));

        return dto;
    }

}
