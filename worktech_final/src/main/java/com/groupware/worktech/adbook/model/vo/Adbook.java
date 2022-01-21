package com.groupware.worktech.adbook.model.vo;

import java.sql.Date;

public class Adbook {

	private int adNo;
	private String adName;
	private String adCompany;
	private String adPhone;
	private String adEmail;
	private String adDept;
	private String adJob;
	private String adWriter; // 주소록 작성자(사번)
	private String adStatus;
	
	public Adbook() {}

	public Adbook(int adNo, String adName, String adCompany, String adPhone, String adEmail, String adDept,
			String adJob, String adWriter, String adStatus) {
		super();
		this.adNo = adNo;
		this.adName = adName;
		this.adCompany = adCompany;
		this.adPhone = adPhone;
		this.adEmail = adEmail;
		this.adDept = adDept;
		this.adJob = adJob;
		this.adWriter = adWriter;
		this.adStatus = adStatus;
	}

	public int getAdNo() {
		return adNo;
	}

	public void setAdNo(int adNo) {
		this.adNo = adNo;
	}

	public String getAdName() {
		return adName;
	}

	public void setAdName(String adName) {
		this.adName = adName;
	}

	public String getAdCompany() {
		return adCompany;
	}

	public void setAdCompany(String adCompany) {
		this.adCompany = adCompany;
	}

	public String getAdPhone() {
		return adPhone;
	}

	public void setAdPhone(String adPhone) {
		this.adPhone = adPhone;
	}

	public String getAdEmail() {
		return adEmail;
	}

	public void setAdEmail(String adEmail) {
		this.adEmail = adEmail;
	}

	public String getAdDept() {
		return adDept;
	}

	public void setAdDept(String adDept) {
		this.adDept = adDept;
	}

	public String getAdJob() {
		return adJob;
	}

	public void setAdJob(String adJob) {
		this.adJob = adJob;
	}

	public String getAdWriter() {
		return adWriter;
	}

	public void setAdWriter(String adWriter) {
		this.adWriter = adWriter;
	}

	public String getAdStatus() {
		return adStatus;
	}

	public void setAdStatus(String adStatus) {
		this.adStatus = adStatus;
	}

	@Override
	public String toString() {
		return "Adbook [adNo=" + adNo + ", adName=" + adName + ", adCompany=" + adCompany + ", adPhone=" + adPhone
				+ ", adEmail=" + adEmail + ", adDept=" + adDept + ", adJob=" + adJob + ", adWriter=" + adWriter
				+ ", adStatus=" + adStatus + "]";
	}
	
}
