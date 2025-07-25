// Service/BuyingService.java
package Service;

import DAO.BuyingDAO;
import DAO.CartItemDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.UserBuyingInforDAO;
import DTOs.BuyNowInforDTO;
import DTOs.ItemDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import DTOs.UserBuyingInfoDTO;
import DTOs.TotalBuyingDTO;

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
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BuyingService {

    private final BuyingDAO buyingDAO = new BuyingDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final UserBuyingInforDAO userBuyingInforDAO = new UserBuyingInforDAO();
    private final CartItemDAO cartItemDAO = new CartItemDAO();

    public void handleBuyNowProcess(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println("vo duoc buyingservice roi");
        try {
            // Lấy thông tin từ request
            String strProductId = req.getParameter("StrProductId");
            String strColor = req.getParameter("StrColor");
            String strSize = req.getParameter("StrSize");
            String strQuantity = req.getParameter("StrQuantity");

            System.out.println(strProductId + "1");
            System.out.println(strColor + "2");
            System.out.println(strSize + "3");
            System.out.println(strQuantity + "4");

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
                req.getSession().setAttribute("message", "Không có sản phẩm hợp lệ");
                req.getRequestDispatcher("MainController?action=viewDetailProduct&pid=" + strProductId).forward(req, resp);
                return;
            }

            // Kiểm tra số lượng tồn kho
            if (productVariantDTO.getQuantity() < quantity) {
                req.getSession().setAttribute("message", "Số lượng sản phẩm không đủ");
                req.getRequestDispatcher("MainController?action=viewDetailProduct&pid=" + strProductId).forward(req, resp);
                return;
            }

            // Lấy thông tin sản phẩm chi tiết
            ProductDTO productDTO = productDAO.getProductById(productId);

            if (productDTO == null) {
                req.getSession().setAttribute("message", "Không tìm thấy product " + productVariantDTO.getQuantity());
                req.getRequestDispatcher("MainController?action=viewDetailProduct&pid=" + strProductId).forward(req, resp);
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
            req.getSession().setAttribute("buyNowInfo", buyNowInfo);
            req.getSession().setAttribute("productId                                 ", productId);
            // Lấy danh sách địa chỉ của user (nếu đã đăng nhập)
            UserDTO currentUser = (UserDTO) req.getSession().getAttribute("user");
            if (currentUser != null) {
                List<UserBuyingInfoDTO> userBuyingInfoDTOs = userBuyingInforDAO.getUserBuyingInforByUserId(currentUser.getUser_id());
                if (!(userBuyingInfoDTOs == null || userBuyingInfoDTOs.isEmpty())) {
                    req.setAttribute("userBuyingInfoDTOs", userBuyingInfoDTOs);
                }
            }

            // Chuyển hướng đến trang checkout
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Dữ liệu không hợp lệ");
            try {
                req.getRequestDispatcher("MainController?action=loadForHomePage").forward(req, resp);
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

    public void handleCartCheckoutProcess(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("[handleCartCheckout] StrProductId[] = " + Arrays.toString(req.getParameterValues("StrProductId")));
        System.out.println("[handleCartCheckout] StrColor[]     = " + Arrays.toString(req.getParameterValues("StrColor")));
        System.out.println("[handleCartCheckout] StrSize[]      = " + Arrays.toString(req.getParameterValues("StrSize")));
        System.out.println("[handleCartCheckout] StrQuantity[]  = " + Arrays.toString(req.getParameterValues("StrQuantity")));
        System.out.println("[handleCartCheckout] StrCartItemId[]  = " + Arrays.toString(req.getParameterValues("StrCartItemId")));

        try {
            String[] pIds = req.getParameterValues("StrProductId");
            String[] colors = req.getParameterValues("StrColor");
            String[] sizes = req.getParameterValues("StrSize");
            String[] qtys = req.getParameterValues("StrQuantity");
            String[] cartItemIds = req.getParameterValues("StrCartItemId");

            if (pIds == null || colors == null || sizes == null || qtys == null || cartItemIds == null
                    || pIds.length != colors.length
                    || pIds.length != sizes.length
                    || pIds.length != qtys.length
                    || pIds.length != cartItemIds.length) {
                req.setAttribute("error", "Dữ liệu giỏ hàng không hợp lệ hoặc thiếu CartItemId");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            List<BuyNowInforDTO> cartInfos = new ArrayList<>(pIds.length);
            for (int i = 0; i < pIds.length; i++) {
                long productId = Long.parseLong(pIds[i]);
                String color = colors[i];
                String size = sizes[i];
                int quantity = Integer.parseInt(qtys[i]);
                long cartItemId = Long.parseLong(cartItemIds[i]);

                ProductVariantDTO variant = variantDAO.getByColorAndSize(color, size);
                ProductDTO product = productDAO.getProductById(productId);

                if (variant == null) {
                    throw new IllegalArgumentException("Không tìm thấy variant: " + color + " / " + size);
                }

                BuyNowInforDTO info = new BuyNowInforDTO();
                info.setProductId(productId);
                info.setVariantId(variant.getProduct_variant_id());
                info.setColor(color);
                info.setSize(size);
                info.setQuantity(quantity);
                info.setPrice(product.getPrice());
                info.setTotalPrice(product.getPrice() * quantity);
                info.setProductName(product.getProduct_name());
                info.setCartItemId(cartItemId); // ✅ Đã gán thêm CartItemId

                System.out.println("Created DTO: " + info);
                cartInfos.add(info);
            }

            req.getSession().setAttribute("cartInfos", cartInfos);

            req.getSession().setAttribute("cartCheckoutInfo", cartInfos);

            UserDTO currentUser = (UserDTO) req.getSession().getAttribute("user");
            if (currentUser != null) {
                List<UserBuyingInfoDTO> userBuyingInfoDTOs = userBuyingInforDAO.getUserBuyingInforByUserId(currentUser.getUser_id());
                if (userBuyingInfoDTOs != null && !userBuyingInfoDTOs.isEmpty()) {
                    req.setAttribute("userBuyingInfoDTOs", userBuyingInfoDTOs);
                }
            }

            req.getRequestDispatcher("checkout.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Dữ liệu số / ID không hợp lệ");
            req.getRequestDispatcher("error.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi xử lý giỏ hàng");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

//    public int handleCheckout(HttpServletRequest req, HttpServletResponse resp) {
//
//        HttpSession session = req.getSession();
//
//        System.out.println("    param userId       = " + req.getParameter("userId"));
//        System.out.println("    param productId[]  = " + Arrays.toString(req.getParameterValues("productId")));
//        System.out.println("    param variantId[]  = " + Arrays.toString(req.getParameterValues("variantId")));
//        System.out.println("    param quantity[]   = " + Arrays.toString(req.getParameterValues("quantity")));
//        System.out.println("    param priceEach[]  = " + Arrays.toString(req.getParameterValues("priceEach")));
//
//        // lay thong tin user
//        UserDTO currentUser = (UserDTO) session.getAttribute("user");
//        if (currentUser == null) {
//            throw new IllegalStateException("Bạn cần đăng nhập để đặt hàng");
//        }
//        System.out.println(currentUser.getUser_id());
//
//        // lay dia chi
//        String selectedAddressParam = req.getParameter("selectedAddress");
//        System.out.println("Selected address param: " + selectedAddressParam);
//        Long userBuyingInfo = Long.parseLong(selectedAddressParam);
//
//
//        UserBuyingInfoDTO selectedAddress = userBuyingInforDAO.getUserBuyingInforById(userBuyingInfo);
//
//        if (selectedAddress == null) {
//            throw new IllegalArgumentException("Vui lòng chọn địa chỉ giao hàng");
//        }
//
//        System.out.println("Selected address: " + selectedAddress.getRecipientName() + " - " + selectedAddress.getPhone());
//
//        final PaymentMethod pm;
//        try {
//            pm = PaymentMethod.valueOf(req.getParameter("paymentMethod"));
//        } catch (Exception ex) {
//            throw new IllegalArgumentException("Phương thức thanh toán không hợp lệ");
//        }
//        System.out.println("Payment method: " + pm);
//
//        Status st = Status.PENDING;
//        LocalDateTime now = LocalDateTime.now();
//
//        // 2) Lấy mảng params
//        String[] pIds = req.getParameterValues("productId");
//        String[] vIds = req.getParameterValues("variantId");
//        String[] qtys = req.getParameterValues("quantity");
//        String[] pricesArr = req.getParameterValues("priceEach");
//
//        // 3) Validate mảng đồng bộ
//        if (pIds == null || vIds == null || qtys == null || pricesArr == null
//                || pIds.length != vIds.length
//                || pIds.length != qtys.length
//                || pIds.length != pricesArr.length) {
//            throw new IllegalArgumentException("Thiếu hoặc không đồng bộ các tham số sản phẩm");
//        }
//
//        // 4) Build danh sách items
//        List<ItemDTO> items = new ArrayList<>(pIds.length);
//        try {
//            for (int i = 0; i < pIds.length; i++) {
//                int pid = Integer.parseInt(pIds[i]);
//                int vid = Integer.parseInt(vIds[i]);
//                int qty = Integer.parseInt(qtys[i]);
//                double pr = Double.parseDouble(pricesArr[i]);
//                items.add(new ItemDTO(pid, vid, qty, pr));
//            }
//        } catch (NumberFormatException ex) {
//            throw new IllegalArgumentException("Dữ liệu số lượng/giá sản phẩm không hợp lệ");
//        }
//
//        System.out.println("Đã lấy được items: " + items);
//
//        // 5) Tính tổng
//        double total = items.stream()
//                .mapToDouble(it -> it.getPriceEach() * it.getQuantity())
//                .sum();
//        System.out.println("Đã tính được total: " + total);
//
//        // 6) Build DTO
//        TotalBuyingDTO dto = new TotalBuyingDTO();
//        dto.setUserId(currentUser.getUser_id());
//        dto.setItems(items);
//        dto.setTotalPrice(total);
//
//        // Lưu thông tin địa chỉ vào DTO (có thể cần tạo address record trước)
//        // Tạm thời sử dụng userId làm userBuyingInforId, hoặc bạn có thể tạo logic khác
//        dto.setUserBuyingInforId(currentUser.getUser_id()); // Hoặc logic tạo address record
//
//        dto.setPaymentMethod(pm);
//        dto.setStatus(st);
//        dto.setCreatedAt(now);
//        dto.setUpdatedAt(now);
//
//        // 7) Transaction: reserve stock + insert order/items
//        try ( Connection conn = JDBCConnection.getConnection()) {
//            conn.setAutoCommit(false);
//
//            for (ItemDTO it : items) {
//                int stock = variantDAO.getStock(conn, it.getVariantId());
//                if (stock < it.getQuantity()) {
//                    throw new IllegalStateException(
//                            "Không đủ stock variant " + it.getVariantId()
//                            + ": còn " + stock + ", yêu cầu " + it.getQuantity()
//                    );
//                }
//                variantDAO.updateStock(conn, it.getVariantId(), stock - it.getQuantity());
//            }
//
//            System.out.println(">>> Before calling DAO.insertBuying");
//            int buyingId = buyingDAO.insertBuying(dto, conn);
//            System.out.println(">>> After calling DAO.insertBuying, id = " + buyingId);
//            conn.commit();
//            req.getSession().removeAttribute("buyNowInfo");
//            req.getSession().setAttribute("message", "Đặt hàng thành công!");
//            resp.sendRedirect(req.getContextPath() + "/MainController?action=loadForHomePage");
//            return buyingId;
//
//        } catch (IllegalArgumentException | IllegalStateException ex) {
//            throw ex;
//        } catch (Exception ex) {
//            throw new IllegalStateException("Đặt hàng thất bại, vui lòng thử lại sau");
//        }
//    }
    public int handleCheckout(HttpServletRequest req, HttpServletResponse resp) {
        UserDTO currentUser = validateUser(req);
        TotalBuyingDTO dto = prepareOrderData(req, currentUser, resp);
        return processTransaction(req, resp, dto);
    }

    private UserDTO validateUser(HttpServletRequest req) {
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            throw new IllegalStateException("Bạn cần đăng nhập để đặt hàng");
        }
        return user;
    }

// ...........................................
    private TotalBuyingDTO prepareOrderData(HttpServletRequest req, UserDTO user, HttpServletResponse response) {
        String[] pIds = req.getParameterValues("productId");
        String[] vIds = req.getParameterValues("variantId");
        String[] qtys = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("priceEach");
        String[] cartItemIds = req.getParameterValues("StrCartItemId");

        // ... (các validate về mảng đồng bộ như cũ) ...
        List<ItemDTO> items = new ArrayList<>();
        double total = 0;

        for (int i = 0; i < pIds.length; i++) {
            int pid = Integer.parseInt(pIds[i]);
            int vid = Integer.parseInt(vIds[i]);
            int qty = Integer.parseInt(qtys[i]);
            double price = Double.parseDouble(prices[i]);

            ProductDTO prod = productDAO.getProductById(pid);
            ItemDTO item = new ItemDTO(pid, vid, qty, price);
            item.setProductName(prod != null ? prod.getProduct_name() : "Unknown");

            if (cartItemIds != null) {
                item.setCartItemId(Integer.parseInt(cartItemIds[i]));
            }

            items.add(item);
            total += price * qty;
        }

        TotalBuyingDTO dto = new TotalBuyingDTO();
        dto.setUserId(user.getUser_id());
        dto.setItems(items);
        dto.setTotalPrice(total);

        // --- Phần mới: đọc địa chỉ từ radio 'selectedAddress' ---
        String strAddressId = req.getParameter("selectedAddress");
        if (strAddressId == null || strAddressId.trim().isEmpty()) {
            // lỗi: chưa chọn địa chỉ
            throw new IllegalArgumentException("Vui lòng chọn địa chỉ giao hàng");
        }
        long addressId = Long.parseLong(strAddressId);
        UserBuyingInfoDTO addr = userBuyingInforDAO.getUserBuyingInforById(addressId);
        if (addr == null) {
            throw new IllegalArgumentException("Địa chỉ giao hàng không hợp lệ");
        }
        dto.setShippingName(addr.getRecipientName());
        dto.setShippingPhone(addr.getPhone());
        dto.setShippingStreet(addr.getStreet());
        dto.setShippingWard(addr.getWard());
        dto.setShippingDistrict(addr.getDistrict());
        dto.setShippingProvince(addr.getProvince());
        // --- Hết phần địa chỉ ---

        dto.setPaymentMethod(PaymentMethod.valueOf(req.getParameter("paymentMethod")));
        dto.setStatus(Status.PENDING);

        LocalDateTime now = LocalDateTime.now();
        dto.setCreatedAt(now);
        dto.setUpdatedAt(now);

        return dto;
    }

    //tong duyet 1 lan cuoi, check cac logic de tao don hang
    private int processTransaction(HttpServletRequest req, HttpServletResponse resp, TotalBuyingDTO dto) {
        HttpSession session = req.getSession();
        try ( Connection conn = JDBCConnection.getConnection()) {
            conn.setAutoCommit(false);

            for (ItemDTO it : dto.getItems()) {
                int stock = variantDAO.getStock(conn, it.getVariantId());
                if (stock < it.getQuantity()) {
                    conn.rollback();  // ✅ rollback rõ ràng
                    session.setAttribute("message", "Không đủ số lượng hàng!");
                    return -1;
                }
                variantDAO.updateStock(conn, it.getVariantId(), stock - it.getQuantity());
            }

            long buyId = buyingDAO.insertBuying(dto, conn);
            for (ItemDTO it : dto.getItems()) {
                cartItemDAO.deleteCartItemByCartItemId(it.getCartItemId());
            }

            conn.commit();  // ✅ Commit nếu không lỗi

            // Gửi mail xác nhận (không block flow chính)
            // gán lại vào DTO để MailService có thể đọc
            dto.setBuyingId(buyId);

// gửi mail
            try {
                new MailService().sendOrderConfirmation((UserDTO) req.getSession().getAttribute("user"), dto);
            } catch (Exception ex) {
                Logger.getLogger(BuyingService.class.getName())
                        .log(Level.WARNING, "Gửi mail xác nhận đơn hàng thất bại, đơn " + buyId, ex);
            }

            session.removeAttribute("buyNowInfo");
            session.setAttribute("message", "Đặt hàng thành công!");
            req.getSession().setAttribute("buyingId", buyId);

            if (dto.getPaymentMethod().equals(PaymentMethod.VNPAY)) {
                req.getRequestDispatcher("/payment").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/MainController?action=loadForHomePage");
            }

        } catch (Exception e) {
            System.out.println("LỖI CHI TIẾT: " + e.getClass().getName() + " - " + e.getMessage());
            e.printStackTrace();  // ❗ In log để debug lỗi thật
            throw new IllegalStateException("Đặt hàng thất bại, vui lòng thử lại sau");
        }
        return 0;
    }

    public void handleUpdateBuyingStatus(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String strBuyingId = req.getParameter("strBuyingId");
            Long BuyingId = Long.parseLong(strBuyingId);
            String status = req.getParameter("status");
            boolean success = buyingDAO.updateStatusByBuyingId(BuyingId, status);
            if (success) {
                req.getSession().setAttribute("message", "Cập nhật thành công");
            } else {
                req.getSession().setAttribute("message", "Cập nhật thất bại");
            }
            req.getRequestDispatcher("MainController?action=loadForListBuying").forward(req, resp);
        } catch (ServletException ex) {
            Logger.getLogger(BuyingService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BuyingService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
