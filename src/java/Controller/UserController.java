/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Service.UserService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UserService userService = new UserService();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String method = request.getMethod();
        if ("login".equalsIgnoreCase(action)) {
            if ("GET".equalsIgnoreCase(method)) {
                // Chỉ hiển thị form login
                request.getRequestDispatcher("login.jsp")
                        .forward(request, response);
                return;
            } else {
                // POST mới xử lý login
                userService.handleLogin(request, response);
                return;
            }
        } else if ("register".equalsIgnoreCase(action)) {
            if ("GET".equalsIgnoreCase(method)) {
                // Chỉ hiển thị form register
                request.getRequestDispatcher("register.jsp")
                        .forward(request, response);
                return;
            } else {
                // POST mới xử lý register
                userService.handleRegister(request, response);
                return;
            }
        } else if ("logout".equalsIgnoreCase(action)) {
            userService.handleLogout(request, response);
            return;
        } else if ("profile".equalsIgnoreCase(action)) {
            userService.handleGetProfile(request, response);
        } else if ("myOrders".equalsIgnoreCase(action)) {
            userService.handleGetUserOrder(request, response);
        } else if ("CancelOrderStatuByUser".equalsIgnoreCase(action)) {
            userService.cancelOrderStatusByUserId(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
