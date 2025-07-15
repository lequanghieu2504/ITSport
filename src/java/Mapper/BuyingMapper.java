package Mapper;
import DTOs.TotalBuyingDTO;
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

}
