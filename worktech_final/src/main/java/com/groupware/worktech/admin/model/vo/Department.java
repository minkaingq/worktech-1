package com.groupware.worktech.admin.model.vo;

import java.sql.Date;

public class Department {
	
	private int dNo; // 부서번호
	private String dName; // 부서 명
	private int dParent; // 상위 부서 번호
	private Date dDate; // 등록 일자 
	private String dStatus; // 부서 상태
	
	public Department() {}

	public Department(int dNo, String dName, int dParent, Date dDate, String dStatus) {
		super();
		this.dNo = dNo;
		this.dName = dName;
		this.dParent = dParent;
		this.dDate = dDate;
		this.dStatus = dStatus;
	}

	public int getdNo() {
		return dNo;
	}

	public void setdNo(int dNo) {
		this.dNo = dNo;
	}

	public String getdName() {
		return dName;
	}

	public void setdName(String dName) {
		this.dName = dName;
	}

	public int getdParent() {
		return dParent;
	}

	public void setdParent(int dParent) {
		this.dParent = dParent;
	}

	public Date getdDate() {
		return dDate;
	}

	public void setdDate(Date dDate) {
		this.dDate = dDate;
	}

	public String getdStatus() {
		return dStatus;
	}

	public void setdStatus(String dStatus) {
		this.dStatus = dStatus;
	}

	@Override
	public String toString() {
		return "Department [dNo=" + dNo + ", dName=" + dName + ", dParent=" + dParent + ", dDate=" + dDate
				+ ", dStatus=" + dStatus + "]";
	}
	
}
