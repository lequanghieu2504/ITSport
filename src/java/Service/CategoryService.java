/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.CategoryDAO;
import Enums.ImageType;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import javax.naming.Context;
/**
 *
 * @author ASUS
 */
public class CategoryService {

    CategoryDAO categoryDAO = new CategoryDAO();

    public void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response) {
        try {
            String strCategoryId = request.getParameter("category_id");
            long categoryId = Long.parseLong(strCategoryId);

            // ✅ 1. Kiểm tra trước: Danh mục này có danh mục con không?
            boolean hasChild = categoryDAO.hasChildCategory(categoryId);

            if (hasChild) {
                request.getSession().setAttribute("message",
                        "Không thể xoá. Danh mục này vẫn còn danh mục con. Hãy xoá hoặc chuyển danh mục con trước!");
            } else {
                boolean deleted = categoryDAO.deleteCategoryById(categoryId);
                if (deleted) {
                    request.getSession().setAttribute("message", "Xoá danh mục thành công.");
                } else {
                    request.getSession().setAttribute("message", "Xoá danh mục thất bại.");
                }
            }

            request.getRequestDispatcher("MainController?action=loadForListCategory").forward(request, response);

        } catch (ServletException | IOException ex) {
            Logger.getLogger(CategoryService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(CategoryService.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("message", "Đã xảy ra lỗi khi xoá danh mục: " + ex.getMessage());
            try {
                response.sendRedirect("MainController?action=loadForListCategory");
            } catch (IOException e) {
                Logger.getLogger(CategoryService.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public void handleAddCategory(HttpServletRequest request, HttpServletResponse response) {
        try {
            // Lấy dữ liệu text
            String categoryName = request.getParameter("category_name");
            String parentIdStr = request.getParameter("parent_id");
            long parentId = 0;
            if (parentIdStr != null && !parentIdStr.isEmpty()) {
                parentId = Long.parseLong(parentIdStr);
            }

            // Lấy file upload
            Part filePart = request.getPart("imageFile");
            
            
            // Gọi DAO để lưu DB
            long inserted = categoryDAO.addCategory(categoryName, parentId);
            ServletContext context = request.getServletContext();
            ImageService imageService = new ImageService(context);
            
            imageService.saveImageByType(ImageType.CATEGORY.toString(),inserted,filePart,context);
            
            if (inserted != -1) {
                request.getSession().setAttribute("message", "Thêm danh mục thành công.");
            } else {
                request.getSession().setAttribute("message", "Thêm danh mục thất bại.");
            }

            // Chuyển hướng về danh sách
            response.sendRedirect("MainController?action=loadForListCategory");

        } catch (Exception ex) {
            Logger.getLogger(CategoryService.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("message", "Đã xảy ra lỗi khi thêm danh mục: " + ex.getMessage());
            try {
                response.sendRedirect("MainController?action=loadForListCategory");
            } catch (IOException e) {
                Logger.getLogger(CategoryService.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }
}
