/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mapper;

import DTOs.ClientDTO;
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
            String password = rs.getString("password");
            Role role = Role.valueOf(rs.getString("role"));

            userDTO.setUser_id(user_id);
            userDTO.setUsername(username);
            userDTO.setPassword(password);
            userDTO.setRole(role);

            return userDTO;
        } catch (SQLException ex) {
            Logger.getLogger(UserMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static ClientDTO toClientDtoFromResultSet(ResultSet rs) throws SQLException {
        ClientDTO clientDTO = new ClientDTO();
        clientDTO.setClient_id(rs.getInt("client_id"));  // client_id trong bảng
        clientDTO.setUser_id(rs.getLong("user_id"));      // user_id tham chiếu User
        clientDTO.setCart_id(rs.getInt("cart_id"));
        clientDTO.setFull_name(rs.getString("full_name"));
        clientDTO.setPhone_number(rs.getString("phone_number"));
        clientDTO.setAddress(rs.getString("address"));
        clientDTO.setFull_name(rs.getString("full_name"));
        return clientDTO;
    }

}
