/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.CategoryDTO;
import DTOs.ProductDTO;
import DTOs.ProductVariantDTO;
import DTOs.StockDTO;
import DTOs.TopProductDTO;
import Mapper.ProductMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author ASUS
 */
public class ProductDAO {

    private final String BASE_GET_PRODUCT_WITH_IMAGE
            = "SELECT p.*, i.file_name AS img_url FROM Product p LEFT JOIN image i ON p.product_id = i.target_id AND i.target_type = 'PRODUCT_MAIN' where p.status = 1   ";
    private final String BASE_GET_PRODUCT_WITH_IMAGE_For_Admin
            = "SELECT p.*, i.file_name AS img_url FROM Product p LEFT JOIN image i ON p.product_id = i.target_id AND i.target_type = 'PRODUCT_MAIN' where  ";

    private final String GET_PRODUCT = "select * from [Product] ";
    private final String INSERT_PRODUCT = "INSERT INTO [Product] ";
    private final String UPDATE_PRODUCT = "UPDATE [Product] ";
    private final String DELETE_PRODUCT = "Delete FROM [Product] ";

    public List<ProductDTO> getNewProducts() {
        String sql = BASE_GET_PRODUCT_WITH_IMAGE;
        List<ProductDTO> listP = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);

                listP.add(productDTO);
            }
            return listP;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getProductsByCategoryId(long category_id) {

        String sql = BASE_GET_PRODUCT_WITH_IMAGE + " and category_id = ? ";
        List<ProductDTO> listP = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, category_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getSuggestedProducts() {
        List<ProductDTO> listP = new ArrayList<>();
        String sql = BASE_GET_PRODUCT_WITH_IMAGE + " ORDER BY product_id DESC";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public long insertProduct(ProductDTO productDTO) {
        String sql = "INSERT INTO product (product_name, [description], price, category_id, brand_id, [status]) VALUES (?, ?, ?, ?, ?, ?)";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, productDTO.getProduct_name());
            ps.setString(2, productDTO.getDescription());
            ps.setDouble(3, productDTO.getPrice());
            ps.setLong(4, productDTO.getCategory_id());
            ps.setLong(5, productDTO.getBrand_id());
            ps.setBoolean(6, productDTO.isStatus());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                try ( ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getLong(1); // Trả về product_id vừa được tạo
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return -1; // Trả về -1 nếu có lỗi hoặc không tạo được
    }

    public List<ProductDTO> getAllProduct() {
        List<ProductDTO> listP = new ArrayList<>();
        String sql = BASE_GET_PRODUCT_WITH_IMAGE_For_Admin;

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getAllProductForUser() {
        List<ProductDTO> listP = new ArrayList<>();

        String sql = GET_PRODUCT + " where status = 1";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listP.add(productDTO);
            }
            return listP;

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getAllProductWithCategoryAndBrandName() {
        List<ProductDTO> list = new ArrayList<>();

        String sql = "SELECT p.product_id, p.product_name, p.description, p.price, p.status, p.category_id, p.brand_id, c.name AS category_name, b.name AS brand_name FROM Product p JOIN Categories c ON p.category_id = c.category_id JOIN Brand b ON p.brand_id = b.brand_id;";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductDTO dto = ProductMapper.toProductDTOFromRequestWithName(rs);

                list.add(dto);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    public void updateStatus(long productId, boolean status) {
        String sql = UPDATE_PRODUCT + "SET status = ? WHERE product_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            ps.setLong(2, productId);

            ps.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
            Optional:
            throw new RuntimeException("Error updating status", ex);
        }
    }

    public ProductDTO getProductById(long product_id) {
        String sql = BASE_GET_PRODUCT_WITH_IMAGE_For_Admin + "  product_id = ?";

//        String sql = GET_PRODUCT + " WHERE product_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, product_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductDTO product = ProductMapper.toProductDTOFromResultSet(rs);
                return product;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Boolean deleteProductByProductId(String StrProductId) {
        String sql = DELETE_PRODUCT + "WHERE product_id = ?";
        Long productId = Long.parseLong(StrProductId);
        deleteProductVariantByProductId(StrProductId);
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, productId);
            int success = ps.executeUpdate();
            if (success > 0) {
                return true;
            } else {
                return false;
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Boolean deleteProductVariantByProductId(String StrProductId) {
        String sql = "DELETE FROM ProductVariant"
                + " WHERE product_id = ?";
        Long productId = Long.parseLong(StrProductId);

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, productId);
            int success = ps.executeUpdate();
            if (success > 0) {
                return true;
            } else {
                return false;
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateProduct(ProductDTO product) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean result = false;

        try {
            conn = JDBCConnection.getConnection(); // Hàm get connection của bạn

            String sql = "UPDATE Product SET "
                    + "product_name = ?, "
                    + "description = ?, "
                    + "price = ?, "
                    + "category_id = ?, "
                    + "brand_id = ?, "
                    + "status = ? "
                    + "WHERE product_id = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProduct_name());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setLong(4, product.getCategory_id());
            ps.setLong(5, product.getBrand_id());
            ps.setBoolean(6, product.isStatus());
            ps.setLong(7, product.getProduct_id());

            int rows = ps.executeUpdate();
            result = rows > 0;

        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return result;
    }

    public List<TopProductDTO> getTopProducts() {
        List<TopProductDTO> listTopProduct = new ArrayList<>();
        String sql = "SELECT "
                + "    p.product_name, "
                + "    SUM(bi.quantity) AS total_sold "
                + "FROM BuyingItems bi "
                + "JOIN Product p ON bi.product_id = p.product_id "
                + "JOIN Buyings b ON bi.buying_id = b.buying_id "
                + "WHERE b.status = 'SUCCESS' "
                + "GROUP BY p.product_id, p.product_name "
                + "ORDER BY total_sold DESC "
                + "OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY ";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TopProductDTO topProductDTO = new TopProductDTO();

                topProductDTO.setProductName(rs.getString("product_name"));
                topProductDTO.setTotalSold(rs.getInt("total_sold"));

                listTopProduct.add(topProductDTO);

            }
            return listTopProduct;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<StockDTO> getStockList() {
        List<StockDTO> listStockDTOs = new ArrayList<>();

        String sql = "SELECT "
                + "    pv.product_variant_id, "
                + "    p.product_name, "
                + "    pv.size, "
                + "    pv.color, "
                + "    pv.quantity AS stock_quantity "
                + "FROM ProductVariant pv "
                + "JOIN Product p ON pv.product_id = p.product_id "
                + "ORDER BY stock_quantity ASC ";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StockDTO stockDTO = new StockDTO();

                stockDTO.setProductName(rs.getString("product_name"));
                stockDTO.setColor(rs.getString("color"));
                stockDTO.setSize(rs.getString("size"));
                stockDTO.setStockQuantity(rs.getInt("stock_quantity"));

                listStockDTOs.add(stockDTO);
            }
            return listStockDTOs;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> getProductsByBrandId(Long brand_id) {
        List<ProductDTO> listProduct = new ArrayList<>();
        String sql = BASE_GET_PRODUCT_WITH_IMAGE + " and brand_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, brand_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO productDTO = ProductMapper.toProductDTOFromResultSet(rs);
                listProduct.add(productDTO);
            }
            return listProduct;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ProductDTO> searchByName(String keyword) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT\n"
                + "    p.*,\n"
                + "    m.file_name AS main_img_url,\n"
                + "    c.category_id   AS category_id,\n"
                + "    c.name          AS category_name,\n"
                + "    b.brand_id      AS brand_id,\n"
                + "    b.name          AS brand_name\n"
                + "FROM Product p\n"
                + "LEFT JOIN image m\n"
                + "    ON m.target_id   = p.product_id\n"
                + "   AND m.target_type = 'PRODUCT_MAIN'\n"
                + "JOIN Categories c ON p.category_id = c.category_id\n"
                + "JOIN Brand      b ON p.brand_id     = b.brand_id\n"
                + "WHERE p.status = 1\n"
                + "  AND p.product_name LIKE ?";

        try {
            Connection conn = JDBCConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO product = ProductMapper.toProductDTOFromRequestWithName(rs);
                if (product != null) {
                    list.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> getProductsByCategoryAndBrand(Long categoryId, Long brandId) {

        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name, b.name AS brand_name "
                + "FROM Product p "
                + "JOIN Categories c ON p.category_id = c.category_id "
                + "JOIN Brand b ON p.brand_id = b.brand_id "
                + "WHERE p.category_id = ? AND p.brand_id = ?";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, categoryId);
            ps.setLong(2, brandId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO product = ProductMapper.toProductDTOFromRequestWithName(rs);
                if (product != null) {
                    list.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<CategoryDTO> getCategoriesByKeyword(String keyword) {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE name LIKE ?";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setCategory_id(rs.getLong("category_id"));
                category.setCategory_name(rs.getString("name"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();

        String keyword = "áo"; // Từ khóa để tìm kiếm

        List<CategoryDTO> categories = dao.getCategoriesByKeyword(keyword);

        for (CategoryDTO c : categories) {
            System.out.println("ID: " + c.getCategory_id() + ", Name: " + c.getCategory_name());
        }
    }

}
