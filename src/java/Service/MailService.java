/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.MailUtils;

/**
 *
 * @author ASUS
 */
public class MailService {

    private UserService userService = new UserService();

    public void mailService(String toEmail, String subject, String content) {
        try {
            MailUtils.sendEmail(toEmail, subject, content);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendMailToGetOTP(HttpServletRequest request, HttpServletResponse response) {
        try {
            String toEmail = request.getParameter("StrEmail");

            // Bước 1: Kiểm tra định dạng email
            if (toEmail == null || !isValidEmail(toEmail)) {
                System.out.println("Email không hợp lệ: " + toEmail);
                response.getWriter().write("Email không hợp lệ. Vui lòng nhập đúng định dạng.");
                request.getSession().setAttribute("message", "Email Khong Hop Le");
                return;
            }

            // Bước 2: Sinh OTP
            String OTP = OTPService.generateOTP();

            // Bước 3: Tạo nội dung email
            String subject = "Mã OTP xác thực";
            String content = "Xin chào!\nMã OTP của bạn là: " + OTP + "\nMã này có hiệu lực trong 5 phút.";

            // Bước 4: Gửi mail
//            MailUtils.sendEmail(toEmail, subject, content);
            System.out.println(OTP);
               // Bước 5: Lưu OTP vào session
            HttpSession session = request.getSession();
            session.setAttribute("otp", OTP);
            session.setAttribute("otp_email", toEmail);
            session.setMaxInactiveInterval(5 * 60); // 5 phút

            System.out.println("OTP sent and stored in session");
            response.getWriter().write("OTP đã được gửi đến email!");

            request.getRequestDispatcher("formOtp.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Hàm kiểm tra định dạng email hợp lệ (regex đơn giản)
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email.matches(emailRegex);
    }

    public boolean verifyOTP(HttpServletRequest request, HttpServletResponse response) {
        String inputOtp = request.getParameter("StrOTP");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("otp") == null) {
            System.out.println("OTP không tồn tại hoặc đã hết hạn");
            return false;
        }

        String storedOtp = (String) session.getAttribute("otp");

        if (storedOtp.equals(inputOtp)) {
            System.out.println("OTP chính xác");
            // Xoá OTP sau khi xác thực để tránh reuse
            session.removeAttribute("otp");
            return true;
        } else {
            System.out.println("OTP không đúng");
            return false;
        }
    }

    public void verifyOTPToLogin(HttpServletRequest request, HttpServletResponse response) {
        boolean verified = verifyOTP(request, response);
        if (verified) {
            try {
                System.out.println("dung otp");
                String email = (String) request.getSession().getAttribute("otp_email");
                userService.checkAndCreateUserByEmail(request, response, email);
            } catch (IOException ex) {
                Logger.getLogger(MailService.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                System.out.println("sai otp");
                request.getSession().setAttribute("message", "OTP không hợp lệ hoặc đã hết hạn!");
                response.sendRedirect("loginByEmail.jsp"); // Hoặc trang bạn muốn
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
