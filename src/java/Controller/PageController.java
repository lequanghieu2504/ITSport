/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Service.PageService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.AuthUntil;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "PageController", urlPatterns = {"/PageController"})
public class PageController extends HttpServlet {

    private PageService pageService;

    @Override
    public void init() throws ServletException {
        // Khởi tạo PageService và truyền context ở đây
        this.pageService = new PageService(getServletContext());
    }

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
        System.out.println("vo duoc pageController");
        String action = request.getAttribute("action") != null
                ? (String) request.getAttribute("action")
                : request.getParameter("action");
        System.out.println("check trong pageController" + action);
        if ("loadForHomePage".equalsIgnoreCase(action)) {
            pageService.loadForHomePage(request, response);
            return;
        } else if ("loadForCreateForm".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {
                pageService.loadForCreateForm(request, response);
                return;
            }
        } else if ("loadForListProductForm".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {
                pageService.loadForListProduct(request, response);
                return;
            }
        } else if ("loadEditForm".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.loadEditForm(request, response);
                return;
            }
        } else if ("loadForProductCreateVariantForm".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.handleCreateForCreateProductVariantForm(request, response);
                return;
            }
        } else if ("LoadViewProductDetail".equalsIgnoreCase(action)) {
            pageService.LoadViewProductDetail(request, response);
            return;
        } else if ("LoadForcreateVariantForm".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.LoadForcreateVariantForm(request, response);
                return;
            }
        } else if ("viewDetailProduct".equalsIgnoreCase(action)) {
            pageService.handleViewDetailProduct(request, response);
            return;
        } else if ("loadForListBuying".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.handleLoadListBuyingForAdmin(request, response);
                return;
            }
        } else if ("loadForListCategory".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.handleLoadForCategory(request, response);
                return;
            }
        } else if ("loadForListBrand".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.handleLoadForBrandList(request, response);
                return;
            }
        } else if ("loadForRevenue".equalsIgnoreCase(action)) {
            if (AuthUntil.isAdmin(request.getSession())) {

                pageService.handleForRevenuePage(request, response);
                return;
            }
        }
        else{
            request.getRequestDispatcher("MainController?action=loadForHomePage").forward(request, response);
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
