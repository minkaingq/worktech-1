package com.groupware.worktech.mail.model.exception;

public class MailException extends RuntimeException{
	public MailException () {}
	public MailException(String msg) {
		super(msg);
	}
}
