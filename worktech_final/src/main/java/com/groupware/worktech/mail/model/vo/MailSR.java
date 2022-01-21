package com.groupware.worktech.mail.model.vo;

import java.sql.Timestamp;

public class MailSR {

	private int mailNo;
	private String mNo;
	private String sRStatus;
	private String favorites;
	private Timestamp rDate;

	public MailSR() {
	}

	public MailSR(int mailNo, String mNo, String sRStatus, String favorites, Timestamp rDate) {
		super();
		this.mailNo = mailNo;
		this.mNo = mNo;
		this.sRStatus = sRStatus;
		this.favorites = favorites;
		this.rDate = rDate;
	}

	public int getMailNo() {
		return mailNo;
	}

	public void setMailNo(int mailNo) {
		this.mailNo = mailNo;
	}

	public String getMNo() {
		return mNo;
	}

	public void setMNo(String mNo) {
		this.mNo = mNo;
	}

	public String getsRStatus() {
		return sRStatus;
	}

	public void setsRStatus(String sRStatus) {
		this.sRStatus = sRStatus;
	}

	public String getFavorites() {
		return favorites;
	}

	public void setFavorites(String favorites) {
		this.favorites = favorites;
	}

	public Timestamp getRDate() {
		return rDate;
	}

	public void setRDate(Timestamp rDate) {
		this.rDate = rDate;
	}

	@Override
	public String toString() {
		return "MailSR [mailNo=" + mailNo + ", mNo=" + mNo + ", sRStatus=" + sRStatus + ", favorites=" + favorites
				+ ", rDate=" + rDate + "]";
	}


}