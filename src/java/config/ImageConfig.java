package config;

import jakarta.servlet.ServletContext;

public class ImageConfig {

    public static final String BASE_IMAGE_PATH = "/images";

    public static String getFolderByType(String imageType) {
        if (imageType == null) {
            return "/others";
        }

        switch (imageType) {
            case "PRODUCT_MAIN":
                return "/product/main";
            case "PRODUCT_VARIANT":
                return "/product/variant";
            case "CATEGORY":
                return "/category";
            case "BRAND":
                return "/brand";
            default:
                return "/others";
        }
    }

    /**
     * ✅ Thư mục lưu ảnh kèm entityId
     */
    public static String getUploadFolder(String imageType, Long entityId) {
        return BASE_IMAGE_PATH + getFolderByType(imageType) + "/" + entityId;
    }

    /**
     * ✅ Tính realPath tuyệt đối để xoá file
     */
    public static String getAbsolutePath(ServletContext context, String relativePath) {
        if (!relativePath.startsWith("/")) {
            relativePath = "/" + relativePath;
        }
        return context.getRealPath(relativePath);
    }
}
