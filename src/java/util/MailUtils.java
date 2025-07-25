package util;

import jakarta.mail.Authenticator;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

/**
 * Utility class for sending emails via Gmail SMTP.
 */
public class MailUtils {
    public static final String FROM_EMAIL = "itsportfpt@gmail.com";
    // App password generated in Google Account
    private static final String APP_PASSWORD = "cybraqxkcxkxkpvv";
    private static Session mailSession;

    /**
     * Lazy-init và trả về Session đã cấu hình Gmail SMTP.
     */
    public static Session getMailSession() {
        if (mailSession == null) {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            };

            mailSession = Session.getInstance(props, auth);
            mailSession.setDebug(true); // bật debug log SMTP
        }
        return mailSession;
    }

    /**
     * Kiểm tra định dạng email đơn giản.
     */
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email.trim().matches(regex);
    }

    /**
     * Gửi email nội dung HTML hoặc plain-text tùy contentType.
     * @param toEmail  Địa chỉ nhận
     * @param subject  Tiêu đề
     * @param content  Nội dung
     * @param isHtml   true để gửi HTML, false plain-text
     */
    public static void sendEmail(String toEmail, String subject, String content, boolean isHtml)
            throws MessagingException, UnsupportedEncodingException {
        Session session = getMailSession();
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(FROM_EMAIL, "ITSport FPT"));
        msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(toEmail.trim()));
        msg.setSubject(subject, "UTF-8");
        if (isHtml) {
            msg.setContent(content, "text/html; charset=UTF-8");
        } else {
            msg.setText(content, "UTF-8");
        }
        Transport.send(msg);
    }

    private MailUtils() {
        // không khởi tạo instance
    }
}
