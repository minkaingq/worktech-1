package com.groupware.worktech.approval.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import com.groupware.worktech.board.model.vo.BoardFile;

public class Approval {
	private int appNo;
	private String appTitle;
	private String appContent;
	private String appWriter;
	private String mName;	// 기획자명
	private String dName;	// 부서명
	private String jobGrade;	// 직급명
	private int appResult;
	private String appDelete;
	private Date appDate;
	private String appLiMember;
	private String appLiMemberName;
	private String appRefMember;
	private String appRefMemberName;
	private ArrayList<Form> fileList;
	
	public Approval() {}

	public Approval(int appNo, String appTitle, String appContent, String appWriter, String mName, String dName,
			String jobGrade, int appResult, String appDelete, Date appDate, String appLiMember, String appLiMemberName,
			String appRefMember, String appRefMemberName, ArrayList<Form> fileList) {
		super();
		this.appNo = appNo;
		this.appTitle = appTitle;
		this.appContent = appContent;
		this.appWriter = appWriter;
		this.mName = mName;
		this.dName = dName;
		this.jobGrade = jobGrade;
		this.appResult = appResult;
		this.appDelete = appDelete;
		this.appDate = appDate;
		this.appLiMember = appLiMember;
		this.appLiMemberName = appLiMemberName;
		this.appRefMember = appRefMember;
		this.appRefMemberName = appRefMemberName;
		this.fileList = fileList;
	}

	public int getAppNo() {
		return appNo;
	}

	public void setAppNo(int appNo) {
		this.appNo = appNo;
	}

	public String getAppTitle() {
		return appTitle;
	}

	public void setAppTitle(String appTitle) {
		this.appTitle = appTitle;
	}

	public String getAppContent() {
		return appContent;
	}

	public void setAppContent(String appContent) {
		this.appContent = appContent;
	}

	public String getAppWriter() {
		return appWriter;
	}

	public void setAppWriter(String appWriter) {
		this.appWriter = appWriter;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getdName() {
		return dName;
	}

	public void setdName(String dName) {
		this.dName = dName;
	}

	public String getJobGrade() {
		return jobGrade;
	}

	public void setJobGrade(String jobGrade) {
		this.jobGrade = jobGrade;
	}

	public int getAppResult() {
		return appResult;
	}

	public void setAppResult(int appResult) {
		this.appResult = appResult;
	}

	public String getAppDelete() {
		return appDelete;
	}

	public void setAppDelete(String appDelete) {
		this.appDelete = appDelete;
	}

	public Date getAppDate() {
		return appDate;
	}

	public void setAppDate(Date appDate) {
		this.appDate = appDate;
	}

	public String getAppLiMember() {
		return appLiMember;
	}

	public void setAppLiMember(String appLiMember) {
		this.appLiMember = appLiMember;
	}

	public String getAppLiMemberName() {
		return appLiMemberName;
	}

	public void setAppLiMemberName(String appLiMemberName) {
		this.appLiMemberName = appLiMemberName;
	}

	public String getAppRefMember() {
		return appRefMember;
	}

	public void setAppRefMember(String appRefMember) {
		this.appRefMember = appRefMember;
	}

	public String getAppRefMemberName() {
		return appRefMemberName;
	}

	public void setAppRefMemberName(String appRefMemberName) {
		this.appRefMemberName = appRefMemberName;
	}

	public ArrayList<Form> getFileList() {
		return fileList;
	}

	public void setFileList(ArrayList<Form> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "Approval [appNo=" + appNo + ", appTitle=" + appTitle + ", appContent=" + appContent + ", appWriter="
				+ appWriter + ", mName=" + mName + ", dName=" + dName + ", jobGrade=" + jobGrade + ", appResult="
				+ appResult + ", appDelete=" + appDelete + ", appDate=" + appDate + ", appLiMember=" + appLiMember
				+ ", appLiMemberName=" + appLiMemberName + ", appRefMember=" + appRefMember + ", appRefMemberName="
				+ appRefMemberName + ", fileList=" + fileList + "]";
	}


	
}
