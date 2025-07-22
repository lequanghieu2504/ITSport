/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Service.ProductService;
import Service.ProductVariantService;
import config.AppContextHolder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.AuthUntil;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private ProductService productService = new ProductService(AppContextHolder.getContext());
    private ProductVariantService productVariantService = new ProductVariantService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");

        System.out.println(">>> [Controller] action: " + action);
        System.out.println(">>> [Controller] keyword: " + keyword);

        if ("insertProduct".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                productService.handleInsertProduct(request, response);
                return;
            }
        } else if ("toggleStatus".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                productService.handleToggleStatus(request, response);
                return;
            }
        } else if ("deleteProduct".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                productService.handleDeleteProduct(request, response);
                return;
            }
        } else if ("createVariant".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                productVariantService.handleCreateProductVariant(request, response);
                return;
            }
        } else if ("updateProduct".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                productService.handleUpdateProduct(request, response);
                return;
            }
        } else if ("viewDetailProduct".equalsIgnoreCase(action)) {

            productService.handleViewDetailProduct(request, response);
            return;

        } else if ("productByCategory".equalsIgnoreCase(action)) {
            productService.handleViewAllProductByCategory(request, response);
            return;
        } else if ("GetProductDetail".equalsIgnoreCase(action)) {
            productService.handleViewDetailForAdmin(request, response);
        } else if ("searchProduct".equalsIgnoreCase(action)) {
            productService.handleSearchProduct(request, response);
        } else if ("productByBrand".equalsIgnoreCase(action)) {
            productService.handleGetByBrandId(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method. >>>>>>> phase1-admin
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
     * ======= throws ServletException, IOException { processRequest(request,
     * response); } * /** Handles the HTTP <code>POST</code> method. >>>>>>>
     * phase1-admin
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
     * ======= throws ServletException, IOException { processRequest(request,
     * response); }
     *
     * /**
     * Returns a short description of the servlet. >>>>>>> phase1-admin
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
