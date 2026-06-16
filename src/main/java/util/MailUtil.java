package util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailUtil {
    public static void send(String to, String subject, String content) throws Exception {
        String host = System.getenv().getOrDefault("MOMONET_MAIL_HOST", "smtp.gmail.com");
        String user = System.getenv().getOrDefault("MOMONET_MAIL_USER", "YOUR_EMAIL@gmail.com");
        String password = System.getenv().getOrDefault("MOMONET_MAIL_PASSWORD", "YOUR_APP_PASSWORD");

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(user, "MOMONet"));
        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setContent(content, "text/html; charset=utf-8");

        try {
            Transport.send(msg);
            System.out.println("메일 전송 성공!");
        } catch (Exception e) {
            System.out.println("메일 전송 실패!");
            e.printStackTrace();
            throw e;
        }
    }
}
