//package com.teachingassistant.util;
//
//import java.util.Properties;
//
//import javax.mail.Authenticator;
//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
//
//public class SendEmail {
//	public static void main(String[] args) {
//
//		String to = "";// change accordingly
//		String from = "";// change accordingly
//		String host = "localhost";// or IP address
//
//		// Get the session object
//		Properties properties = System.getProperties();
//		properties.setProperty("mail.smtp.host", "smtp.gmail.com");
//		properties.setProperty("mail.smtp.port", "587");
//		properties.setProperty("mail.smtp.starttls.enable", "true");
////		properties.setProperty("mail.smtp.ssl.enable", "true");
//		properties.setProperty("mail.smtp.auth", "true");
//		Session session = Session.getDefaultInstance(properties,new Authenticator() {
//			
//			@Override
//			protected PasswordAuthentication getPasswordAuthentication() {
//				return new PasswordAuthentication("testnoreply39@gmail.com", "noreply12345");	
//			}
//		});
//
//		// compose the message
//		try {
//			MimeMessage message = new MimeMessage(session);
//			message.setFrom(new InternetAddress(from));
//			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//			message.setSubject("Ping");
//			message.setText("Hello, this is example of sending email  ");
//
//			// Send message
//			Transport.send(message);
//			System.out.println("message sent successfully....");
//
//		} catch (MessagingException mex) {
//			mex.printStackTrace();
//		}
//	}
//
//}
