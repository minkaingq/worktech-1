package com.groupware.worktech.chat.model.exception;

public class ChatException extends RuntimeException {
	public ChatException() {}
	
	public ChatException(String msg) {
		super(msg);
	}
}
