package com.groupware.worktech.calendar.vo;

import java.sql.Timestamp;

public class Calendar {
	private int calNo;
	private int calType;
	private Timestamp calStart;
	private Timestamp calEnd;
	private String calTitle;
	private String calContent;
	private String calWriter;
	private int calDelete;
	
	public Calendar() {}
	
	public Calendar(int calNo, int calType, Timestamp calStart, Timestamp calEnd, String calTitle, String calContent,
			String calWriter, int calDelete) {
		super();
		this.calNo = calNo;
		this.calType = calType;
		this.calStart = calStart;
		this.calEnd = calEnd;
		this.calTitle = calTitle;
		this.calContent = calContent;
		this.calWriter = calWriter;
		this.calDelete = calDelete;
	}

	public int getCalNo() {
		return calNo;
	}

	public void setCalNo(int calNo) {
		this.calNo = calNo;
	}

	public int getCalType() {
		return calType;
	}

	public void setCalType(int calType) {
		this.calType = calType;
	}

	public Timestamp getCalStart() {
		return calStart;
	}

	public void setCalStart(Timestamp calStart) {
		this.calStart = calStart;
	}

	public Timestamp getCalEnd() {
		return calEnd;
	}

	public void setCalEnd(Timestamp calEnd) {
		this.calEnd = calEnd;
	}

	public String getCalTitle() {
		return calTitle;
	}

	public void setCalTitle(String calTitle) {
		this.calTitle = calTitle;
	}

	public String getCalContent() {
		return calContent;
	}

	public void setCalContent(String calContent) {
		this.calContent = calContent;
	}

	public String getCalWriter() {
		return calWriter;
	}

	public void setCalWriter(String calWriter) {
		this.calWriter = calWriter;
	}

	public int getCalDelete() {
		return calDelete;
	}

	public void setCalDelete(int calDelete) {
		this.calDelete = calDelete;
	}

	@Override
	public String toString() {
		return "Calendar [calNo=" + calNo + ", calType=" + calType + ", calStart=" + calStart + ", calEnd=" + calEnd
				+ ", calTitle=" + calTitle + ", calContent=" + calContent + ", calWriter=" + calWriter + ", calDelete="
				+ calDelete + "]";
	}
	

}
