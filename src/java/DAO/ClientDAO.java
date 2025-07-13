package DAO;

import DTOs.ClientDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.JDBCConnection;

public class ClientDAO {

    private static final String GET_BY_USER_ID
            = "SELECT * FROM Client WHERE user_id = ?";

    private static final String INSERT_CLIENT
            = "INSERT INTO Client (user_id, cart_id, full_name, phone_number, address) VALUES (?, ?, ?, ?, ?)";

    // Lấy client theo user_id
    public static ClientDTO getClientByUserId(long userId) {
        ClientDTO client = null;
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(GET_BY_USER_ID)) {

            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                client = new ClientDTO();
                client.setClient_id(rs.getInt("client_id"));
                client.setUser_id(rs.getInt("user_id"));
                client.setCart_id(rs.getInt("cart_id"));
                client.setFull_name(rs.getString("full_name"));
                client.setPhone_number(rs.getString("phone_number"));
                client.setAddress(rs.getString("address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return client;
    }

    public static boolean insertClient(ClientDTO client) {
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(INSERT_CLIENT)) {

            ps.setInt(1, client.getUser_id());
            ps.setInt(2, client.getCart_id());
            ps.setString(3, client.getFull_name());
            ps.setString(4, client.getPhone_number());
            ps.setString(5, client.getAddress());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
