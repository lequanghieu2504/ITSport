/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.ProductDAO;
import DTOs.ProductDTO;
import Mapper.ProductMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class ProductService {
    private  ProductDAO productDAO = new ProductDAO();
    public void handleInsertProduct(HttpServletRequest request, HttpServletResponse response) {
        //khuc nay bat loi chi tiet va nho la neu sai thi tra ve null va gui lai thong tin ma nguoi dung vua nhap 
        ProductDTO productDTO = ProductMapper.toProductDTOFromRequest(request);
        
        if(productDTO!=null){
            
            boolean success = productDAO.insertProduct(productDTO);
            
        }
    }
    
}
