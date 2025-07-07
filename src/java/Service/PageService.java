/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.BrandDAO;
import DAO.CategoryDAO;
import DAO.ProductDAO;
import DTOs.BrandDTO;
import DTOs.CategoryDTO;
import DTOs.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class PageService {

    CategoryDAO categoryDAO = new CategoryDAO();
    ProductDAO productDAO = new ProductDAO();
    BrandDAO brandDAO = new BrandDAO();

    public void loadForHomePage(HttpServletRequest request, HttpServletResponse response) {

        try {
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<ProductDTO> listNewP = productDAO.getNewProducts();
            //1 la category_id cho ao,2 la category_id cho quan nha may cu dung co lon
            List<ProductDTO> listAo = productDAO.getProductsByCategoryId(1);
            List<ProductDTO> listQ = productDAO.getProductsByCategoryId(2);
            List<ProductDTO> productListP = productDAO.getSuggestedProducts();

            request.setAttribute("listC", listC);
            request.setAttribute("listNewP", listNewP);
            request.setAttribute("listAo", listAo);
            request.setAttribute("listQ", listQ);
            request.setAttribute("productListP", productListP);

// lay thong tin het thi forward toi trang home de load len
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void loadForCreateForm(HttpServletRequest request, HttpServletResponse response){
        try {
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<BrandDTO> listB = brandDAO.getAllBrand();
            
            request.setAttribute("listB", listB);
            request.setAttribute("listC", listC);
            
            request.getRequestDispatcher("/admin/adminDashboard.jsp?section=product").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
