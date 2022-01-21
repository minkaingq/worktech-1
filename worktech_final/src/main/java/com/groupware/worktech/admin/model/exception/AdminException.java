package com.groupware.worktech.admin.model.exception;

public class AdminException extends RuntimeException {
	public AdminException()	{}
	
	public AdminException(String msg) {
		super(msg);
	}
}
