/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.CartDAO;
import DTOs.ClientDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author SUPPER LOQ
 */
public class CartService {

    private static final CartDAO cartDAO = new CartDAO();
    
    public void handleAddToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        ClientDTO client = (ClientDTO) session.getAttribute("user"); // đã login
        if (client == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        cartDAO.addToCart(client.getCart_id(), productId, quantity);

        response.sendRedirect("MainController?action=viewCart");
    }

    public void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void handleUpdateCart(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void handleViewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String CART_PAGE = "cart.jsp";
        request.getRequestDispatcher(CART_PAGE).forward(request, response);
    }
    
}
