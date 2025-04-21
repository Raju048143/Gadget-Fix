package com.gadget.model;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class SendMail {
	public static void sendMail(String rEmail, String sub, String body) {
		String sEmail = "gadgetfixinf0@gmail.com";
		String sPassword = "hdlngasanzfgxrkk";

		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");

			Session ses = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(sEmail, sPassword);
				}
			});

			Message message = new MimeMessage(ses);
			message.setFrom(new InternetAddress(sEmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(rEmail));
			message.setSubject(sub);
			message.setContent(body, "text/html");

			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
