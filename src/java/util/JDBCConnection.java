/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class JDBCConnection {

    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=ITSPORTV1.2;encrypt=true;trustServerCertificate=true"; // đổi tên DB cho bạn
    private static final String JDBC_USERNAME = "sa";
    private static final String JDBC_PASSWORD = "12345";  // mật khẩu DB của bạn

    static {
        try {
            // Load Driver (nếu MySQL 8 trở lên có thể bỏ dòng này)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }

    public static void main(String[] args) {
        try {
            Connection conn = JDBCConnection.getConnection();
            if (conn != null) {
                System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
            } else {
                System.out.println("Kết nối thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
