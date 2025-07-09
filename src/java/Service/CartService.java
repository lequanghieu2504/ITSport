/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.ClientDAO;
import DTOs.CartItemDTO;
import DTOs.ClientDTO;
import DTOs.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author SUPPER LOQ
 */
public class CartService {

    private static final CartDAO cartDAO = new CartDAO();
    private static final CartItemDAO cartItemDAO = new CartItemDAO();

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

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ClientDTO client = ClientDAO.getClientByUserId(user.getUser_id());
        if (client == null) {
            response.sendRedirect("error.jsp");
            return;
        }
        int cart_id = client.getCart_id();
        List<CartItemDTO> listCI = cartItemDAO.getAllCartItems(cart_id);
//        ProductDTO product = 
        request.setAttribute("listCartItem", listCI);
        request.getRequestDispatcher(CART_PAGE).forward(request, response);
    }

}
