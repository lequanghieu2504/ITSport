// Service/BuyingService.java
package Service;

import DAO.BuyingDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.UserAddressDAO;
import DTOs.BuyNowInforDTO;
import DTOs.ItemDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import DTOs.TotalBuyingDTO;
import DTOs.UserAddressDTO;
import DTOs.UserDTO;
import Enums.PaymentMethod;
import Enums.Status;
import jakarta.servlet.ServletException;
import util.JDBCConnection;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class BuyingService {

    private final BuyingDAO buyingDAO = new BuyingDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final UserAddressDAO userAddressDAO = new UserAddressDAO();

    public void handleBuyNowProcess(HttpServletRequest req, HttpServletResponse resp) {
        try {
            // Lấy thông tin từ request
            String strProductId = req.getParameter("StrProductId");
            String strColor = req.getParameter("StrColor");
            String strSize = req.getParameter("StrSize");
            String strQuantity = req.getParameter("StrQuantity");

            // Validate dữ liệu đầu vào
            if (strProductId == null || strQuantity == null) {
                req.setAttribute("error", "Thông tin sản phẩm không hợp lệ");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            long productId = Long.parseLong(strProductId);
            int quantity = Integer.parseInt(strQuantity);

            // Lấy thông tin variant sản phẩm
            ProductVariantDTO productVariantDTO = variantDAO.getByColorAndSize(strColor, strSize);

            if (productVariantDTO == null) {
                req.setAttribute("error", "Không tìm thấy sản phẩm với màu sắc và size đã chọn");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra số lượng tồn kho
            if (productVariantDTO.getQuantity() < quantity) {
                req.setAttribute("error", "Số lượng sản phẩm không đủ. Còn lại: " + productVariantDTO.getQuantity());
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            // Lấy thông tin sản phẩm chi tiết
            ProductDTO productDTO = productDAO.getProductById(productId);

            if (productDTO == null) {
                req.setAttribute("error", "Không tìm thấy sản phẩm");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            // Tạo đối tượng BuyNowInfo để lưu thông tin đơn hàng
            BuyNowInforDTO buyNowInfo = new BuyNowInforDTO();
            buyNowInfo.setProductId(productId);
            buyNowInfo.setProductName(productDTO.getProduct_name());
            buyNowInfo.setColor(strColor);
            buyNowInfo.setSize(strSize);
            buyNowInfo.setQuantity(quantity);
            buyNowInfo.setPrice(productDTO.getPrice());
            buyNowInfo.setTotalPrice(productDTO.getPrice() * quantity);
            buyNowInfo.setVariantId(productVariantDTO.getProduct_variant_id());

            // Lưu thông tin vào session
            HttpSession session = req.getSession();
            session.setAttribute("buyNowInfo", buyNowInfo);

            // Lấy danh sách địa chỉ của user (nếu đã đăng nhập)
            UserDTO currentUser = (UserDTO) session.getAttribute("user");
            if (currentUser != null) {
                List<UserAddressDTO> userAddresses = userAddressDAO.getAddressesByUserId(currentUser.getUser_id());
                req.setAttribute("userAddresses", userAddresses);
            }

            // Chuyển hướng đến trang checkout
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Dữ liệu không hợp lệ");
            try {
                req.getRequestDispatcher("error.jsp").forward(req, resp);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi trong quá trình xử lý");
            try {
                req.getRequestDispatcher("error.jsp").forward(req, resp);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    public int handleCheckout(HttpServletRequest req, HttpServletResponse resp) {
        
         HttpSession session = req.getSession();
        
        System.out.println("    param userId       = " + req.getParameter("userId"));
        System.out.println("    param productId[]  = " + Arrays.toString(req.getParameterValues("productId")));
        System.out.println("    param variantId[]  = " + Arrays.toString(req.getParameterValues("variantId")));
        System.out.println("    param quantity[]   = " + Arrays.toString(req.getParameterValues("quantity")));
        System.out.println("    param priceEach[]  = " + Arrays.toString(req.getParameterValues("priceEach")));

        // 1) Đọc chung
        UserDTO currentUser = (UserDTO) session.getAttribute("user");
        if (currentUser == null) {
            throw new IllegalStateException("Bạn cần đăng nhập để đặt hàng");
        }
        System.out.println(currentUser.getUser_id());
        
        final Long addressId;
        final PaymentMethod pm;
        try {
            addressId = Long.parseLong(req.getParameter("addressId"));
            pm = PaymentMethod.valueOf(req.getParameter("paymentMethod"));
        } catch (Exception ex) {
            throw new IllegalArgumentException("Địa chỉ hoặc phương thức thanh toán không hợp lệ");
        }
        System.out.println(addressId);
        System.out.println(pm);
        
        Status st        = Status.PENDING;
        LocalDateTime now= LocalDateTime.now();

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
        List<ItemDTO> items = new ArrayList<>(pIds.length);
        try {
            
        
        for (int i = 0; i < pIds.length; i++) {
            int pid = Integer.parseInt(pIds[i]);
            int vid = Integer.parseInt(vIds[i]);
            int qty = Integer.parseInt(qtys[i]);
            double pr = Double.parseDouble(pricesArr[i]);
            items.add(new ItemDTO(pid, vid, qty, pr));
        }
        } catch (NumberFormatException ex) {
                throw new IllegalArgumentException("Dữ liệu số lượng/giá sản phẩm không hợp lệ");
        }
        
        System.out.println("da lay duoc items"+ items);
        
        // 5) Tính tổng
        double total = items.stream()
                            .mapToDouble(it -> it.getPriceEach() * it.getQuantity())
                            .sum();
        System.out.println("da tinh duoc total"+ total);
        // 6) Build DTO
        TotalBuyingDTO dto = new TotalBuyingDTO();
        dto.setUserId(currentUser.getUser_id());
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

            for (ItemDTO it : items) {
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
            req.getSession().removeAttribute("buyNowInfo");
            req.getSession().setAttribute("message", "✔ Đặt hàng thành công!");
            resp.sendRedirect(req.getContextPath() + "/MainController?action=loadForHomePage");
            return buyingId;

        } catch (IllegalArgumentException | IllegalStateException ex) {
            throw ex;
        } catch (Exception ex) {
            throw new IllegalStateException("Đặt hàng thất bại, vui lòng thử lại sau");
        }
    }

}
