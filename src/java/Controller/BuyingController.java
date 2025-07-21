/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Service.BuyingService;

/**
 *
 * @author hieuh
 */
@WebServlet(name = "BuyingController", urlPatterns = {"/BuyingController"})
public class BuyingController extends HttpServlet {

    private BuyingService buyingService = new BuyingService();

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        System.out.println(">> Enter BuyingController, action=" + action);

        if ("buyNow".equalsIgnoreCase(action)) {
            buyingService.handleBuyNowProcess(req, resp);
        } else if ("checkout".equalsIgnoreCase(action)) {
            buyingService.handleCheckout(req, resp);
        } else if ("cartCheckout".equalsIgnoreCase(action)) {
            buyingService.handleCartCheckoutProcess(req, resp);
        } else if ("UpdateBuyingStatus".equalsIgnoreCase(action)) {
            buyingService.handleUpdateBuyingStatus(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest r, HttpServletResponse s)
            throws ServletException, IOException {
        processRequest(r, s);
    }

    @Override
    protected void doPost(HttpServletRequest r, HttpServletResponse s)
            throws ServletException, IOException {
        processRequest(r, s);
    }
}
