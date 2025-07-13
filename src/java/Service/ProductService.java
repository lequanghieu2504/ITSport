package Service;

import DAO.BrandDAO;
import DAO.CartDAO;
import DAO.ImageDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DTOs.BrandDTO;
import DTOs.ClientDTO;
import DTOs.ImageDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import Enums.ImageType;
import Enums.Size;
import Mapper.ProductMapper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.List;

public class ProductService {

    private static final CartDAO cartDAO = new CartDAO();
    private static final ProductDAO productDAO = new ProductDAO();
    private static final BrandDAO brandDAO = new BrandDAO();
    private ImageService imageService;
    private static final ImageDAO imageDAO = new ImageDAO();

    public ProductService(ServletContext context) {
        this.imageService = new ImageService(context);
    }

    public void handleInsertProduct(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("vo duoc insertProduct");
        String url = "/admin/adminDashboard.jsp";
        request.setAttribute("section", "createProduct");

        //khuc nay bat loi chi tiet va nho la neu sai thi tra ve null va gui lai thong tin ma nguoi dung vua nhap 
        ProductDTO productDTO = ProductMapper.toProductDTOFromRequest(request);

        if (productDTO != null) {

            Long success = productDAO.insertProduct(productDTO);
            if (success > 0) {

                try {
                    //sau khi them thanh cong thi moi add anh
                    Part mainImagePart = request.getPart("MainImage");
                    boolean imageSaved = imageService.saveImageByType(ImageType.PRODUCT_MAIN.toString(), success, mainImagePart, request.getServletContext());
                    if (imageSaved) {
                        request.getSession().setAttribute("message", "them san pham thanh cong");
                    } else {
                        request.getSession().setAttribute("message", "them san pham thanh cong(anh bi loi)");

                    }

                    url = "MainController?action=loadForProductCreateVariantForm";
                    request.setAttribute("productId", success);
                } catch (IOException ex) {
                    Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ServletException ex) {
                    Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
                }
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

    public void handleViewDetailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String product_id = request.getParameter("pid");
        String selectedColor = request.getParameter("color");
        String selectedSize = request.getParameter("size");

        if (product_id == null || product_id.isEmpty()) {
            response.sendRedirect("MainController?action=loadForHomePage");
            return;
        }

        long pid = Long.parseLong(product_id);
        ProductDTO product = productDAO.getProductById(pid);
        ProductVariantDAO variantDAO = new ProductVariantDAO();

        List<ProductVariantDTO> variantList = variantDAO.getByProductVariantId(pid);
        List<String> availableColors = variantDAO.getAvailableColors(pid);
        List<Size> availableSizes = variantDAO.getAvailableSizes(pid);

        ProductVariantDTO selectedVariant = null;
        if (selectedColor != null && selectedSize != null) {
            selectedVariant = variantDAO.getVariant(pid, selectedColor, selectedSize);
        }

        HttpSession session = request.getSession();
        ClientDTO client = (ClientDTO) session.getAttribute("client");
        int cartSize = 0;
        if (client != null) {
            cartSize = cartDAO.getCartSize(client.getCart_id());
        }

        request.setAttribute("cartSize", cartSize);
        request.setAttribute("pid", product_id);
        request.setAttribute("product", product);
        request.setAttribute("variantList", variantList);
        request.setAttribute("availableColors", availableColors);
        request.setAttribute("availableSizes", availableSizes);
        request.setAttribute("selectedColor", selectedColor);
        request.setAttribute("selectedSize", selectedSize);
        request.setAttribute("selectedVariant", selectedVariant);

        request.getRequestDispatcher("detail.jsp").forward(request, response);
    }

    public void handleViewAllProductByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String strCategoryId = request.getParameter("cid");
        Long category_id = null;
        try {
            category_id = Long.parseLong(strCategoryId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        List<ProductDTO> listP = productDAO.getProductsByCategoryId(category_id);
        List<BrandDTO> listB = brandDAO.getAllBrand();

        request.setAttribute("listBrand", listB);
        request.setAttribute("cid", strCategoryId);
        request.setAttribute("listP", listP);
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }

    public void handleInsertProductAdvanced(HttpServletRequest request, HttpServletResponse response) {
        String url = "/admin/adminDashboard.jsp";
        request.setAttribute("section", "createProduct");

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
        } catch (ServletException | IOException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) {
        try {
            String idStr = request.getParameter("StrProductId");
            String statusStr = request.getParameter("status");

            if (idStr != null && statusStr != null) {
                long productId = Long.parseLong(idStr);
                boolean status = Boolean.parseBoolean(statusStr);
                productDAO.updateStatus(productId, status);
            }

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
        } catch (ServletException | IOException ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response) {
        try {
            Long productId = Long.parseLong(request.getParameter("StrProductId"));
            ProductDTO oldProduct = productDAO.getProductById(productId);

            if (oldProduct == null) {
                request.getSession().setAttribute("message", "Không tìm thấy sản phẩm");
                response.sendRedirect("MainController?action=loadForListProductForm");
                return;
            }

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

    private void setMainImageToProducts(List<ProductDTO> listP) {
        for (ProductDTO dto : listP) {
            setMainImageToProduct(dto);
        }
    }

    private void setMainImageToProduct(ProductDTO dto) {
        try {
            ImageDTO MainImageDTO = new ImageDTO();
            List<ImageDTO> listImage = imageDAO.getImagesByTarget(dto.getProduct_id(), ImageType.PRODUCT_MAIN);
            if (!(listImage.isEmpty())) {
                MainImageDTO = listImage.get(0);
                dto.setImg_url(MainImageDTO.getFile_name());
            } else {
                return;
            }
        } catch (Exception ex) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
