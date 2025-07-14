/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.UserBuyingInfoDTO;
import Mapper.UserBuyingInforMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

public class UserBuyingInforDAO {

    private final String INSER_USER_BUYING_INFORMATION = "INSERT INTO BuyingUserInfor ";
    private final String GET_USER_BUYING_INFORMATION = "select * from [BuyingUserInfor] where 1 =1 ";
    private final String UPDATE_USER_BUYING_INFORMATION = "UPDATE BuyingUserInfor ";
    private final String DELETE_USER_BUYING_INFORMATION = "DELETE FROM BuyingUserInfor ";
    public boolean createUserBuyingInfo(UserBuyingInfoDTO userBuyingInfoDTO) {
        String sql = INSER_USER_BUYING_INFORMATION + " (user_id, recipient_name, province, district, ward, street, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
        boolean check = false;

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            // user_id có thể null
            if (userBuyingInfoDTO.getUserId() != -1) {
                ps.setLong(1, userBuyingInfoDTO.getUserId());
            } else {
                ps.setNull(1, java.sql.Types.BIGINT);
            }

            ps.setString(2, userBuyingInfoDTO.getRecipientName());
            ps.setString(3, userBuyingInfoDTO.getProvince());
            ps.setString(4, userBuyingInfoDTO.getDistrict());
            ps.setString(5, userBuyingInfoDTO.getWard());
            ps.setString(6, userBuyingInfoDTO.getStreet());
            ps.setString(7, userBuyingInfoDTO.getPhone());

            check = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            try {
                e.printStackTrace();
                throw e;
            } catch (SQLException ex) {
                Logger.getLogger(UserBuyingInforDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return check;
    }

    public List<UserBuyingInfoDTO> getUserBuyingInforByUserId(Long user_id) {
        String sql = GET_USER_BUYING_INFORMATION + "and user_id = ?";
        List<UserBuyingInfoDTO> userBuyingInfoDTOs = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, user_id);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserBuyingInfoDTO ubidto = UserBuyingInforMapper.toUserBuyingInforFromResultSet(rs);
                userBuyingInfoDTOs.add(ubidto);
            }
            return userBuyingInfoDTOs;
        } catch (SQLException ex) {
            Logger.getLogger(UserBuyingInforDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public UserBuyingInfoDTO getUserBuyingInforById(long userBuyingInfoId) {
        String sql = GET_USER_BUYING_INFORMATION + "and id = ?";
        UserBuyingInfoDTO userBuyingInfor = new UserBuyingInfoDTO();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userBuyingInfoId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userBuyingInfor = UserBuyingInforMapper.toUserBuyingInforFromResultSet(rs);
            }
            return userBuyingInfor;

        } catch (SQLException ex) {
            Logger.getLogger(UserBuyingInforDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean updateUserBuyingInfor(UserBuyingInfoDTO userBuyingInfoDTO) {
        String sql = UPDATE_USER_BUYING_INFORMATION + "set recipient_name = ?,"
                + "    province = ?,"
                + "    district = ?,"
                + "    ward = ?,"
                + "    street = ?,"
                + "    phone = ?,"
                + "    updated_at = GETDATE()" 
                + "WHERE id = ?";
        
        try(Connection conn = JDBCConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)){
            
         ps.setString(1, userBuyingInfoDTO.getRecipientName());
         ps.setString(2, userBuyingInfoDTO.getProvince());
         ps.setString(3, userBuyingInfoDTO.getDistrict());
         ps.setString(4, userBuyingInfoDTO.getWard());
         ps.setString(5, userBuyingInfoDTO.getStreet());
         ps.setString(6, userBuyingInfoDTO.getPhone());
         ps.setLong(7, userBuyingInfoDTO.getUserBuyingInforId());
         
         int success = ps.executeUpdate();
         
         if(success>0){
             return true;
         }
            
        } catch (SQLException ex) {
            Logger.getLogger(UserBuyingInforDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        
    }

    public boolean deleteUserInforById(long userInforId) {
    String sql = DELETE_USER_BUYING_INFORMATION + "where id = ?";
    
    try(Connection conn = JDBCConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)){
        
        ps.setLong(1, userInforId);
        
        int success = ps.executeUpdate();
        if(success>0){
            return true;
        }
        
    }   catch (SQLException ex) {
            Logger.getLogger(UserBuyingInforDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;    
    }
    
    
    

}
