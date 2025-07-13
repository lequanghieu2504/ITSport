// Service/BuyingService.java
package Service;

import DAO.BuyingDAO;
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

public class BuyingService {

    private final BuyingDAO buyingDAO = new BuyingDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final UserBuyingInforDAO userBuyingInforDAO = new UserBuyingInforDAO();

    public void handleBuyNowProcess(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println("vo duoc buyingservice roi");
        try {
            // Lấy thông tin từ request
            String strProductId = req.getParameter("StrProductId");
            String strColor = req.getParameter("StrColor");
            String strSize = req.getParameter("StrSize");
            String strQuantity = req.getParameter("StrQuantity");
            
            System.out.println(strProductId + "1");
            System.out.println(strColor +"2");
            System.out.println(strSize + "3");
            System.out.println(strQuantity+"4");

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
    
public void handleCartCheckoutProcess(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
    // 1) Debug đầu vào
    System.out.println("[handleCartCheckout] StrProductId[] = " + Arrays.toString(req.getParameterValues("StrProductId")));
    System.out.println("[handleCartCheckout] StrColor[]     = " + Arrays.toString(req.getParameterValues("StrColor")));
    System.out.println("[handleCartCheckout] StrSize[]      = " + Arrays.toString(req.getParameterValues("StrSize")));
    System.out.println("[handleCartCheckout] StrQuantity[]  = " + Arrays.toString(req.getParameterValues("StrQuantity")));

    try {
        String[] pIds   = req.getParameterValues("StrProductId");
        String[] colors = req.getParameterValues("StrColor");
        String[] sizes  = req.getParameterValues("StrSize");
        String[] qtys   = req.getParameterValues("StrQuantity");

        // 2) Validate cơ bản
        if (pIds == null || colors == null || sizes == null || qtys == null
                || pIds.length != colors.length
                || pIds.length != sizes.length
                || pIds.length != qtys.length) {
            req.setAttribute("error", "Dữ liệu giỏ hàng không hợp lệ");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        // 3) Build DTO list
        List<BuyNowInforDTO> cartInfos = new ArrayList<>(pIds.length);
        for (int i = 0; i < pIds.length; i++) {
            long productId = Long.parseLong(pIds[i]);
            String color   = colors[i];
            String size    = sizes[i];
            int quantity   = Integer.parseInt(qtys[i]);

            // Lấy dữ liệu
            ProductVariantDTO variant = variantDAO.getByColorAndSize(color, size);
            ProductDTO product = productDAO.getProductById(productId);

            if (variant == null) {
                throw new IllegalArgumentException("Không tìm thấy variant: " + color + " / " + size);
            }

            // 3.a) Log chi tiết trước khi tạo DTO
            System.out.println(String.format(
                "Building item %d: productId=%d, productName=%s, variantId=%d, color=%s, size=%s, quantity=%d, productPrice=%.2f",
                i, productId, product.getProduct_name(), variant.getProduct_variant_id(), color, size, quantity, product.getPrice()
            ));

            // Tạo DTO
            BuyNowInforDTO info = new BuyNowInforDTO();
            info.setProductId(productId);
            info.setVariantId(variant.getProduct_variant_id());
            info.setColor(color);
            info.setSize(size);
            info.setQuantity(quantity);
            info.setPrice(product.getPrice());
            info.setTotalPrice(product.getPrice() * quantity);
            info.setProductName(product.getProduct_name());

            // 3.b) Log toàn bộ DTO bằng toString()
            System.out.println("Created DTO: " + info);

            cartInfos.add(info);
        }
        
        req.setAttribute("cartInfos", cartInfos);

        // 4) Log toàn bộ list
        System.out.println("Final cartInfos list:");
        for (BuyNowInforDTO dto : cartInfos) {
            System.out.println("  - " + dto);
        }

        // 5) Lưu session
        HttpSession session = req.getSession();
        session.setAttribute("cartCheckoutInfo", cartInfos);

        // 6) Load địa chỉ user
            UserDTO currentUser = (UserDTO) session.getAttribute("user");
            if (currentUser != null) {
                List<UserBuyingInfoDTO> userBuyingInfoDTOs = userBuyingInforDAO.getUserBuyingInforByUserId(currentUser.getUser_id());
                if (!(userBuyingInfoDTOs == null || userBuyingInfoDTOs.isEmpty())) {
                    req.setAttribute("userBuyingInfoDTOs", userBuyingInfoDTOs);
                }
            }

        // 7) Forward sang checkout.jsp
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
        TotalBuyingDTO dto = prepareOrderData(req, currentUser);
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

    private TotalBuyingDTO prepareOrderData(HttpServletRequest req, UserDTO user) {
        
        String[] pIds = req.getParameterValues("productId");
        String[] vIds = req.getParameterValues("variantId");
        String[] qtys = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("priceEach");
        if (pIds == null || pIds.length != vIds.length || pIds.length != qtys.length || pIds.length != prices.length) {
            throw new IllegalArgumentException("Thiếu hoặc không đồng bộ các tham số sản phẩm");
        }

        // 2) gom cac item lai va tinh tien
        List<ItemDTO> items = new ArrayList<>();
        double total = 0;
        for (int i = 0; i < pIds.length; i++) {
            int pid = Integer.parseInt(pIds[i]);
            int vid = Integer.parseInt(vIds[i]);
            int qty = Integer.parseInt(qtys[i]);
            double price = Double.parseDouble(prices[i]);
            items.add(new ItemDTO(pid, vid, qty, price));
            total += price * qty;
        }

        //set cac thong tin lai
        TotalBuyingDTO dto = new TotalBuyingDTO();
        dto.setUserId(user.getUser_id());
        dto.setItems(items);
        dto.setTotalPrice(total);

        //dia chi
        long addressId = Long.parseLong(req.getParameter("selectedAddress"));
        UserBuyingInfoDTO addr = userBuyingInforDAO.getUserBuyingInforById(addressId);
        if (addr == null) {
            throw new IllegalArgumentException("Vui lòng chọn địa chỉ giao hàng");
        }
        dto.setUserBuyingInforId(addressId);

        //payment
        dto.setPaymentMethod(PaymentMethod.valueOf(req.getParameter("paymentMethod")));
        dto.setStatus(Status.PENDING);
        LocalDateTime now = LocalDateTime.now();
        dto.setCreatedAt(now);
        dto.setUpdatedAt(now);

        return dto;
    }
    
    //tong duyet 1 lan cuoi, check cac logic de tao don hang
    private int processTransaction(HttpServletRequest req, HttpServletResponse resp, TotalBuyingDTO dto) {
        try (Connection conn = JDBCConnection.getConnection()) {
            HttpSession session = req.getSession();
            conn.setAutoCommit(false);
            for (ItemDTO it : dto.getItems()) {
                int stock = variantDAO.getStock(conn, it.getVariantId());
                if (stock < it.getQuantity()) {
                    session.setAttribute("message","Không đủ số lượng hàng!");
                    return -1;
                }
                variantDAO.updateStock(conn, it.getVariantId(), stock - it.getQuantity());
            }
            int buyId = buyingDAO.insertBuying(dto, conn);
            conn.commit();
            session.removeAttribute("buyNowInfo");
            session.setAttribute("message", "Đặt hàng thành công!");
            resp.sendRedirect(req.getContextPath() + "/MainController?action=loadForHomePage");
            return buyId;
        } catch (Exception e) {
            throw new IllegalStateException("Đặt hàng thất bại, vui lòng thử lại sau");
        }
    }
}
