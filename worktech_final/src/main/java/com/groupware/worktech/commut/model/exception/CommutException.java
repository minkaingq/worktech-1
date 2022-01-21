package com.groupware.worktech.commut.model.exception;

public class CommutException extends RuntimeException {
	public CommutException() {}
	
	public CommutException(String msg) {
		super(msg);
	}
}
