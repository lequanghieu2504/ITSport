/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import DTOs.UserDTO;
import Enums.Role;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


/**
 *
 * @author ASUS
 */
public class AuthUntil {
public static boolean isLogin(HttpSession session) {
        return session != null && session.getAttribute("user") != null;
    }

    public static boolean isAdmin(HttpSession session) {
        if (!isLogin(session)) return false;
        UserDTO user = (UserDTO) session.getAttribute("user");
        return user.getRole() == Role.ADMIN;
    }

    public static boolean isClient(HttpSession session) {
        if (!isLogin(session)) return false;
        UserDTO user = (UserDTO) session.getAttribute("user");
        return user.getRole() == Role.CLIENT;
    }

    public static UserDTO getCurrentUser(HttpSession session) {
        if (!isLogin(session)) return null;
        return (UserDTO) session.getAttribute("user");
    }
     public static void forwardToLogin(HttpServletRequest request, HttpServletResponse response,String message) throws IOException {
        try {
            request.setAttribute("message", message);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
 