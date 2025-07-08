/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.BrandDAO;
import DAO.ProductDAO;
import DTOs.BrandDTO;
import DTOs.ProductDTO;
import Mapper.ProductMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ProductService {
    private  ProductDAO productDAO = new ProductDAO();
    private  BrandDAO brandDAO = new BrandDAO();
    
    public void handleInsertProduct(HttpServletRequest request, HttpServletResponse response) {
        //khuc nay bat loi chi tiet va nho la neu sai thi tra ve null va gui lai thong tin ma nguoi dung vua nhap 
        ProductDTO productDTO = ProductMapper.toProductDTOFromRequest(request);
        
        if(productDTO!=null){
            boolean success = productDAO.insertProduct(productDTO);
        }
    }
    
    public void handleViewDetailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String product_id = request.getParameter("pid");
        ProductDTO product = productDAO.getProductById(product_id);
        
        request.setAttribute("pid", product_id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("detail.jsp").forward(request, response);
    }
    
    public void handleViewAllProductByCategory (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category_id = request.getParameter("cid");
        List<ProductDTO> listP = productDAO.getProductsByCategoryId(category_id);
        List<BrandDTO> listB = null;
                
        request.setAttribute("cid", category_id);
        request.setAttribute("listP", listP);
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }
}
