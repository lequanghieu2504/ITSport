/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.JDBCConnection;

public class ChatDAO {
    public static void save(String sender, String receiver, String content) {
        String sql = "INSERT INTO chat_messages(sender, receiver, content) VALUES(?,?,?)";
        try (Connection c = JDBCConnection.getConnection();
             PreparedStatement p = c.prepareStatement(sql)) {

            p.setString(1, sender);
            p.setString(2, receiver);
            p.setString(3, content);
            p.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

