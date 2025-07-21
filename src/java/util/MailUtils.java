package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailUtils {

    public static void sendEmail(String toEmail, String subject, String content) throws MessagingException {
        final String fromEmail = "itsportfpt@gmail.com"; // Tài khoản Gmail
        final String password = "cybr aqxk cxkx kpvv";    // App Password của Gmail

        // Config SMTP server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail SMTP
        props.put("mail.smtp.port", "587");            // TLS port
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo Session
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // Soạn Message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
                Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setText(content);
        message.setContent(content, "text/html; charset=UTF-8");

        // Gửi
        Transport.send(message);
    }
}
