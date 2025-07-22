/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.BrandDAO;
import DAO.BuyingDAO;
import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.CategoryDAO;
import DAO.ImageDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DTOs.BrandDTO;
import DTOs.BuyingForAdminDTO;
import DTOs.CartItemDTO;
import DTOs.CategoryDTO;
import DTOs.ImageDTO;
import DTOs.ClientDTO;
import DTOs.DailyRevenueDTO;
import DTOs.OrderStatusDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import DTOs.StockDTO;
import DTOs.TopProductDTO;
import DTOs.TotalBuyingDTO;
import Enums.ImageType;
import Enums.Status;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 *
 * @author ASUS
 */
public class PageService {

    public PageService() {
    }

    CategoryDAO categoryDAO = new CategoryDAO();
    ProductDAO productDAO = new ProductDAO();
    BrandDAO brandDAO = new BrandDAO();
    ProductVariantDAO productVariantDAO = new ProductVariantDAO();
    ImageDAO imageDAO = new ImageDAO();
    ImageService imageService;
    CartDAO cartDAO = new CartDAO();
    CartItemDAO cartItemDAO = new CartItemDAO();
    BuyingDAO buyingDAO = new BuyingDAO();

    public PageService(ServletContext context) {
        this.imageService = new ImageService(context);
    }

