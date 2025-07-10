/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.ImageDTO;
import Enums.ImageType;
import Mapper.ImageMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author ASUS
 */
public class ImageDAO {

    private final String INSERT_IMAGE = "INSERT INTO image ";
    private final String DELETE_IMAGE = "DELETE FROM image ";
    private final String GET_IMAGE = "SELECT * FROM image ";

    public boolean insertImage(ImageDTO img) {
        String sql = INSERT_IMAGE + "(file_name,target_id,target_type) values (?,?,?)";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, img.getFile_name());
            ps.setLong(2, img.getTarget_id());
            ps.setString(3, img.getTargetType().toString());

            int rs = ps.executeUpdate();

            if (rs > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Lấy tất cả ảnh theo target_id và loại ảnh
    public List<ImageDTO> getImagesByTarget(Long targetId, ImageType imageType) {
        List<ImageDTO> list = new ArrayList<>();
        String sql = "SELECT image_id, file_name, target_id, target_type FROM image WHERE target_id = ? AND target_type = ?";

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, targetId);
            ps.setString(2, imageType.toString());

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ImageDTO img = new ImageDTO();
                    img.setImage_id(rs.getLong("image_id"));
                    img.setFile_name(rs.getString("file_name"));
                    img.setTarget_id(rs.getLong("target_id"));
                    img.setTargetType(ImageType.valueOf(rs.getString("target_type")));
                    list.add(img);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ImageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public boolean deleteImageById(Long imageId) {
        String sql =DELETE_IMAGE+ " where image_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, imageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getMainImageFileNameByProductId(Long product_id) {
        String sql = GET_IMAGE;
        String fileName = null;

        try ( Connection con = JDBCConnection.getConnection();  PreparedStatement ps = con.prepareStatement(GET_IMAGE)) {

            ps.setLong(1, product_id);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    fileName = rs.getString("file_name");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return fileName;
    }

    public void deleteMainImageByProductIdAndTargetType(Long product_id, ImageType imageType) {
        String sql = DELETE_IMAGE + " where target_id = ? and target_type = ?";

        try ( Connection con = JDBCConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, product_id);
            ps.setString(2, imageType.toString()); // Hoặc imageType.name()

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ImageDTO getImageById(Long imageId) {
        String sql = GET_IMAGE + "where image_id = ?";
        try(Connection conn = JDBCConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){
            
            ps.setLong(1, imageId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ImageDTO imageDTO = ImageMapper.toImageDTOFromResultSet(rs);
                return imageDTO;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ImageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<ImageDTO> getByVariantId(Long product_variant_id) {
        String sql = GET_IMAGE + " where target_id = ? and target_type like 'PRODUCT_VARIANT'";
        List<ImageDTO> listImage = new ArrayList<>();
        try(Connection conn =JDBCConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setLong(1, product_variant_id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ImageDTO imageDTO = ImageMapper.toImageDTOFromResultSet(rs);
                listImage.add(imageDTO);
            }
            return listImage;
            
        } catch (SQLException ex) {
            Logger.getLogger(ImageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }



}
