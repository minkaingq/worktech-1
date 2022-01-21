package com.groupware.worktech.board.model.vo;

import java.sql.Date;

public class Reply {

	private int rNo;
	private String rContent;
	private Date rDate;
	private int bNo;
	private String rName; // 댓글 작성자 사번
	private String name; // 댓글 작성자 이름
	private String rStatus;
	
	public Reply() {}

	public Reply(int rNo, String rContent, Date rDate, int bNo, String rName, String name, String rStatus) {
		super();
		this.rNo = rNo;
		this.rContent = rContent;
		this.rDate = rDate;
		this.bNo = bNo;
		this.rName = rName;
		this.name = name;
		this.rStatus = rStatus;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public Date getrDate() {
		return rDate;
	}

	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getrName() {
		return rName;
	}

	public void setrName(String rName) {
		this.rName = rName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}

	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", rContent=" + rContent + ", rDate=" + rDate + ", bNo=" + bNo + ", rName=" + rName
				+ ", name=" + name + ", rStatus=" + rStatus + "]";
	}
	
}
