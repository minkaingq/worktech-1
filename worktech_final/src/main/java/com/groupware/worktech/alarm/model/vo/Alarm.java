package com.groupware.worktech.alarm.model.vo;

import java.sql.Date;

public class Alarm {

	private int alarmNo;
	private int alarmType;
	private String alarmCheck;
	private String alarmSender;
	private String senderName;
	private String alarmReceiver;
	private Date alarmDate;
	private int bNo;
	private String bTitle;
	
	public Alarm() {}

	public Alarm(int alarmNo, int alarmType, String alarmCheck, String alarmSender, String senderName,
			String alarmReceiver, Date alarmDate, int bNo, String bTitle) {
		super();
		this.alarmNo = alarmNo;
		this.alarmType = alarmType;
		this.alarmCheck = alarmCheck;
		this.alarmSender = alarmSender;
		this.senderName = senderName;
		this.alarmReceiver = alarmReceiver;
		this.alarmDate = alarmDate;
		this.bNo = bNo;
		this.bTitle = bTitle;
	}

	public int getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(int alarmNo) {
		this.alarmNo = alarmNo;
	}

	public int getAlarmType() {
		return alarmType;
	}

	public void setAlarmType(int alarmType) {
		this.alarmType = alarmType;
	}

	public String getAlarmCheck() {
		return alarmCheck;
	}

	public void setAlarmCheck(String alarmCheck) {
		this.alarmCheck = alarmCheck;
	}

	public String getAlarmSender() {
		return alarmSender;
	}

	public void setAlarmSender(String alarmSender) {
		this.alarmSender = alarmSender;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getAlarmReceiver() {
		return alarmReceiver;
	}

	public void setAlarmReceiver(String alarmReceiver) {
		this.alarmReceiver = alarmReceiver;
	}

	public Date getAlarmDate() {
		return alarmDate;
	}

	public void setAlarmDate(Date alarmDate) {
		this.alarmDate = alarmDate;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	@Override
	public String toString() {
		return "Alarm [alarmNo=" + alarmNo + ", alarmType=" + alarmType + ", alarmCheck=" + alarmCheck
				+ ", alarmSender=" + alarmSender + ", senderName=" + senderName + ", alarmReceiver=" + alarmReceiver
				+ ", alarmDate=" + alarmDate + ", bNo=" + bNo + ", bTitle=" + bTitle + "]";
	}
	
}
