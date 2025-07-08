/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;


import DAO.ProductDAO;
import DTOs.BrandDTO;
import DTOs.ProductDTO;
import Mapper.ProductMapper;
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
public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    public void handleViewDetailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String product_id = request.getParameter("pid");
        ProductDTO product = productDAO.getProductById(product_id);
        
        request.setAttribute("pid", product_id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("detail.jsp").forward(request, response);
    }
    
    public void handleViewAllProductByCategory (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String StrCategory_id = request.getParameter("cid");
        Long category_id = Long.parseLong(StrCategory_id);
        List<ProductDTO> listP = productDAO.getProductsByCategoryId(category_id);
        List<BrandDTO> listB = null;
                
        request.setAttribute("cid", category_id);
        request.setAttribute("listP", listP);
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }

    public void handleInsertProduct(HttpServletRequest request, HttpServletResponse response) {
        String url = "/admin/adminDashboard.jsp";
        request.setAttribute("section", "createProduct");

        //khuc nay bat loi chi tiet va nho la neu sai thi tra ve null va gui lai thong tin ma nguoi dung vua nhap 
        ProductDTO productDTO = ProductMapper.toProductDTOFromRequest(request);

        if (productDTO != null) {

            Long success = productDAO.insertProduct(productDTO);

            if (success > 0) {
                request.getSession().setAttribute("message", "them san pham thanh cong");
                url = "MainController?action=loadForProductCreateVariantForm";
                request.setAttribute("productId", success);
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
            if (deleteSuccess) {
                request.getSession().setAttribute("message", "Deleted product");
            } else {
                request.getSession().setAttribute("message", "Can not delete product");
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response) {
        try {
            Long productId = Long.parseLong(request.getParameter("StrProductId"));
            ProductDTO oldProduct = productDAO.getProductById(String.valueOf(productId));

            if (oldProduct == null) {
                request.getSession().setAttribute("message", "Không tìm thấy sản phẩm");
                response.sendRedirect("MainController?action=loadForListProductForm");
                return;
            }

            // Sử dụng mapper mới
            ProductDTO updatedProduct = ProductMapper.toProductDTOFromRequestToUpdate(request, oldProduct);

            boolean success = productDAO.updateProduct(updatedProduct);

            if (success) {
                request.getSession().setAttribute("message", "Cập nhật thành công");
            } else {
                request.getSession().setAttribute("message", "Cập nhật thất bại");
            }

            response.sendRedirect("MainController?action=loadForListProductForm");
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }
    }

  

}
