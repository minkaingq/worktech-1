package com.groupware.worktech.board.model.exception;

public class BoardException extends RuntimeException {
	public BoardException() {}
	
	public BoardException(String msg) {
		super(msg);
	}
}
