/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author SUPPER LOQ
 */
public class CartService {

    public void handleAddToCart(HttpServletRequest request, HttpServletResponse response) {
        
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
