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
@WebServlet(name="BuyingController", urlPatterns={"/BuyingController"})
public class BuyingController extends HttpServlet {
    private BuyingService buyingService = new BuyingService();

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(">> Enter BuyingController, action=" + action);

        if (!"buyNow".equalsIgnoreCase(action)) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            return;
        }

        try {
            // Gọi handleCreateBuying, luôn trả về buyingId
            int buyingId = buyingService.handleCreateBuying(req);

            req.setAttribute("buyingId", buyingId);
            req.getRequestDispatcher("/orderConfirmation.jsp")
               .forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("/productDetail.jsp")
               .forward(req, resp);
        }
    }

    @Override protected void doGet (HttpServletRequest r, HttpServletResponse s)
            throws ServletException, IOException { processRequest(r, s); }
    @Override protected void doPost(HttpServletRequest r, HttpServletResponse s)
            throws ServletException, IOException { processRequest(r, s); }
}
