/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ImageDAO;
import Service.ImageService;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ImageController", urlPatterns = {"/ImageController"})
public class ImageController extends HttpServlet {

    private  ImageService imageService;

    public ImageController() {
    }

    @Override
    public void init() throws ServletException {
        ServletContext context = getServletContext();
        imageService = new ImageService(context);
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

        String action = request.getParameter("action");
        System.out.println("chek trong imageController" + action);
        if ("updateMainProductImage".equalsIgnoreCase(action)) {
            imageService.updateMainProductImage(request, response);
        } else if ("insertMainProductImage".equalsIgnoreCase(action)) {
            imageService.handleAddMainProductImage(request, response);
        }
        else if("deleteProductImage".equalsIgnoreCase(action)){
            imageService.handleDeleteImage(request,response);
        }
        else if("AddToProductVariantImage".equalsIgnoreCase(action)){
            imageService.handleAddVariantImage(request,response);
        }
        else if("DeleteProductVariantImage".equalsIgnoreCase(action)){
            imageService.handleDeleteImage(request, response);
        }
        else if("addImageCategory".equalsIgnoreCase(action)){
            imageService.handleAddImageForCategory(request,response);
        }
        else if("deleteImageCategory".equalsIgnoreCase(action)){
            imageService.handleDeleteImageCategory(request, response);
        }
        else if("uploadBrandImage".equalsIgnoreCase(action)){
            imageService.handleAddImageForBrand(request,response);
        }
        else if("deleteBrandImage".equalsIgnoreCase(action)){
            imageService.handleDeleteBrandImage(request,response);
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
