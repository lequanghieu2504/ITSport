package Service;

import DAO.ImageDAO;
import DTOs.ImageDTO;
import DTOs.ProductDTO;
import Enums.ImageType;
import config.ImageConfig;
import interfaces.HasImage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ImageService {

    private final ServletContext context;
    private final ImageDAO imageDAO;

    public ImageService(ServletContext context) {
        this.context = context;
        this.imageDAO = new ImageDAO(); // Hoặc inject từ ngoài nếu muốn mock/test
    }

    /**
     * ✅ Lưu ảnh vào thư mục và DB
     */
    public boolean saveImageByType(String imageType, Long entityId, Part imagePart, ServletContext context) {
        try {
            if (imagePart == null || context == null || imageType == null || entityId == null) {
                return false;
            }

            // 1. Lấy thư mục theo loại ảnh
            String baseFolder = ImageConfig.getFolderByType(imageType); // Ví dụ: /product/main
            String relativeFolder = "/images" + baseFolder + "/" + entityId; // Ví dụ: /images/product/main/7
            String realFolderPath = context.getRealPath(relativeFolder); // D:\...web\images\product\main\7

            // 2. Tạo thư mục nếu chưa tồn tại
            File folder = new File(realFolderPath);
            if (!folder.exists()) {
                folder.mkdirs();
            }

            // 3. Lấy tên file và lưu ảnh
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String fullPath = realFolderPath + File.separator + fileName;
            imagePart.write(fullPath);
            System.out.println("Đã lưu ảnh tại: " + fullPath);

            // 4. Lưu URL ảnh vào DB nếu muốn
            String imageUrl = relativeFolder + "/" + fileName; // → /images/product/main/7/ten_anh.jpg
            ImageDTO dto = new ImageDTO();
            dto.setTarget_id(entityId);
            dto.setTargetType(ImageType.valueOf(imageType.toUpperCase()));
            dto.setFile_name(imageUrl);
            new ImageDAO().insertImage(dto); // Nếu bạn có ImageDAO

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    /**
     * ✅ Lấy danh sách ảnh theo targetId + imageType
     */
    public List<ImageDTO> getImagesByTarget(Long targetId, ImageType imageType) throws Exception {
        return imageDAO.getImagesByTarget(targetId, imageType);
    }

    /**
     * Helper lấy đuôi file
     */
    private String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName == null) {
            return "";
        }
        int dot = submittedFileName.lastIndexOf(".");
        return (dot > 0) ? submittedFileName.substring(dot) : "";
    }

    public void addImagesToEntity(Long entityId, ImageType imageType, List<? extends HasImage> entities) {
        if (entityId == null || imageType == null || entities == null) {
            return;
        }
        List<ImageDTO> images = imageDAO.getImagesByTarget(entityId, imageType);
        if (!images.isEmpty()) {
            // Ví dụ chỉ lấy ảnh đầu tiên làm đại diện
            String imgUrl = images.get(0).getFile_name();
            for (HasImage entity : entities) {
                entity.setImg_url(imgUrl);
            }
        }
    }

    public void addImagesToEntityForList(List<? extends HasImage> list, ImageType imageType) {
        if (list != null) {
            for (HasImage entity : list) {
                Long entityId = null;
                if (entity instanceof ProductDTO) {
                    entityId = ((ProductDTO) entity).getProduct_id();
                }
                // sau này có thể thêm if khác cho BrandDTO, CategoryDTO...

                if (entityId != null) {
                    List<ImageDTO> images = imageDAO.getImagesByTarget(entityId, imageType);
                    if (!images.isEmpty()) {
                        entity.setImg_url(images.get(0).getFile_name());
                    }
                }
            }
        }
    }

    public void updateMainProductImage(HttpServletRequest request, HttpServletResponse response) {
        try {
            Long product_id = Long.parseLong(request.getParameter("StrProductId"));

            // 1️⃣ Lấy ảnh cũ để biết tên file cũ
            String oldFileName = imageDAO.getMainImageFileNameByProductId(product_id);
            if (oldFileName != null && !oldFileName.isEmpty()) {
                // Xoá file vật lý
                String basePath = request.getServletContext().getRealPath("/");
                File oldFile = new File(basePath, oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }

                // Xoá record trong DB
                imageDAO.deleteMainImageByProductIdAndTargetType(product_id, ImageType.PRODUCT_MAIN);
            }

            // 2️⃣ Lấy file mới
            Part filePart = request.getPart("MainImage");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Tạo đường dẫn lưu file mới
            String uploadPath = request.getServletContext().getRealPath("/") + "/images/product/" + product_id;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);

            ImageDTO imageDTO = new ImageDTO();
            imageDTO.setTarget_id(product_id);
            imageDTO.setTargetType(ImageType.PRODUCT_MAIN);
            imageDTO.setFile_name(fileName);
            // 3️⃣ Lưu thông tin ảnh mới vào DB
            imageDAO.insertImage(imageDTO);

            // Chuyển hướng hoặc load lại form
            response.sendRedirect("MainController?action=loadEditProductForm&productId=" + product_id);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void handleAddMainProductImage(HttpServletRequest request, HttpServletResponse response) {

        try {
            String str_productId = request.getParameter("StrProductId");
            String url = "MainController?action=loadEditForm&StrProductId=" + str_productId;

            Long product_id = Long.parseLong(str_productId);
            Part mainImagePart = request.getPart("MainImage");
            request.setAttribute("StrProductId", str_productId);
            boolean success = saveImageByType(ImageType.PRODUCT_MAIN.toString(), product_id, mainImagePart, request.getServletContext());
            if (success) {
                request.setAttribute("message", "them anh thanh cong");
            } else {
                request.setAttribute("message", "them anh khong thanh cong");
            }
            response.sendRedirect(url);
        } catch (IOException ex) {
            Logger.getLogger(ImageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ServletException ex) {
            Logger.getLogger(ImageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean deleteImageById(Long imageId) {
        try {
            ImageDTO image = imageDAO.getImageById(imageId);
            if (image != null) {
                boolean dbDeleted = imageDAO.deleteImageById(imageId);
                if (dbDeleted) {
                    // ✅ Lấy real path đúng chuẩn
                    String fullPath = ImageConfig.getAbsolutePath(context, image.getFile_name());

                    File file = new File(fullPath);
                    if (file.exists()) {
                        file.delete();
                    }
                    return true;
                }
            }
        } catch (Exception e) {
            Logger.getLogger(ImageService.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public void handleDeleteImage(HttpServletRequest request, HttpServletResponse response) {
        try {
            String productId = request.getParameter("StrProductId");

            String url = "MainController?action=loadEditForm&StrProductId=" + productId;

            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("DeleteProductVariantImage")) {
                url = "MainController?action=LoadViewProductDetail&StrProductId=" + productId;
            }

            Long imageId = Long.parseLong(request.getParameter("StrImageId"));
            System.out.println(imageId);

            boolean success = deleteImageById(imageId);

            if (success) {
                request.getSession().setAttribute("message", "Xóa ảnh thành công");
            } else {
                request.getSession().setAttribute("message", "Xóa ảnh thất bại");
            }

            // Điều hướng lại trang chi tiết sản phẩm hoặc nơi hiển thị ảnh
            response.sendRedirect(url);
        } catch (Exception e) {
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void handleAddVariantImage(HttpServletRequest request, HttpServletResponse response) {
        try {

            String StrVariantId = request.getParameter("StrVariantId");

            String StrProductId = request.getParameter("StrProductId");
            Long variantId = Long.parseLong(StrVariantId);
            String url = "MainController?action=LoadViewProductDetail&StrProductId=" + StrProductId;

            Part mainImagePart = request.getPart("variantImage");
            request.setAttribute("StrProductId", StrProductId);

            boolean success = saveImageByType(ImageType.PRODUCT_VARIANT.toString(), variantId, mainImagePart, request.getServletContext());
            if (success) {
                request.setAttribute("message", "them anh thanh cong");
            } else {
                request.setAttribute("message", "them anh khong thanh cong");
            }
            response.sendRedirect(url);
        } catch (IOException ex) {
            Logger.getLogger(ImageService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ServletException ex) {
            Logger.getLogger(ImageService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
