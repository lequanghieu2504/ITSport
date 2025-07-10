/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// Service/UserAddressService.java
package Service;

import DAO.UserAddressDAO;
import DTOs.UserAddressDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class UserAddressService {
    private UserAddressDAO userAddressDAO = new UserAddressDAO();

    public void handleCreate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String address = request.getParameter("address");

        UserAddressDTO dto = new UserAddressDTO();
        dto.setUserId(userId);
        dto.setAddress(address);

        boolean success = userAddressDAO.insertAddress(dto);
        response.sendRedirect("MainController?action=listAddress&user_id=" + userId);
    }

    public void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String address = request.getParameter("address");

        UserAddressDTO dto = new UserAddressDTO();
        dto.setId(id);
        dto.setAddress(address);

        userAddressDAO.updateAddress(dto);
        response.sendRedirect("MainController?action=listAddress&user_id=" + request.getParameter("user_id"));
    }

    public void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));

        userAddressDAO.deleteAddress(id);
        response.sendRedirect("MainController?action=listAddress&user_id=" + userId);
    }

    public void handleList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long userId = Long.parseLong(request.getParameter("user_id"));
        List<UserAddressDTO> addresses = userAddressDAO.getAddressesByUserId(userId);
        request.setAttribute("addresses", addresses);
        request.setAttribute("user_id", userId);
        try {
            request.getRequestDispatcher("addressList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

