/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.ProductVariantDAO;
import DTOs.ProductVariantDTO;
import Mapper.ProductVariantMapper;
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
public class ProductVariantService {

    ProductVariantDAO productVariantDAO = new ProductVariantDAO();

    public void handleCreateProductVariant(HttpServletRequest request, HttpServletResponse response) {
        try {

            String StrProductId = request.getParameter("StrProductId");


            ProductVariantDTO productVariantDTO = ProductVariantMapper.toVariantDTOFromRequest(request);

            if (StrProductId == null || StrProductId.trim().isEmpty()) {
                request.setAttribute("message", "you need to fill product id");
            } else {
                boolean sucess = productVariantDAO.InsertProductVariant(productVariantDTO);
                if (sucess) {
                    request.getSession().setAttribute("message", "tao product variant thanh cong");
                } else {
                    request.getSession().setAttribute("message", "tao product variant khong thanh cong");

                }

            }
       
            response.sendRedirect("MainController?action=LoadViewProductDetail&StrProductId=" + StrProductId);

        }  catch (IOException ex) {
            Logger.getLogger(ProductVariantService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
