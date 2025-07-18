package Service;

import DAO.CartDAO;
import DAO.CartItemDAO;
import DTOs.CartItemDTO;
import DTOs.ClientDTO;
import DTOs.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartService {

    private static final CartDAO cartDAO = new CartDAO();
    private static final CartItemDAO cartItemDAO = new CartItemDAO();

    public void handleAddToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        ClientDTO client = (ClientDTO) session.getAttribute("client");
        if (client == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int cartId = client.getCart_id();
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int variantId = Integer.parseInt(request.getParameter("variant_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        CartItemDTO existingItem = cartDAO.getCartItem(cartId, productId, variantId);
        if (existingItem != null) {
            int updatedQuantity = existingItem.getQuantity() + quantity;
            cartDAO.updateCartItemQuantity(cartId, productId, variantId, updatedQuantity);
        } else {
            cartDAO.insertCartItem(cartId, productId, variantId, quantity);
        }

        int cartSize = cartDAO.getCartSize(cartId);
        session.setAttribute("cartSize", cartSize);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":true, \"cartSize\":" + cartSize + "}");
    }

    public void handleViewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("buyNowInfo");

        UserDTO user = (UserDTO) session.getAttribute("user");
        ClientDTO client = (ClientDTO) session.getAttribute("client");

        if (user == null || client == null) {
            response.sendRedirect("MainController?action=loadForHomePage");
            return;
        }

        int cartId = client.getCart_id();
        int cartSize = cartDAO.getCartSize(cartId);
        List<CartItemDTO> cartItems = cartItemDAO.getAllCartItems(cartId);

        request.setAttribute("cartSize", cartSize);
        request.setAttribute("listCartItem", cartItems);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    public void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        ClientDTO client = (ClientDTO) session.getAttribute("client");

        if (client == null) {
            response.sendRedirect("MainController?action=loadForHomePage");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("product_id"));
        int variantId = Integer.parseInt(request.getParameter("variant_id"));
        cartDAO.deleteCartItem(client.getCart_id(), productId, variantId);

        int cartSize = cartDAO.getCartSize(client.getCart_id());
        session.setAttribute("cartSize", cartSize);
        response.sendRedirect("MainController?action=viewCart");
    }

    public void handleUpdateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        ClientDTO client = (ClientDTO) session.getAttribute("client");

        if (client == null) {
            response.sendRedirect("MainController?action=loadForHomePage");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int variantId = Integer.parseInt(request.getParameter("variant_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            cartDAO.updateCartItemQuantity(client.getCart_id(), productId, variantId, quantity);

            int cartSize = cartDAO.getCartSize(client.getCart_id());
            session.setAttribute("cartSize", cartSize);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"message\":\"updated\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public void handleGetCartSize(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        ClientDTO client = (ClientDTO) session.getAttribute("client");
        int size = 0;
        if (client != null) {
            size = cartDAO.getCartSize(client.getCart_id());
        }
        response.setContentType("application/json");
        response.getWriter().write("{\"size\":" + size + "}");
    }

    public void handleUpdateQuantity(HttpServletRequest request, HttpServletResponse response) {
        try {
            String strCartItemId = request.getParameter("cartItemId");
            String strQuantity = request.getParameter("quantity");

            long cartItemId = Long.parseLong(strCartItemId);
            int quantity = Integer.parseInt(strQuantity);

            cartItemDAO.updateQuantity(cartItemId, quantity);

            request.getRequestDispatcher("MainController?action=viewCart").forward(request, response);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(CartService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
