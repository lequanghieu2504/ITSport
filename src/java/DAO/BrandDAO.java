/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.BrandDTO;
import Mapper.BrandMapper;
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
public class BrandDAO {

    private static final String GET_ALL_BRAND = "SELECT * FROM Brand";
    private static final String INSERT_BRAND = "INSERT INTO Brand";

    public List<BrandDTO> getAllBrand() {
        String sql = "	SELECT b.brand_id, b.name AS brand_name,i.file_name AS image_url,i.image_id AS image_id FROM Brand b LEFT JOIN image i ON b.brand_id = i.target_id AND i.target_type = 'BRAND'  ORDER BY b.brand_id";

        List<BrandDTO> listB = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BrandDTO brandDTO = BrandMapper.toBrandDTOFromResultSet(rs);
                listB.add(brandDTO);
            }
            return listB;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public long insertBrand(String brandName) {
        long newBrandId = -1; // Mặc định lỗi

        String sql = "INSERT INTO Brand (name) VALUES (?)";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, brandName);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try ( ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        newBrandId = rs.getLong(1); // Lấy brand_id mới
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return newBrandId;
    }

}
