package Service;

import DAO.BrandDAO;
import Enums.ImageType;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author SUPPER LOQ
 */
public class BrandService {

    private final BrandDAO brandDAO = new BrandDAO();

    public void handleAddBrand(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 1️⃣ Lấy tên brand từ form
            String brandName = request.getParameter("brandName");

            // 2️⃣ Thêm brand vào DB, trả về brandId mới
            long newBrandId = brandDAO.insertBrand(brandName);

            // 3️⃣ Lấy file hình ảnh (nếu có)
            Part brandImagePart = request.getPart("brandImage");

            ServletContext context = request.getServletContext();
            ImageService imageService = new ImageService(context);

            if (brandImagePart != null && brandImagePart.getSize() > 0) {
                boolean saved = imageService.saveImageByType(ImageType.BRAND.toString(), newBrandId, brandImagePart, context);
                if (saved) {
                    System.out.println("Lưu ảnh brand thành công");
                } else {
                    System.out.println("Lưu ảnh brand thất bại");
                }
            }

            if (newBrandId != -1) {
                request.getSession().setAttribute("message", "Thêm brand thành công.");
            } else {
                request.getSession().setAttribute("message", "Thêm brand thất bại.");
            }

            // 4️⃣ Chuyển hướng về danh sách brand
            response.sendRedirect("MainController?action=loadForListBrand");

        } catch (Exception ex) {
            Logger.getLogger(BrandService.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("message", "Đã xảy ra lỗi khi thêm brand: " + ex.getMessage());
            try {
                response.sendRedirect("MainController?action=loadForListBrand");
            } catch (IOException e) {
                Logger.getLogger(BrandService.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }
}
