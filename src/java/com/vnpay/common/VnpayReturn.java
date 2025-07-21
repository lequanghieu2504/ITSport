package com.vnpay.common;

import DAO.BuyingDAO;
import DAO.CartItemDAO;
import DTOs.ItemDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import DTOs.TotalBuyingDTO;
import DTOs.UserDTO;
import Enums.Status;

/**
 * Servlet xử lý callback khi VNPAY trả về kết quả giao dịch
 */
@WebServlet(name = "vnpayReturn", urlPatterns = {"/vnpayReturn"})
public class VnpayReturn extends HttpServlet {
    private final BuyingDAO buyingDao = new BuyingDAO();
    private final CartItemDAO cartItemDao = new CartItemDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Đọc tất cả tham số trả về từ VNPAY
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = params.nextElement();
                String fieldValue = request.getParameter(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    String encodedName = URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString());
                    String encodedValue = URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString());
                    fields.put(encodedName, encodedValue);
                }
            }

            // Lấy secure hash do VNPAY trả về
            String vnpSecureHash = request.getParameter("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");
            fields.remove("vnp_SecureHash");

            // Tính lại chữ ký từ dữ liệu nhận được
            String signValue = Config.hashAllFields(fields);

            if (signValue.equals(vnpSecureHash)) {
                // Xác thực hợp lệ
                String orderId = request.getParameter("vnp_TxnRef");
                String responseCode = request.getParameter("vnp_TransactionStatus");

                // Cập nhật trạng thái thanh toán
                TotalBuyingDTO buy = new TotalBuyingDTO();
                buy.setBuyingId(Long.parseLong(orderId));
                boolean transSuccess = "00".equals(responseCode);
                buy.setStatus(transSuccess ? Status.PAID : Status.FAILED);
                buyingDao.updateStatusByBuyingId(buy.getBuyingId(), buy.getStatus().toString());

                // Nếu thanh toán thành công, xóa các mục khỏi giỏ hàng
                if (transSuccess) {
                    HttpSession session = request.getSession(false);
                    if (session != null) {
                        // Lấy danh sách items đã checkout từ session
                        @SuppressWarnings("unchecked")
                        List<ItemDTO> boughtItems = (List<ItemDTO>) session.getAttribute("cartInfos");
                        if (boughtItems != null) {
                            for (ItemDTO it : boughtItems) {
                                cartItemDao.deleteCartItemByCartItemId(it.getCartItemId());
                            }
                            // Xóa attribute cartInfos sau khi xóa
                            session.removeAttribute("cartInfos");
                        }
                    }
                }

                // Forward đến trang kết quả
                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
            } else {
                // Chữ ký không hợp lệ
                System.out.println("GD KO HOP LE (invalid signature)");
                request.setAttribute("transResult", false);
                request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý trả về kết quả VNPAY";
    }
}
