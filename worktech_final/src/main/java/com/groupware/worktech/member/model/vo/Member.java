package com.groupware.worktech.member.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class Member {

	private String mNo;
	private String email;
	private String mEmail;
	private String name;
	private String pwd;
	private String jobGrade;
	private Date birthDay;
	private String phone;
	private String address;
	private String mGrade; // 회원 등급 : user/admin
	private int dNo;
	private String dName; // 부서이름
	private Date hireDate;
	private Profile profile; // 프로필 사진
	private String mStatus;
	
	public Member() {}

	public Member(String mNo, String email, String name, String pwd, String jobGrade, Date birthDay, String phone,
			String address, String mGrade, int dNo, String dName, Date hireDate, String mStatus) {
		super();
		this.mNo = mNo;
		this.email = email;
		this.name = name;
		this.pwd = pwd;
		this.jobGrade = jobGrade;
		this.birthDay = birthDay;
		this.phone = phone;
		this.address = address;
		this.mGrade = mGrade;
		this.dNo = dNo;
		this.dName = dName;
		this.hireDate = hireDate;
		this.mStatus = mStatus;
	}
	
	public Member(String mNo, String email, String name, String pwd, String jobGrade, Date birthDay, String phone,
			String address, String mGrade, int dNo, String dName, Date hireDate, Profile profile,
			String mStatus) {
		super();
		this.mNo = mNo;
		this.email = email;
		this.name = name;
		this.pwd = pwd;
		this.jobGrade = jobGrade;
		this.birthDay = birthDay;
		this.phone = phone;
		this.address = address;
		this.mGrade = mGrade;
		this.dNo = dNo;
		this.dName = dName;
		this.hireDate = hireDate;
		this.profile = profile;
		this.mStatus = mStatus;
	}
		
	public Member(String mNo, String email, String mEmail, String name, String pwd, String jobGrade, Date birthDay,
			String phone, String address, String mGrade, int dNo, String dName, Date hireDate, Profile profile,
			String mStatus) {
		super();
		this.mNo = mNo;
		this.email = email;
		this.mEmail = mEmail;
		this.name = name;
		this.pwd = pwd;
		this.jobGrade = jobGrade;
		this.birthDay = birthDay;
		this.phone = phone;
		this.address = address;
		this.mGrade = mGrade;
		this.dNo = dNo;
		this.dName = dName;
		this.hireDate = hireDate;
		this.profile = profile;
		this.mStatus = mStatus;
	}

	public String getmNo() {
		return mNo;
	}

	public void setmNo(String mNo) {
		this.mNo = mNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getJobGrade() {
		return jobGrade;
	}

	public void setJobGrade(String jobGrade) {
		this.jobGrade = jobGrade;
	}

	public Date getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getmGrade() {
		return mGrade;
	}

	public void setmGrade(String mGrade) {
		this.mGrade = mGrade;
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

	public Date getHireDate() {
		return hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}

	public String getmStatus() {
		return mStatus;
	}

	public void setmStatus(String mStatus) {
		this.mStatus = mStatus;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	@Override
	public String toString() {
		return "Member [mNo=" + mNo + ", email=" + email + ", mEmail=" + mEmail + ", name=" + name + ", pwd=" + pwd
				+ ", jobGrade=" + jobGrade + ", birthDay=" + birthDay + ", phone=" + phone + ", address=" + address
				+ ", mGrade=" + mGrade + ", dNo=" + dNo + ", dName=" + dName + ", hireDate=" + hireDate + ", profile="
				+ profile + ", mStatus=" + mStatus + "]";
	}
	
}
