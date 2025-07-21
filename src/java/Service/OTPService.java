/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import java.util.Random;

/**
 *
 * @author ASUS
 */
public class OTPService {

    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // 100000 - 999999
        return String.valueOf(otp);
    }
}
