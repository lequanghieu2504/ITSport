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
        UserDTO userDTO = (UserDTO)request.getSession().getAttribute("user");
        if(userDTO== null){
            try {
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } catch (ServletException ex) {
                Logger.getLogger(UserAddressService.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(UserAddressService.class.getName()).log(Level.SEVERE, null, ex);
            }
                    
        }
        else{
            userBuyingInfoDTO.setUserId(userDTO.getUser_id());
        }
       if(userBuyingInfoDTO!=null){
           boolean saved = userBuyingInforDAO.createUserBuyingInfo(userBuyingInfoDTO);
           List<UserBuyingInfoDTO> userBuyingInfoDTOAfterAdd = userBuyingInforDAO.getUserBuyingInforByUserId(userDTO.getUser_id());
           if(saved){
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
}
