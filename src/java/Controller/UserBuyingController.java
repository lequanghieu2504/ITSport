/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// Controller/UserAddressController.java
package Controller;

import Service.UserAddressService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UserBuyingController", urlPatterns = {"/UserBuyingController"})
public class UserBuyingController extends HttpServlet {
    private UserAddressService service = new UserAddressService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "listAddress";

        switch (action) {
//            case "create":
//                service.handleCreate(request, response);
//                break;
//            case "update":
//                service.handleUpdate(request, response);
//                break;
//            case "delete":
//                service.handleDelete(request, response);
//                break;
//            case "listAddress":
            
            case "addUserBuyingInfor":
                service.addUserBuyingInfor(request,response);
            case "deleteUserBuyingInfor":
                service.deleteUserBuyingInforById(request,response);
            case "updateUserBuyingInfor":
                service.updateUserBuyingInforById(request,response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}

