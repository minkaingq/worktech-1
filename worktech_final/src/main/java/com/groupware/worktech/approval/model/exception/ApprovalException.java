package com.groupware.worktech.approval.model.exception;

public class ApprovalException extends RuntimeException{
	public ApprovalException() {}
	
	public ApprovalException(String msg) {
		super(msg);	
	}
}
