package Service;

import DTOs.TotalBuyingDTO;
import DTOs.ItemDTO;
import DTOs.UserDTO;
import Enums.PaymentMethod;
import Enums.Status;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.MailUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service xử lý gửi email OTP và xác nhận đơn hàng.
 */
public class MailService {

    private static final Logger LOGGER = Logger.getLogger(MailService.class.getName());

    /**
     * Gửi email plain-text (OTP, thông báo đơn hàng).
     */
    public void sendPlainEmail(String toEmail, String subject, String content) {
        if (!MailUtils.isValidEmail(toEmail)) {
            LOGGER.warning("Email không hợp lệ: " + toEmail);
            return;
        }
        try {
            MailUtils.sendEmail(toEmail, subject, content, false);
        } catch (MessagingException | UnsupportedEncodingException ex) {
            LOGGER.log(Level.WARNING, "Gửi plain email thất bại đến " + toEmail, ex);
        }
    }

    /**
     * Gửi email HTML (xác nhận đơn hàng).
     */
    public void sendHtmlEmail(String toEmail, String subject, String htmlContent) {
        if (!MailUtils.isValidEmail(toEmail)) {
            LOGGER.warning("Email không hợp lệ: " + toEmail);
            return;
        }
        try {
            Session session = MailUtils.getMailSession();
            session.setDebug(false);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(MailUtils.FROM_EMAIL, "ITSport FPT"));
            msg.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(toEmail.trim()));
            msg.setSubject(subject, "UTF-8");
            msg.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException | UnsupportedEncodingException ex) {
            LOGGER.log(Level.WARNING, "Gửi HTML email thất bại đến " + toEmail, ex);
        }
    }

    /**
     * Gửi OTP xác thực đến email.
     */
    public void sendOtp(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String toEmail = req.getParameter("StrEmail");
        HttpSession session = req.getSession();
        if (toEmail == null || !MailUtils.isValidEmail(toEmail)) {
            session.setAttribute("message", "Email không hợp lệ");
            resp.getWriter().write("Email không hợp lệ. Vui lòng thử lại.");
            return;
        }
        String otp = OTPService.generateOTP();
        sendPlainEmail(toEmail, "Mã OTP xác thực", "Mã OTP của bạn: " + otp + " (hết hạn trong 5 phút)");
        session.setAttribute("otp", otp);
        session.setAttribute("otp_email", toEmail);
        session.setMaxInactiveInterval(5 * 60);
    }

    /**
     * Xác thực OTP.
     */
    public boolean verifyOtp(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return false;
        }
        String stored = (String) session.getAttribute("otp");
        String input = req.getParameter("StrOTP");
        if (stored != null && stored.equals(input)) {
            session.removeAttribute("otp");
            return true;
        }
        return false;
    }

    /**
     * Gửi email xác nhận đơn hàng.
     */
    public void sendOrderConfirmation(UserDTO user, TotalBuyingDTO dto) {
        String toEmail = user.getEmail();
        if (!MailUtils.isValidEmail(toEmail)) {
            LOGGER.warning("Email không hợp lệ: " + toEmail);
            return;
        }
        String subject = "Xác nhận đơn hàng #" + dto.getBuyingId();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        StringBuilder html = new StringBuilder();
        html.append("<html><body>")
                .append("<h2>ITSport - Xác nhận đơn hàng</h2>")
                .append("<p>Chào ").append(user.getUsername()).append(",</p>")
                .append("<p>Đơn hàng #").append(dto.getBuyingId()).append(" đã được nhận vào ")
                .append(dto.getCreatedAt().format(fmt)).append(".</p>")
                .append("<h3>Thông tin giao hàng</h3>")
                .append("<p>")
                .append(dto.getShippingName()).append(" (" + dto.getShippingPhone() + ")<br>")
                .append(dto.getShippingStreet()).append(", ")
                .append(dto.getShippingWard()).append(", ")
                .append(dto.getShippingDistrict()).append(", ")
                .append(dto.getShippingProvince()).append("</p>")
                .append("<h3>Chi tiết sản phẩm</h3>")
                .append("<table border='1' cellpadding='5'><tr><th>Tên</th><th>SL</th><th>Giá</th><th>Thành tiền</th></tr>");
        for (ItemDTO it : dto.getItems()) {
            html.append("<tr>")
                    .append("<td>").append(it.getProductName()).append("</td>")
                    .append("<td align='center'>").append(it.getQuantity()).append("</td>")
                    .append("<td align='right'>").append(nf.format(it.getPriceEach())).append("</td>")
                    .append("<td align='right'>").append(nf.format(it.getPriceEach() * it.getQuantity())).append("</td>")
                    .append("</tr>");
        }
        html.append("<tr><td colspan='3' align='right'><strong>Tổng</strong></td><td align='right'>")
                .append(nf.format(dto.getTotalPrice())).append("</td></tr>")
                .append("</table>")
                .append("<p>Cảm ơn bạn đã mua hàng!</p>")
                .append("</body></html>");

        sendHtmlEmail(toEmail, subject, html.toString());
    }

    /**
     * Xác thực OTP để đổi mật khẩu.
     */
    public void verifyOTPToForgotPassword(HttpServletRequest req, HttpServletResponse resp) {
        try {
            if (verifyOTP(req)) {
                resp.sendRedirect("updatePasswordForm.jsp");
            } else {
                req.getSession().setAttribute("message", "OTP không hợp lệ");
                resp.sendRedirect("forgotPassword.jsp");
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, null, e);
        }
    }

    public void sendMailToGetOTPToForgotPassword(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String toEmail = req.getParameter("StrEmail");
            if (toEmail == null || !MailUtils.isValidEmail(toEmail)) {
                req.getSession().setAttribute("message", "Email không hợp lệ");
                resp.getWriter().write("Email không hợp lệ");
                return;
            }
            String otp = OTPService.generateOTP();
            sendPlainEmail(toEmail, "Mã OTP xác thực", "Mã OTP của bạn: " + otp + " (5 phút)");
            HttpSession session = req.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otp_email", toEmail);
            session.setMaxInactiveInterval(5 * 60);
            req.getRequestDispatcher("formOtpToForgotPassword.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending OTP for forgot password", e);
        }
    }

    public void verifyOTPToLogin(HttpServletRequest req, HttpServletResponse resp) {
        try {
            if (verifyOTP(req)) {
                String email = (String) req.getSession().getAttribute("otp_email");
                new UserService().checkAndCreateUserByEmail(req, resp, email);
            } else {
                req.getSession().setAttribute("message", "OTP không hợp lệ");
                resp.sendRedirect("loginByEmail.jsp");
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, null, e);
        }
    }

    public void sendMailToGetOTP(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String toEmail = req.getParameter("StrEmail");
            if (toEmail == null || !MailUtils.isValidEmail(toEmail)) {
                req.getSession().setAttribute("message", "Email không hợp lệ");
                resp.getWriter().write("Email không hợp lệ");
                return;
            }
            String otp = OTPService.generateOTP();
            sendPlainEmail(toEmail, "Mã OTP xác thực", "Mã OTP của bạn: " + otp + " (5 phút)");
            HttpSession session = req.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otp_email", toEmail);
            session.setMaxInactiveInterval(5 * 60);
            req.getRequestDispatcher("formOtpToLogin.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending OTP", e);
        }
    }

       

    public boolean verifyOTP(HttpServletRequest request) {
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

}
