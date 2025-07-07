/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.UserDAO;
import DTOs.UserDTO;
import Enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.PasswordUtils;

/**
 *
 * @author ASUS
 */
public class UserService {

    private UserDAO userDAO = new UserDAO();

    public void handleLogin(HttpServletRequest request, HttpServletResponse response) {
        try {
            String url = "login.jsp";
            
            String StrUserName = request.getParameter("StrUserName");
            String StrPassword = request.getParameter("StrPassword");
            
            String rawPassword = PasswordUtils.hashPassword(StrPassword);
            
            UserDTO userDTO = userDAO.getUserByUserName(StrUserName);
            
            if (userDTO == null) {
                request.setAttribute("message", "Can not login");
            } else {
                request.getSession().setAttribute("user", userDTO);
                url = "welcome.jsp";
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void handleRegister(HttpServletRequest request, HttpServletResponse response) {

        String url = "login.jsp";

        String StrUserName = request.getParameter("StrUserName");
        String StrFullName = request.getParameter("StrFullName");
        String StrPassword = request.getParameter("StrPassword");
//        String StrEmail = request.getParameter("StrEmail");
        String hashPassword = util.PasswordUtils.hashPassword(StrPassword);

        UserDTO newUserDTO = new UserDTO();
        newUserDTO.setUsername(StrUserName);
        newUserDTO.setFullName(StrFullName);
        newUserDTO.setPassword(StrPassword);
        newUserDTO.setRole(Role.CLIENT);

//neu dang ky cho Admin
//        newUserDTO.setRole(Role.ADMIN);
        boolean success = userDAO.insertUser(newUserDTO);
        if (success) {
            try {
                request.getSession().setAttribute("message", "Add Success");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            } catch (ServletException ex) {
                Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                url = "register.jsp";
                request.getSession().setAttribute("message", "Can Not Register Now");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            } catch (ServletException ex) {
                Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
