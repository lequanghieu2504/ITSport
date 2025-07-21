/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.ClientDTO;
import DTOs.UserDTO;
import Enums.Role;
import Mapper.UserMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author ASUS
 */
public class UserDAO {

    private String INSERT_USER = "INSERT INTO [User]";
    private String GET_USER = "SELECT * FROM [User]";

    public boolean insertUser(UserDTO newUserDTO) {
        String sql;
        boolean hasEmail = newUserDTO.getEmail() != null && !newUserDTO.getEmail().trim().isEmpty();

        if (hasEmail) {
            sql = INSERT_USER + " (username,[password],[role],email) VALUES (?,?,?,?)";
        } else {
            sql = INSERT_USER + " (username,[password],[role]) VALUES (?,?,?)";
        }

        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newUserDTO.getUsername());
            ps.setString(2, newUserDTO.getPassword());
            ps.setString(3, newUserDTO.getRole().name());

            if (hasEmail) {
                ps.setString(4, newUserDTO.getEmail());
            }

            int success = ps.executeUpdate();
            return success > 0;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public UserDTO getUserByUserName(String StrUserName) {
        String sql = GET_USER + " WHERE username like ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, StrUserName);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserDTO userDTO = new UserDTO();
                userDTO = UserMapper.toUserMapperFromResultSet(rs);
                return userDTO;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static int getUserIdByUsername(String username) {
        int user_id = -1;
        String sql = "SELECT user_id FROM [User] WHERE username = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user_id = rs.getInt("user_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user_id;
    }

    public static boolean isUsernameExists(String username) {
        String sql = "SELECT 1 FROM [User] WHERE username = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public UserDTO getUserDTOByUserId(long userId) {
        String sql = GET_USER + " where user_id = ?";
        UserDTO userDTO = new UserDTO();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userDTO = UserMapper.toUserMapperFromResultSet(rs);
            }
            return userDTO;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean exitsEmail(String email) {
        String sql = "SELECT COUNT(*) AS exits FROM [User] WHERE email = ? ";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);

            ResultSet checked = ps.executeQuery();
            if (checked.next()) {

                return checked.getInt("exits") > 0;

            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public UserDTO getUserByEmail(String email) {
        String sql = "select * from [User] where email like ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserDTO userDTO = UserMapper.toUserMapperFromResultSet(rs);
                return userDTO;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ClientDTO getClientByUserId(Long user_id) {
        String sql = "select * from [Client] where user_id = ?";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, user_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ClientDTO clientDTO = UserMapper.toClientDtoFromResultSet(rs);
                return clientDTO;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
