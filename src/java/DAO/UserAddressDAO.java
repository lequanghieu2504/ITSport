/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.UserAddressDTO;
import util.JDBCConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserAddressDAO {

    // CREATE
    public boolean insertAddress(UserAddressDTO addressDTO) {
        String sql = "INSERT INTO UserAddress (user_id, address) VALUES (?, ?)";
        try (Connection conn = JDBCConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, addressDTO.getUserId());
            ps.setString(2, addressDTO.getAddress());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // READ
    public List<UserAddressDTO> getAddressesByUserId(int userId) {
        List<UserAddressDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM UserAddress WHERE user_id = ?";
        try (Connection conn = JDBCConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserAddressDTO dto = new UserAddressDTO();
                dto.setId(rs.getInt("id"));
                dto.setUserId(rs.getInt("user_id"));
                dto.setAddress(rs.getString("address"));
                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // UPDATE
    public boolean updateAddress(UserAddressDTO addressDTO) {
        String sql = "UPDATE UserAddress SET address = ? WHERE id = ?";
        try (Connection conn = JDBCConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, addressDTO.getAddress());
            ps.setInt(2, addressDTO.getId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // DELETE
    public boolean deleteAddress(int id) {
        String sql = "DELETE FROM UserAddress WHERE id = ?";
        try (Connection conn = JDBCConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

