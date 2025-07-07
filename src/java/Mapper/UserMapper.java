/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.UserDTO;
import Enums.Role;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class UserMapper {

    public static UserDTO toUserMapperFromResultSet(ResultSet rs) {
        try {
            UserDTO userDTO = new UserDTO();
            
            Long user_id = rs.getLong("user_id");
            String username = rs.getString("username");
            String fullName = rs.getString("fullName");
            String password = rs.getString("password");
            String email = rs.getString("email");
            Role role = Role.valueOf(rs.getString("role"));
            
            userDTO.setUser_id(user_id);
            userDTO.setUsername(username);
            userDTO.setFullName(fullName);
            userDTO.setPassword(password);
            userDTO.setEmail(email);
            userDTO.setRole(role);
            
            return userDTO;
        } catch (SQLException ex) {
            Logger.getLogger(UserMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