    public void loadForHomePage(HttpServletRequest request, HttpServletResponse response) {

        try {
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<ProductDTO> listNewP = productDAO.getNewProducts();
            List<ProductDTO> listAo = productDAO.getProductsByCategoryId(1);
            List<ProductDTO> listQ = productDAO.getProductsByCategoryId(2);
            List<ProductDTO> productListP = productDAO.getSuggestedProducts();
            List<BrandDTO> listB = brandDAO.getAllBrand();
            HttpSession session = request.getSession();
            ClientDTO client = (ClientDTO) session.getAttribute("client");
            if (client != null) {
                int cart_id = client.getCart_id();
                int cartSize = cartDAO.getCartSize(cart_id);
                session.setAttribute("cartSize", cartSize); // Gán vào session để hiện ở header
            }

            request.getSession().setAttribute("listC", listC);
            request.setAttribute("listNewP", listNewP);
            request.setAttribute("listAo", listAo);
            request.setAttribute("listQ", listQ);
            request.setAttribute("productListP", productListP);
            request.getSession().setAttribute("listB",listB);
            request.getSession().removeAttribute("buyNowInfo");
            request.getSession().removeAttribute("cartInfos");

            request.getSession().removeAttribute("cartCheckoutInfo");

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
        System.out.println("co vao load edit form");
        try {
            request.setAttribute("section", "editProduct");
            String StrProductId = request.getParameter("StrProductId");
            Long product_id = Long.parseLong(StrProductId);
            ProductDTO productDTO = productDAO.getProductById(product_id);
            List<CategoryDTO> listC = categoryDAO.getAllCategories();
            List<BrandDTO> listB = brandDAO.getAllBrand();
            List<ImageDTO> Main_Image_Products = imageDAO.getImagesByTarget(product_id, ImageType.PRODUCT_MAIN);

            request.setAttribute("product", productDTO);
            request.setAttribute("listC", listC);
            request.setAttribute("listB", listB);
            if (!(Main_Image_Products.isEmpty())) {
                request.setAttribute("product_main_image", Main_Image_Products.get(0));
            }
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

            Long product_id = (Long) request.getAttribute("productId");

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
            List<ImageDTO> imageDTOs = imageDAO.getImagesByTarget(productDTO.getProduct_id(), ImageType.PRODUCT_MAIN);
            List<ProductVariantDTO> variantList = productVariantDAO.getByProductVariantId(ProductId);

            // Lấy ảnh của từng biến thể
            Map<Long, List<ImageDTO>> variantImageMap = new HashMap<>();

            for (ProductVariantDTO v : variantList) {
                List<ImageDTO> imgList = imageDAO.getByVariantId(v.getProduct_variant_id());
                variantImageMap.put(v.getProduct_variant_id(), imgList);
            }

            if (productDTO != null) {
                request.setAttribute("section", "viewDetailProduct");
                request.setAttribute("product", productDTO);
                request.setAttribute("variantList", variantList);
                request.setAttribute("", url);
                request.setAttribute("variantImageMap", variantImageMap);

                if (!(imageDTOs.isEmpty())) {
                    request.setAttribute("productMainImages", imageDTOs);
                }
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
                    request.setAttribute("section", "createVariant");
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
        try {
            String strProductId = request.getParameter("pid");
            String selectedColor = request.getParameter("color");
            String selectedSize = request.getParameter("size");

            // Validate product ID
            if (strProductId == null || strProductId.trim().isEmpty()) {
                request.setAttribute("error", "ID sản phẩm không hợp lệ");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            Long productId = Long.parseLong(strProductId);
            ProductDTO product = productDAO.getProductById(productId);

            if (product == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // Lấy tất cả variants của sản phẩm
            List<ProductVariantDTO> allVariants = productVariantDAO.getByProductVariantId(productId);

            // Khởi tạo collections
            Set<String> availableColors = new HashSet<>();
            Set<String> availableSizes = new HashSet<>();

            // Lấy danh sách unique colors và sizes với null safety
            if (allVariants != null && !allVariants.isEmpty()) {
                for (ProductVariantDTO variant : allVariants) {
                    // Kiểm tra variant không null trước khi truy cập thuộc tính
                    if (variant != null) {
                        // Xử lý color an toàn
                        String color = variant.getColor();
                        if (color != null && !color.trim().isEmpty()) {
                            availableColors.add(color.trim());
                        }

                        // Xử lý size an toàn
                        Object size = variant.getSize();
                        if (size != null) {
                            String sizeStr = size.toString().trim();
                            if (!sizeStr.isEmpty()) {
                                availableSizes.add(sizeStr);
                            }
                        }
                    }
                }
            }

            // Lọc variants theo color và size đã chọn
            List<ProductVariantDTO> filteredVariants = new ArrayList<>();

            if (allVariants != null && !allVariants.isEmpty()) {
                // Bắt đầu với tất cả variants hợp lệ
                filteredVariants = allVariants.stream()
                        .filter(Objects::nonNull) // Lọc bỏ null variants
                        .collect(Collectors.toList());

                // Lọc theo color nếu có
                if (selectedColor != null && !selectedColor.trim().isEmpty()) {
                    filteredVariants = filteredVariants.stream()
                            .filter(v -> v.getColor() != null && selectedColor.trim().equals(v.getColor().trim()))
                            .collect(Collectors.toList());
                }

                // Lọc theo size nếu có
                if (selectedSize != null && !selectedSize.trim().isEmpty()) {
                    filteredVariants = filteredVariants.stream()
                            .filter(v -> v.getSize() != null && selectedSize.trim().equals(v.getSize().toString().trim()))
                            .collect(Collectors.toList());
                }
            }

            // *** PHẦN QUAN TRỌNG: Tìm selectedVariant ***
            ProductVariantDTO selectedVariant = null;

            // Nếu đã chọn đủ color và size
            if (selectedColor != null && !selectedColor.trim().isEmpty()
                    && selectedSize != null && !selectedSize.trim().isEmpty()) {

                // Tìm variant chính xác với color và size đã chọn
                selectedVariant = filteredVariants.stream()
                        .filter(v -> v.getColor() != null && selectedColor.trim().equals(v.getColor().trim())
                        && v.getSize() != null && selectedSize.trim().equals(v.getSize().toString().trim()))
                        .findFirst()
                        .orElse(null);
            } // Nếu chỉ chọn color (không có size requirements)
            else if (selectedColor != null && !selectedColor.trim().isEmpty() && availableSizes.isEmpty()) {
                selectedVariant = filteredVariants.stream()
                        .filter(v -> v.getColor() != null && selectedColor.trim().equals(v.getColor().trim()))
                        .findFirst()
                        .orElse(null);
            } // Nếu chỉ chọn size (không có color requirements)
            else if (selectedSize != null && !selectedSize.trim().isEmpty() && availableColors.isEmpty()) {
                selectedVariant = filteredVariants.stream()
                        .filter(v -> v.getSize() != null && selectedSize.trim().equals(v.getSize().toString().trim()))
                        .findFirst()
                        .orElse(null);
            } // Nếu sản phẩm không có variants (chỉ có 1 variant duy nhất)
            else if (availableColors.isEmpty() && availableSizes.isEmpty() && !filteredVariants.isEmpty()) {
                selectedVariant = filteredVariants.get(0);
            }

            // Tính tổng số lượng available
            int totalQuantity = 0;
            if (selectedVariant != null) {
                totalQuantity = selectedVariant.getQuantity();
            } else {
                totalQuantity = filteredVariants.stream()
                        .mapToInt(ProductVariantDTO::getQuantity)
                        .sum();
            }

            // Lấy ảnh chính
            List<ImageDTO> mainImageDTOs = imageService.getImagesByTarget(productId, ImageType.PRODUCT_MAIN);
            if (mainImageDTOs != null && !mainImageDTOs.isEmpty()) {
                ImageDTO mainImage = mainImageDTOs.get(0);
                request.setAttribute("mainImage", mainImage);
            }

            // Lấy ảnh của variants đã lọc
            List<ImageDTO> listProductVariantImage = convertFromProductVariantToListProductVariantImage(filteredVariants);

            // Set attributes
            request.setAttribute("variantImageList", listProductVariantImage);
            request.setAttribute("variantList", filteredVariants);
            request.setAttribute("availableColors", availableColors);
            request.setAttribute("availableSizes", availableSizes);
            request.setAttribute("selectedColor", selectedColor);
            request.setAttribute("selectedSize", selectedSize);
            request.setAttribute("selectedVariant", selectedVariant); // *** THÊM DÒNG NÀY ***
            request.setAttribute("totalQuantity", totalQuantity);      // *** THÊM DÒNG NÀY ***
            request.setAttribute("pid", productId);
            request.setAttribute("product", product);

            request.getRequestDispatcher("detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, "Invalid product ID format", e);
            request.setAttribute("error", "ID sản phẩm không hợp lệ");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, "Error in handleViewDetailProduct", ex);
            request.setAttribute("error", "Đã xảy ra lỗi khi tải thông tin sản phẩm");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

// Phương thức helper để kiểm tra null safety
    private boolean isValidVariant(ProductVariantDTO variant) {
        return variant != null;
    }

    private boolean isValidColor(String color) {
        return color != null && !color.trim().isEmpty();
    }

    private boolean isValidSize(Object size) {
        return size != null && !size.toString().trim().isEmpty();
    }

    private List<ImageDTO> convertFromProductVariantToListProductVariantImage(List<ProductVariantDTO> listVariant) {
        List<ImageDTO> listResult = new ArrayList<>();

        for (ProductVariantDTO productVariantDTO : listVariant) {
            listResult.addAll(imageDAO.getByVariantId(productVariantDTO.getProduct_variant_id()));
        }
        return listResult;
    }

    public void handleLoadListBuyingForAdmin(HttpServletRequest request, HttpServletResponse response) {
        try {
            System.out.println("vao duoc handle load list buying rồi ");

            String url = "admin/adminDashboard.jsp";

            List<BuyingForAdminDTO> listBuying = buyingDAO.getAllBuyingForAdmin();

            // Dùng enum Status để tránh hardcode
            List<Status> statuses = Arrays.asList(Status.values());

            // Gán vào request để JSP duyệt được
            request.setAttribute("statuses", statuses);
            request.setAttribute("section", "listBuyings");
            request.setAttribute("buyings", listBuying);

            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleLoadForCategory(HttpServletRequest request, HttpServletResponse response) {
        try {
            System.out.println("handleLoadForCategory called"); // Debug log
            request.setAttribute("section", "listCategory");

            List<CategoryDTO> categoryDTOs = categoryDAO.getAllCategories();
            System.out.println("Categories loaded: " + categoryDTOs.size()); // Debug log

            request.setAttribute("categoryList", categoryDTOs);

            request.getRequestDispatcher("admin/adminDashboard.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleLoadForBrandList(HttpServletRequest request, HttpServletResponse response) {
        try {

            List<BrandDTO> listB = brandDAO.getAllBrand();

            request.setAttribute("brandList", listB);

            request.setAttribute("section", "listBrand");

            request.getRequestDispatcher("admin/adminDashboard.jsp").forward(request, response);

        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void handleForRevenuePage(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("vao duoc handle revenue roi");
        BigDecimal totalRevenue = buyingDAO.getTotalRevenue();
        List<OrderStatusDTO> ordersByStatusList = buyingDAO.getOrdersByStatus();
        List<DailyRevenueDTO> dailyRevenueList = buyingDAO.getDailyRevenue();
        List<TopProductDTO> topProductsList = productDAO.getTopProducts();
        List<StockDTO> stockList = productDAO.getStockList();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("ordersByStatus", ordersByStatusList);
        request.setAttribute("dailyRevenue", dailyRevenueList);
        request.setAttribute("topProducts", topProductsList);
        request.setAttribute("stockList", stockList);

        request.setAttribute("section", "revenue");
        try {
            request.getRequestDispatcher("admin/adminDashboard.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageService.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
