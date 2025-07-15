/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// Service/UserAddressService.java
package Service;

import DAO.UserBuyingInforDAO;
import DTOs.UserBuyingInfoDTO;
import DTOs.UserDTO;
import Mapper.UserBuyingInforMapper;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserAddressService {

    private UserBuyingInforDAO userBuyingInforDAO = new UserBuyingInforDAO();

//    public void handleCreate(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int userId = Integer.parseInt(request.getParameter("user_id"));
//        String address = request.getParameter("address");
//
//        UserBuyingInforDTO dto = new UserBuyingInforDTO();
//        dto.setUserId(userId);
//        dto.setAddress(address);
//
//        boolean success = userAddressDAO.insertAddress(dto);
//        response.sendRedirect("MainController?action=listAddress&user_id=" + userId);
//    }
//
//    public void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        String address = request.getParameter("address");
//
//        UserBuyingInforDTO dto = new UserBuyingInforDTO();
//        dto.setId(id);
//        dto.setAddress(address);
//
//        userAddressDAO.updateAddress(dto);
//        response.sendRedirect("MainController?action=listAddress&user_id=" + request.getParameter("user_id"));
//    }
//
//    public void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        int userId = Integer.parseInt(request.getParameter("user_id"));
//
//        userAddressDAO.deleteAddress(id);
//        response.sendRedirect("MainController?action=listAddress&user_id=" + userId);
//    }
//
//    public void handleList(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Long userId = Long.parseLong(request.getParameter("user_id"));
//        List<UserBuyingInforDTO> addresses = userAddressDAO.getAddressesByUserId(userId);
//        request.setAttribute("addresses", addresses);
//        request.setAttribute("user_id", userId);
//        try {
//            request.getRequestDispatcher("addressList.jsp").forward(request, response);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
    public void addUserBuyingInfor(HttpServletRequest request, HttpServletResponse response) {

        UserBuyingInfoDTO userBuyingInfoDTO = UserBuyingInforMapper.toUserBuyingInfoDTOFromRequest(request);
        UserDTO userDTO = (UserDTO) request.getSession().getAttribute("user");
        if (userDTO == null) {
            try {
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } catch (ServletException ex) {
                Logger.getLogger(UserAddressService.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(UserAddressService.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else {
            userBuyingInfoDTO.setUserId(userDTO.getUser_id());
        }
        if (userBuyingInfoDTO != null) {
            boolean saved = userBuyingInforDAO.createUserBuyingInfo(userBuyingInfoDTO);
            List<UserBuyingInfoDTO> userBuyingInfoDTOAfterAdd = userBuyingInforDAO.getUserBuyingInforByUserId(userDTO.getUser_id());
            if (saved) {
                request.getSession().setAttribute("message", "them dia chi thanh cong");
                request.getSession().setAttribute("userBuyingInfoDTOs", userBuyingInfoDTOAfterAdd);
                try {
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);
                } catch (ServletException ex) {
                    Logger.getLogger(UserAddressService.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(UserAddressService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }

    public void deleteUserBuyingInforById(HttpServletRequest request, HttpServletResponse response) {
        String url = "checkout.jsp";

        try {
            String strUserInforId = request.getParameter("userBuyingInforId");
            long userInforId = Long.parseLong(strUserInforId);

            UserDTO userDTO = (UserDTO) request.getSession().getAttribute("user");
            long userId = userDTO.getUser_id();

            boolean success = userBuyingInforDAO.deleteUserInforById(userInforId);

            if (success) {
                request.getSession().setAttribute("message", "Xóa thông tin thành công");
            } else {
                request.getSession().setAttribute("message", "Xóa thông tin không thành công");
            }

            // Refresh the address list after delete
            List<UserBuyingInfoDTO> listU = userBuyingInforDAO.getUserBuyingInforByUserId(userId);
            request.setAttribute("userBuyingInfoDTOs", listU);

            // Forward back to checkout page
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Có lỗi xảy ra khi xóa thông tin");
            try {
                RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public void updateUserBuyingInforById(HttpServletRequest request, HttpServletResponse response) {
        String url = "checkout.jsp"; // Set the redirect URL to checkout page

        try {
            UserBuyingInfoDTO userBuyingInfoDTO = UserBuyingInforMapper.toUserBuyingInfoDTOFromRequest(request);
            UserDTO userDTO = (UserDTO) request.getSession().getAttribute("user");
            long userId = userDTO.getUser_id();

            if (userBuyingInfoDTO != null) {
                boolean success = userBuyingInforDAO.updateUserBuyingInfor(userBuyingInfoDTO);
                if (success) {
                    request.getSession().setAttribute("message", "Thay đổi thông tin thành công");
                } else {
                    request.getSession().setAttribute("message", "Thay đổi thông tin không thành công");
                }
            }

            // Refresh the address list after update
            List<UserBuyingInfoDTO> listU = userBuyingInforDAO.getUserBuyingInforByUserId(userId);
            request.setAttribute("userBuyingInfoDTOs", listU);

            // Preserve the checkout data (buyNowInfo or cartInfos) in session or request
            // This ensures the checkout page displays correctly after redirect
            if (request.getSession().getAttribute("buyNowInfo") != null) {
                // If it's a buy now flow, the buyNowInfo should already be in session
                // No additional action needed
            } else if (request.getSession().getAttribute("cartInfos") != null) {
                // If it's a cart checkout flow, the cartInfos should already be in session
                // No additional action needed
            }

            // Forward back to checkout page
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Có lỗi xảy ra khi cập nhật thông tin");
            url = "checkout.jsp";
            try {
                RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
