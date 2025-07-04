/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package util;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author hieuh
 */
public class PasswordUtils {

    public static String hashPassword(String plainPassword) {

        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }


    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (hashedPassword == null || !hashedPassword.startsWith("$2a$")) {
            throw new IllegalArgumentException("Hash mật khẩu không hợp lệ");
        }
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}