// Service/BuyingService.java
package Service;

import DAO.BuyingDAO;
import DAO.ProductVariantDAO;
import DTOs.BuyingDTO;
import DTOs.BuyingDTO.Item;
import Enums.PaymentMethod;
import Enums.Status;
import util.JDBCConnection;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class BuyingService {
    private final BuyingDAO buyingDAO         = new BuyingDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();

    /**
     * Xử lý mua hàng (1 hoặc nhiều sản phẩm).
     * Trả về buyingId mới.
     */
public int handleCreateBuying(HttpServletRequest req) {
    System.out.println(">>> Enter handleCreateBuying");
    System.out.println("    param userId       = " + req.getParameter("userId"));
    System.out.println("    param productId[]  = " + Arrays.toString(req.getParameterValues("productId")));
    System.out.println("    param variantId[]  = " + Arrays.toString(req.getParameterValues("variantId")));
    System.out.println("    param quantity[]   = " + Arrays.toString(req.getParameterValues("quantity")));
    System.out.println("    param priceEach[]  = " + Arrays.toString(req.getParameterValues("priceEach")));

    // 1) Đọc chung
    int userId   = Integer.parseInt(req.getParameter("userId"));
    System.out.println(userId);
    Integer addressId = Optional.ofNullable(req.getParameter("addressId"))
                                .filter(s -> !s.isEmpty())
                                .map(Integer::parseInt)
                                .orElse(null);
    System.out.println(addressId);
    PaymentMethod pm = PaymentMethod.valueOf(req.getParameter("paymentMethod"));
    Status st        = Status.PENDING;
    LocalDateTime now= LocalDateTime.now();

    System.out.println("da lay duoc userid"+userId);
    System.out.println("pm" + pm);
    // 2) Lấy mảng params
    String[] pIds      = req.getParameterValues("productId");
    String[] vIds      = req.getParameterValues("variantId");
    String[] qtys      = req.getParameterValues("quantity");
    String[] pricesArr = req.getParameterValues("priceEach");

    // 3) Validate mảng đồng bộ
    if (pIds == null || vIds == null || qtys == null || pricesArr == null
        || pIds.length != vIds.length
        || pIds.length != qtys.length
        || pIds.length != pricesArr.length) {
        throw new IllegalArgumentException("Thiếu hoặc không đồng bộ các tham số sản phẩm");
    }

    // 4) Build danh sách items
    List<Item> items = new ArrayList<>(pIds.length);
    for (int i = 0; i < pIds.length; i++) {
        int pid = Integer.parseInt(pIds[i]);
        int vid = Integer.parseInt(vIds[i]);
        int qty = Integer.parseInt(qtys[i]);
        double pr = Double.parseDouble(pricesArr[i]);
        items.add(new Item(pid, vid, qty, pr));
    }
    System.out.println("da lay duoc item"+ items);
    // 5) Tính tổng
    double total = items.stream()
                        .mapToDouble(it -> it.getPriceEach() * it.getQuantity())
                        .sum();
    System.out.println("da tinh duoc total"+ total);
    // 6) Build DTO
    BuyingDTO dto = new BuyingDTO();
    dto.setUserId(userId);
    dto.setItems(items);
    dto.setTotalPrice(total);
    dto.setAddressId(addressId);
    dto.setPaymentMethod(pm);
    dto.setStatus(st);
    dto.setCreatedAt(now);
    dto.setUpdatedAt(now);

    // 7) Transaction: reserve stock + insert order/items
    try (Connection conn = JDBCConnection.getConnection()) {
        conn.setAutoCommit(false);

        for (Item it : items) {
            int stock = variantDAO.getStock(conn, it.getVariantId());
            if (stock < it.getQuantity()) {
                throw new IllegalStateException(
                    "Không đủ stock variant " + it.getVariantId() +
                    ": còn " + stock + ", yêu cầu " + it.getQuantity()
                );
            }
            variantDAO.updateStock(conn, it.getVariantId(), stock - it.getQuantity());
        }

        System.out.println(">>> Before calling DAO.insertBuying");
        int buyingId = buyingDAO.insertBuying(dto, conn);
        System.out.println(">>> After calling DAO.insertBuying, id = " + buyingId);
        conn.commit();
        return buyingId;

    } catch (Exception e) {
        e.printStackTrace();  
        throw new RuntimeException(e);
        }
}

}
