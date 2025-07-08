/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.ProductDAO;
import DTOs.ProductDTO;
import Mapper.ProductMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public void handleInsertProduct(HttpServletRequest request, HttpServletResponse response) {
        String url = "/admin/adminDashboard.jsp";
        request.setAttribute("section", "createProduct");

        //khuc nay bat loi chi tiet va nho la neu sai thi tra ve null va gui lai thong tin ma nguoi dung vua nhap 
        ProductDTO productDTO = ProductMapper.toProductDTOFromRequest(request);

        if (productDTO != null) {

            boolean success = productDAO.insertProduct(productDTO);

            if (success) {
                request.getSession().setAttribute("message", "them san pham thanh cong");
            } else {
                request.getSession().setAttribute("message", "them san pham that bai");
            }
        } else {
            request.getSession().setAttribute("message", "co loi trong qua trinh them san pham");
        }
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) {

        try {
            
            try {
                String idStr = request.getParameter("StrProductId");
                String statusStr = request.getParameter("status");
                
                if (idStr != null && statusStr != null) {
                    long productId = Long.parseLong(idStr);
                    boolean status = Boolean.parseBoolean(statusStr); // true hoặc false

                    // Gọi DAO để cập nhật
                    productDAO.updateStatus(productId, status);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // Quay về lại danh sách sản phẩm
            response.sendRedirect("MainController?action=loadForListProductForm");
        } catch (IOException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response) {
        try {
            String StrProductId = request.getParameter("StrProductId");
            String url = "admin/adminDashboard";
            Boolean deleteSuccess = productDAO.deleteProductByProductId(StrProductId);
            
            request.setAttribute("section", "product");
            if(deleteSuccess){
                request.getSession().setAttribute("message", "Deleted product");
            }
            else{
                request.getSession().setAttribute("message", "Can not delete product");
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
 

}
