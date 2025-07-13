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

    private static final String LOGIN_PAGE = "login.jsp";

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
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getAttribute("action") != null
                    ? (String) request.getAttribute("action")
                    : request.getParameter("action");
            System.out.println(action);
            //---- Xu ly cac action cua User -----
            if (isUserAction(action)) {
                url = "/UserController";
            } else if (isPageLoadAction(action)) {
                url = "/PageController";
            } else if (isProductAction(action)) {
                System.out.println("check duoc product action");
                url = "/ProductController";
            } else if (isUserBuyingInforAction(action)) {
                url = "/UserBuyingController";
            } else if (isBuyingAction(action)){
                url = "/BuyingController";
            }
            else if(isImageAction(action)){
                url = "/ImageController";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println(url);
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
                || "viewDetailProduct".equalsIgnoreCase(action);

    }

    private boolean isProductAction(String action) {
        return "insertProduct".equalsIgnoreCase(action)
                || "toggleStatus".equalsIgnoreCase(action)
                || "deleteProduct".equalsIgnoreCase(action)
                || "createVariant".equalsIgnoreCase(action)
                || "updateProduct".equalsIgnoreCase(action)
                || "productByCategory".equalsIgnoreCase(action);
    }

    private boolean isUserBuyingInforAction(String action) {
        return "create".equals(action)
                || "update".equals(action)
                || "delete".equals(action)
                || "listAddress".equals(action)
                ||"addUserBuyingInfor".equalsIgnoreCase(action);
    }

    private boolean isUserAction(String action) {
        return "login".equals(action)
                || "logout".equals(action)
                || "register".equals(action);
    }
    private boolean isImageAction(String action){
        return "updateMainProductImage".equalsIgnoreCase(action)
                ||"insertMainProductImage".equalsIgnoreCase(action)
                ||"deleteProductImage".equalsIgnoreCase(action)
                ||"AddToProductVariantImage".equalsIgnoreCase(action)
                ||"DeleteProductVariantImage".equalsIgnoreCase(action);
    }
    private boolean isBuyingAction(String action) {
        return "buyNow".equals(action)
                || "checkout".equalsIgnoreCase(action);
//                || "updateStatus".equals(action);
    }
}
