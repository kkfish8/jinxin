package com.jingxin.Tools;


import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class SendEmail extends Thread{

	static private String _smtphost="smtp.163.com";
	static private String _protocol="smtp";
	static private String _isdebug="false";
	static private String _username="testxss123456";
	static private String _pass="test123456789";
	static private String _sender="testxss123456@163.com";
	static private String _isauth="true";
	
	private String smtphost;
	private String protocol;
	private String isdebug;
	private String username;
	private String pass;
	private String sender;
	private String isauth;
	
	private String title;
	private String emailContent;
	private String toWho;
	
	public SendEmail(String toWho,String emailContent,String title)
	{
		this.title = title;
		this.toWho = toWho;
		this.emailContent = emailContent;
		
		smtphost = _smtphost;
		protocol = _protocol;
		isdebug = _isdebug;
		username = _username;
		pass = _pass;
		sender = _sender;
		isauth = _isauth;
	}
	@Override
	public void run() {
		sendeActivemail(toWho,emailContent,title);
	}

	public  boolean sendeActivemail(String toWho,String emailContent,String title)
	{
		boolean state =true;
		
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol",protocol );
		props.setProperty("mail.host", smtphost);
		props.setProperty("mail.smtp.auth", isauth);
		props.setProperty("mail.debug",isdebug);
		Session session = Session.getDefaultInstance(props);
		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(sender));
			message.setRecipients(Message.RecipientType.TO, toWho);
			message.setSubject(title);
			message.setContent(emailContent,"text/html;charset=UTF-8");
			message.saveChanges();
			Transport ts = session.getTransport();
			ts.connect(username,pass);
			ts.sendMessage(message, message.getAllRecipients());
			
			ts.close();
		} catch (Exception e) {
			state = false;
		} 	
		return state;
	}
}
