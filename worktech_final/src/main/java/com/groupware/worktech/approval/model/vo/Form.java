package com.groupware.worktech.approval.model.vo;

public class Form {
	private int formNo;
	private String formURL;
	private String formName; 
	private String formRname; 
	private int appNo;
	
	public Form() {}

	public Form(int formNo, String formURL, String formName, String formRname, int appNo) {
		super();
		this.formNo = formNo;
		this.formURL = formURL;
		this.formName = formName;
		this.formRname = formRname;
		this.appNo = appNo;
	}

	public int getFormNo() {
		return formNo;
	}

	public void setFormNo(int formNo) {
		this.formNo = formNo;
	}

	public String getFormURL() {
		return formURL;
	}

	public void setFormURL(String formURL) {
		this.formURL = formURL;
	}

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	public String getFormRname() {
		return formRname;
	}

	public void setFormRname(String formRname) {
		this.formRname = formRname;
	}

	public int getAppNo() {
		return appNo;
	}

	public void setAppNo(int appNo) {
		this.appNo = appNo;
	}

	@Override
	public String toString() {
		return "Form [formNo=" + formNo + ", formURL=" + formURL + ", formName=" + formName + ", formRname=" + formRname
				+ ", appNo=" + appNo + "]";
	}
	

}
