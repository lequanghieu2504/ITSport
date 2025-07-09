/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.ImageDTO;
import Enums.ImageType;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class ImageMapper {

    public static ImageDTO toImageDTOFromResultSet(ResultSet rs) {
        ImageDTO imageDTO = new ImageDTO();
        try {
            imageDTO.setImage_id(rs.getLong("image_id"));
            imageDTO.setFile_name(rs.getString("file_name"));
            imageDTO.setTarget_id(rs.getLong("target_id"));
            imageDTO.setTargetType(ImageType.valueOf(rs.getString("target_type"))); // hoặc dùng Enum nếu bạn có enum ImageType
            imageDTO.setUploaded_at(rs.getTimestamp("uploaded_at").toLocalDateTime()); // hoặc getDate nếu bạn dùng java.sql.Date
        } catch (SQLException e) {
            e.printStackTrace(); // hoặc log lỗi bằng Logger
        }
        return imageDTO;
    }

}
