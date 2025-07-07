/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.UserDTO;
import Mapper.UserMapper;
import jakarta.servlet.jsp.jstl.sql.Result;
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
        String sql = INSERT_USER + " (username,fullName,[password],[role]) VALUES (?,?,?,?)";
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newUserDTO.getUsername());
            ps.setString(2, newUserDTO.getFullName());
            ps.setString(3, newUserDTO.getPassword());
            ps.setString(4, newUserDTO.getRole().toString().toUpperCase());

            int success = ps.executeUpdate();

            if (success > 0) {
                return true;
            } else {
                return false;
            }
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
}
