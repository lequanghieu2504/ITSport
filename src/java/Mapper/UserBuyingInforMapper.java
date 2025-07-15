/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.UserBuyingInfoDTO;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class UserBuyingInforMapper {

    public static UserBuyingInfoDTO toUserBuyingInfoDTOFromRequest(HttpServletRequest request) {
        String recipientName = request.getParameter("recipientName");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String street = request.getParameter("street");
        String phone = request.getParameter("phone");
        String userBuyingInforIdStr = request.getParameter("userBuyingInforId"); // For update operations

        // Trim để loại bỏ khoảng trắng dư
        if (recipientName != null) {
            recipientName = recipientName.trim();
        }
        if (province != null) {
            province = province.trim();
        }
        if (district != null) {
            district = district.trim();
        }
        if (ward != null) {
            ward = ward.trim();
        }
        if (street != null) {
            street = street.trim();
        }
        if (phone != null) {
            phone = phone.trim();
        }
        System.out.println("recipientName: " + recipientName);
        System.out.println("province: " + province);
        System.out.println("district: " + district);
        System.out.println("ward: " + ward);
        System.out.println("street: " + street);
        System.out.println("phone: " + phone);

        // Validate required fields
        if (recipientName == null || recipientName.isEmpty()
                || province == null || province.isEmpty()
                || district == null || district.isEmpty()
                || ward == null || ward.isEmpty()
                || street == null || street.isEmpty()
                || phone == null || phone.isEmpty()) {
            throw new IllegalArgumentException("Missing required buying info fields");
        }

        // Create DTO
        UserBuyingInfoDTO dto = new UserBuyingInfoDTO(recipientName, province, district, ward, street, phone);

        // Set ID if it's an update operation
        if (userBuyingInforIdStr != null && !userBuyingInforIdStr.trim().isEmpty()) {
            try {
                long userBuyingInforId = Long.parseLong(userBuyingInforIdStr.trim());
                dto.setUserBuyingInforId(userBuyingInforId); // Assuming you have a setter for ID
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid userBuyingInforId format: " + userBuyingInforIdStr);
            }
        }

        return dto;
    }

    public static UserBuyingInfoDTO toUserBuyingInforFromResultSet(ResultSet rs) {
        UserBuyingInfoDTO userBuyingInfoDTO = null;
        try {
            long userBuyingInfoId = rs.getLong("id");
            long userId = rs.getLong("user_id");
            String recipientName = rs.getString("recipient_name");
            String province = rs.getString("province");
            String district = rs.getString("district");
            String ward = rs.getString("ward");
            String street = rs.getString("street");
            String phone = rs.getString("phone");

            userBuyingInfoDTO = new UserBuyingInfoDTO(
                    userId,
                    recipientName,
                    province,
                    district,
                    ward,
                    street,
                    phone
            );
            userBuyingInfoDTO.setUserBuyingInforId(userBuyingInfoId);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBuyingInfoDTO;
    }

}
