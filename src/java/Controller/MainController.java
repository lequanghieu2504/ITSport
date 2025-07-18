/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
@MultipartConfig
public class MainController extends HttpServlet {

    private static final String DEFAULT_ACTION = "loadForHomePage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = "/PageController";
        String action = request.getAttribute("action") != null
                ? (String) request.getAttribute("action")
                : request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = DEFAULT_ACTION;
            request.setAttribute("action", action);
        }

        try {
            if (isUserAction(action)) {
                url = "/UserController";
            } else if (isPageLoadAction(action)) {
                url = "/PageController";
            } else if (isProductAction(action)) {
                url = "/ProductController";
            } else if (isUserBuyingInforAction(action)) {
                url = "/UserBuyingController";
            } else if (isBuyingAction(action)) {
                url = "/BuyingController";
            } else if (isImageAction(action)) {
                url = "/ImageController";
            } else if (isCartAction(action)) {
                url = "/CartController";
            } else if (isCategoryaAction(action)) {
                url = "/CategoryController";
            } else if (isBrandAction(action)) {
                url = "/BrandController";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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

    private boolean isPageLoadAction(String action) {
        return "loadForHomePage".equalsIgnoreCase(action)
                || "loadForCreateForm".equalsIgnoreCase(action)
                || "loadForListProductForm".equalsIgnoreCase(action)
                || "loadEditForm".equalsIgnoreCase(action)
                || "loadForProductCreateVariantForm".equalsIgnoreCase(action)
                || "LoadViewProductDetail".equalsIgnoreCase(action)
                || "LoadForcreateVariantForm".equalsIgnoreCase(action)
                || "viewDetailProduct".equalsIgnoreCase(action)
                || "loadForListBuying".equalsIgnoreCase(action)
                || "loadForListCategory".equalsIgnoreCase(action)
                || "loadForListBrand".equalsIgnoreCase(action)
                || "loadForRevenue".equalsIgnoreCase(action);

    }

    private boolean isProductAction(String action) {
        return "insertProduct".equalsIgnoreCase(action)
                || "toggleStatus".equalsIgnoreCase(action)
                || "deleteProduct".equalsIgnoreCase(action)
                || "createVariant".equalsIgnoreCase(action)
                || "updateProduct".equalsIgnoreCase(action)
                || "productByCategory".equalsIgnoreCase(action)
                || "GetProductDetail".equalsIgnoreCase(action);
    }

    private boolean isUserBuyingInforAction(String action) {
        return "create".equals(action)
                || "update".equals(action)
                || "delete".equals(action)
                || "listAddress".equals(action)
                || "addUserBuyingInfor".equalsIgnoreCase(action)
                || "updateUserBuyingInfor".equalsIgnoreCase(action)
                || "deleteUserBuyingInfor".equalsIgnoreCase(action);
    }

    private boolean isUserAction(String action) {
        return "login".equals(action)
                || "logout".equals(action)
                || "register".equals(action)
                ||"profile".equalsIgnoreCase(action)
                ||"myOrders".equalsIgnoreCase(action)
                ||"CancelOrderStatuByUser".equalsIgnoreCase(action);
    }

    private boolean isImageAction(String action) {
        return "updateMainProductImage".equalsIgnoreCase(action)
                || "insertMainProductImage".equalsIgnoreCase(action)
                || "deleteProductImage".equalsIgnoreCase(action)
                || "AddToProductVariantImage".equalsIgnoreCase(action)
                || "DeleteProductVariantImage".equalsIgnoreCase(action)
                || "addImageCategory".equalsIgnoreCase(action)
                || "deleteImageCategory".equalsIgnoreCase(action)
                || "uploadBrandImage".equalsIgnoreCase(action)
                || "deleteBrandImage".equalsIgnoreCase(action);
    }

    private boolean isBuyingAction(String action) {
        return "buyNow".equals(action)
                || "checkout".equalsIgnoreCase(action)
                || "cartCheckout".equals(action)
                || "UpdateBuyingStatus".equalsIgnoreCase(action);
    }

    private boolean isCartAction(String action) {
        return "addToCart".equalsIgnoreCase(action)
                || "removeFromCart".equalsIgnoreCase(action)
                || "updateCart".equalsIgnoreCase(action)
                || "viewCart".equalsIgnoreCase(action)
                || "getCartSize".equalsIgnoreCase(action)
                || "updateQuantity".equalsIgnoreCase(action);
    }

    private boolean isCategoryaAction(String action) {
        return "deleteCategory".equalsIgnoreCase(action)
                || "addCategory".equalsIgnoreCase(action);
    }

    private boolean isBrandAction(String action) {
        return "addBrand".equalsIgnoreCase(action);
    }

}
