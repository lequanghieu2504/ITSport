/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.BrandDAO;
import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.CategoryDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DTOs.BrandDTO;
import DTOs.CartItemDTO;
import DTOs.CategoryDTO;
import DTOs.ClientDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
    ProductVariantDAO productVariantDAO = new ProductVariantDAO();
    CartDAO cartDAO = new CartDAO();
    CartItemDAO cartItemDAO = new CartItemDAO();

    public void loadForHomePage(HttpServletRequest request, HttpServletResponse response) {

        try {
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<ProductDTO> listNewP = productDAO.getNewProducts();
            List<ProductDTO> listAo = productDAO.getProductsByCategoryId(1);
            List<ProductDTO> listQ = productDAO.getProductsByCategoryId(2);
            List<ProductDTO> productListP = productDAO.getSuggestedProducts();

            HttpSession session = request.getSession();
            ClientDTO client = (ClientDTO) session.getAttribute("client");

            if (client != null) {
                int cart_id = client.getCart_id();
                List<CartItemDTO> cartItems = cartItemDAO.getAllCartItems(cart_id);
                int cartSize = cartDAO.cartSize(cartItems);
                session.setAttribute("cartSize", cartSize); // Gán vào session để hiện ở header
            }

            request.setAttribute("listC", listC);
            request.setAttribute("listNewP", listNewP);
            request.setAttribute("listAo", listAo);
            request.setAttribute("listQ", listQ);
            request.setAttribute("productListP", productListP);

        // lay thong tin het thi forward toi trang home de load len
            request.getRequestDispatcher("/homepage/homepage.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void loadForCreateForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<BrandDTO> listB = brandDAO.getAllBrand();

            request.setAttribute("listB", listB);
            request.setAttribute("listC", listC);
            request.setAttribute("section", "createProduct");
            request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void loadForListProduct(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<ProductDTO> list = productDAO.getAllProductWithCategoryAndBrandName();

            request.setAttribute("productList", list);
            request.setAttribute("section", "product");

            request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void loadEditForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setAttribute("section", "editProduct");
            String StrProductId = request.getParameter("StrProductId");
            Long product_id = Long.parseLong(StrProductId);
            ProductDTO productDTO = productDAO.getProductById(product_id);
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<BrandDTO> listB = brandDAO.getAllBrand();

            request.setAttribute("product", productDTO);
            request.setAttribute("listC", listC);
            request.setAttribute("listB", listB);

            request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void handleCreateForCreateProductVariantForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            String url = "admin/adminDashboard.jsp";

            String StrProductId = request.getParameter("productId");
            Long product_id = Long.parseLong(StrProductId);
            ProductDTO productDTO = productDAO.getProductById(product_id);

            if (productDTO != null) {
                request.setAttribute("product", productDTO);
                request.setAttribute("section", "'createVariant");
            } else {
                request.getSession().setAttribute("message", "can not find product");
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void LoadViewProductDetail(HttpServletRequest request, HttpServletResponse response) {
        String url = "admin/adminDashboard.jsp";
        String StrProductId = request.getAttribute("StrProductId") != null
                ? (String) request.getAttribute("StrProductId")
                : request.getParameter("StrProductId");

        if (StrProductId == null || StrProductId.trim().isEmpty()) {
            request.getSession().setAttribute("message", "Ban can nhap product id");
        } else {
            long ProductId = Long.parseLong(StrProductId);

            ProductDTO productDTO = productDAO.getProductById(ProductId);

            List<ProductVariantDTO> variantList = productVariantDAO.getByProductVariantId(ProductId);
            if (productDTO != null) {
                request.setAttribute("section", "viewDetailProduct");
                request.setAttribute("product", productDTO);
                request.setAttribute("variantList", variantList);
            } else {
                request.getSession().setAttribute("message", "khong tim thay san pham");
            }
            try {
                request.getRequestDispatcher(url).forward(request, response);
            } catch (ServletException ex) {
                Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void LoadForcreateVariantForm(HttpServletRequest request, HttpServletResponse response) {
        try {
            String url = "admin/adminDashboard.jsp";

            String StrProductId = request.getParameter("StrProductId");
            Long productId = Long.parseLong(StrProductId);
            if (StrProductId == null || StrProductId.trim().isEmpty()) {
                request.getSession().setAttribute("message", "Ban can nhap product id");
            } else {

                ProductDTO productDTO = productDAO.getProductById(productId);

                if (productDTO != null) {
                    request.setAttribute("section", "CreateDetailProduct");
                    request.setAttribute("product", productDTO);
                } else {
                    request.getSession().setAttribute("message", "khong tim thay san pham");
                }
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void handleViewDetailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String StrProduct_id = request.getParameter("pid");
        Long product_id = Long.parseLong(StrProduct_id);
        ProductDTO product = productDAO.getProductById(product_id);
        List<ProductVariantDTO> variantList = productVariantDAO.getByProductVariantId(product_id);

        request.setAttribute("pid", product_id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("detail.jsp").forward(request, response);
    }

}
