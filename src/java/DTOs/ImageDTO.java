    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

import Enums.ImageType;
import java.time.LocalDateTime;

/**
 *
 * @author ASUS
 */
public class ImageDTO {
    private Long image_id;
    private String file_name;
    private Long target_id;
    private ImageType targetType;
    private LocalDateTime uploaded_at;

    public ImageDTO(Long image_id, String file_name, Long target_id, ImageType targetType, LocalDateTime uploaded_at) {
        this.image_id = image_id;
        this.file_name = file_name;
        this.target_id = target_id;
        this.targetType = targetType;
        this.uploaded_at = uploaded_at;
    }

    public ImageDTO() {
    }

    public Long getImage_id() {
        return image_id;
    }

    public void setImage_id(Long image_id) {
        this.image_id = image_id;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public Long getTarget_id() {
        return target_id;
    }

    public void setTarget_id(Long target_id) {
        this.target_id = target_id;
    }

    public ImageType getTargetType() {
        return targetType;
    }

    public void setTargetType(ImageType targetType) {
        this.targetType = targetType;
    }

    public LocalDateTime getUploaded_at() {
        return uploaded_at;
    }

    public void setUploaded_at(LocalDateTime uploaded_at) {
        this.uploaded_at = uploaded_at;
    }
    
        
}
