// Service/BuyingService.java
package Service;

import DAO.BuyingDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.UserAddressDAO;
import DTOs.BuyNowInforDTO;
import DTOs.BuyingDTO;
import DTOs.BuyingDTO.Item;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import DTOs.UserAddressDTO;
import DTOs.UserDTO;
import Enums.PaymentMethod;
import Enums.Status;
import jakarta.servlet.ServletException;
import util.JDBCConnection;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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

}
