/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vnpay.common;

import DAO.BuyingDAO;
import DAO.UserBuyingInforDAO;
import DTOs.ItemDTO;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DTOs.TotalBuyingDTO;
import DTOs.UserBuyingInfoDTO;
import DTOs.UserDTO;
import Enums.PaymentMethod;
import Enums.Status;
import jakarta.servlet.annotation.WebServlet;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author CTT VNPAY
 */
@WebServlet(name="payment", urlPatterns={"/payment"})

public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
    String[] pIds      = req.getParameterValues("productId");
    String[] vIds      = req.getParameterValues("variantId");
    String[] qtys      = req.getParameterValues("quantity");
    String[] prices    = req.getParameterValues("priceEach");
    String   addrIdStr = req.getParameter("selectedAddress");
    String   totalStr  = req.getParameter("totalBill");
    UserDTO  user      = (UserDTO) req.getSession().getAttribute("user");
        System.out.println("hello"+totalStr);
        System.out.println("dang o ajax");
        String bankCode = req.getParameter("bankCode");
//        if(req.getParameter("totalBill") == null) {
//            System.out.println("khong du tien");
////         resp.sendRedirect("cart");
////         return;
//        }
//        BuyingDAO buyingDao = new BuyingDAO();
//        //phan id user se lay tu sesson (user dang login)
//         HttpSession session = req.getSession(false);
//         if (session == null || session.getAttribute("user") == null) {
//            // Chưa login -> chuyển về trang login
//            resp.sendRedirect("login.jsp");
//            return;
//         }
//        String totalBillStr = req.getParameter("totalBill");
//        if (totalBillStr == null) {
////            resp.sendRedirect("cart");
//System.out.println("khong du tien lan 2");
////            return;
//        }
//        double amountDouble = Double.parseDouble(req.getParameter("totalBill"));
//
//        // 2. Lấy đối tượng user từ session
//        UserDTO user = (UserDTO) session.getAttribute("user");
//        Long userId = user.getUser_id();  
//        
//        TotalBuyingDTO order = new TotalBuyingDTO();
//        order.setUserId(userId);
//        order.setTotalPrice(amountDouble);
//        Long orderId;
//        try ( Connection conn = JDBCConnection.getConnection() ) {
//      conn.setAutoCommit(false);
//      TotalBuyingDTO dto = new TotalBuyingDTO();
//      dto.setUserId(user.getUser_id());
//      dto.setTotalPrice(amountDouble);
//      dto.setPaymentMethod(PaymentMethod.VNPAY);
//      orderId = buyingDao.insertBuying(dto, conn);
//      conn.commit();
//            
//    } catch (Exception e) {
//      throw new ServletException("Tạo order PENDING thất bại", e);
//    }

if (pIds == null || vIds == null || qtys == null || prices == null ||
        pIds.length != vIds.length || pIds.length != qtys.length || pIds.length != prices.length) {
        throw new ServletException("Thiếu tham số sản phẩm");
    }
    if (addrIdStr == null) {
        throw new ServletException("Chưa chọn địa chỉ");
    }
    double totalBill;
    try {
        totalBill = Double.parseDouble(totalStr);
    } catch (NumberFormatException ex) {
        throw new ServletException("Giá trị tổng không hợp lệ", ex);
    }

    // 3) Xây dựng DTO TotalBuyingDTO
    TotalBuyingDTO dto = new TotalBuyingDTO();
    dto.setUserId(user.getUser_id());
    dto.setTotalPrice(totalBill);
    dto.setPaymentMethod(PaymentMethod.VNPAY);
    dto.setStatus(Status.PENDING);
    // parse items
    List<ItemDTO> items = new ArrayList<>();
    for (int i = 0; i < pIds.length; i++) {
        int pid = Integer.parseInt(pIds[i]);
        int vid = Integer.parseInt(vIds[i]);
        int q   = Integer.parseInt(qtys[i]);
        double pr = Double.parseDouble(prices[i]);
        items.add(new ItemDTO(pid, vid, q, pr));
        LocalDateTime now = LocalDateTime.now();
        dto.setCreatedAt(now);
        dto.setUpdatedAt(now);
    }
    dto.setItems(items);
    // địa chỉ
    
    UserBuyingInforDAO userBuyingInforDAO = new UserBuyingInforDAO();
    
    long addrId = Long.parseLong(addrIdStr);
    UserBuyingInfoDTO addr = userBuyingInforDAO.getUserBuyingInforById(addrId);
    dto.setShippingName(addr.getRecipientName());
    dto.setShippingPhone(addr.getPhone());
    dto.setShippingStreet(addr.getStreet());
    dto.setShippingWard(addr.getWard());
    dto.setShippingDistrict(addr.getDistrict());
    dto.setShippingProvince(addr.getProvince());

    BuyingDAO buyingDao = new BuyingDAO();
    // 4) Lưu xuống DB với status = PENDING
    long orderId;
    try (Connection conn = JDBCConnection.getConnection()) {
      conn.setAutoCommit(false);
      orderId = buyingDao.insertBuying(dto, conn);
      conn.commit();
    } catch (Exception e) {
      throw new ServletException("Tạo order PENDING thất bại", e);
    }

//        long orderId = 1;

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        
        long amount = (long) (totalBill * 100);
        String vnp_TxnRef = orderId+"";//dky ma rieng
        String vnp_IpAddr = Config.getIpAddress(req);

        String vnp_TmnCode = Config.vnp_TmnCode;
        
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        
        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        
        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        resp.sendRedirect(paymentUrl);
    }
    @Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
    System.out.println(">>> ajaxServlet doGet CALLED");
    resp.setContentType("text/plain;charset=UTF-8");
    resp.getWriter().println("ajaxServlet GET OK");
}

}
