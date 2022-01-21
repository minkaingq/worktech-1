package com.groupware.worktech.commut.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Commut {
	private int CommutNo;
	private Date commutDate;
	private Timestamp goWork;
	private Timestamp leaveWork;
	private String mNo;
	private int attendType;
	
	public Commut() {}
	
	public Commut(int commutNo, Date commutDate, Timestamp goWork, Timestamp leaveWork, String mNo, int attendType) {
		super();
		CommutNo = commutNo;
		this.commutDate = commutDate;
		this.goWork = goWork;
		this.leaveWork = leaveWork;
		this.mNo = mNo;
		this.attendType = attendType;
	}
	
	

	
	
	public Commut(int commutNo, Date commutDate, Timestamp goWork, String mNo) {
		super();
		CommutNo = commutNo;
		this.commutDate = commutDate;
		this.goWork = goWork;
		this.mNo = mNo;
	}





	public Commut(Timestamp leaveWork, String mNo) {
		super();
		this.leaveWork = leaveWork;
		this.mNo = mNo;
	}



	public int getCommutNo() {
		return CommutNo;
	}

	public void setCommutNo(int commutNo) {
		CommutNo = commutNo;
	}

	public Date getCommutDate() {
		return commutDate;
	}

	public void setCommutDate(Date commutDate) {
		this.commutDate = commutDate;
	}

	public Timestamp getGoWork() {
		return goWork;
	}

	public void setGoWork(Timestamp goWork) {
		this.goWork = goWork;
	}

	public Timestamp getLeaveWork() {
		return leaveWork;
	}

	public void setLeaveWork(Timestamp leaveWork) {
		this.leaveWork = leaveWork;
	}

	public String getmNo() {
		return mNo;
	}

	public void setmNo(String mNo) {
		this.mNo = mNo;
	}

	public int getAttendType() {
		return attendType;
	}

	public void setAttendType(int attendType) {
		this.attendType = attendType;
	}

	@Override
	public String toString() {
		return "Commut [CommutNo=" + CommutNo + ", commutDate=" + commutDate + ", goWork=" + goWork + ", leaveWork="
				+ leaveWork + ", mNo=" + mNo + ", attendType=" + attendType + "]";
	}
	
	
}
