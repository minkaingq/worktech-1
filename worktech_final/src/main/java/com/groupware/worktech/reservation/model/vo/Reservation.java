package com.groupware.worktech.reservation.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Reservation {
	private int rvNo;
	private String rvType;
	private Integer rvpNo;
	private String rvName;
	private int rvCount;
	private Date rvDate;
	private Timestamp rvStartTime;
	private Timestamp rvEndTime;
	private String rvUsage;
	private String rvMember;
	private String rvCategory;
	private String rvMemberFullName; // 빌린 사원 부서명 + 이름 + 직급
	private String rvStatus;
	
	public Reservation() {}
	
	public Reservation(int rvNo, String rvType, Integer rvpNo, String rvName, int rvCount, Date rvDate,
			Timestamp rvStartTime, Timestamp rvEndTime, String rvUsage, String rvMember, String rvMemberFullName,
			String rvStatus) {
		super();
		this.rvNo = rvNo;
		this.rvType = rvType;
		this.rvpNo = rvpNo;
		this.rvName = rvName;
		this.rvCount = rvCount;
		this.rvDate = rvDate;
		this.rvStartTime = rvStartTime;
		this.rvEndTime = rvEndTime;
		this.rvUsage = rvUsage;
		this.rvMember = rvMember;
		this.rvMemberFullName = rvMemberFullName;
		this.rvStatus = rvStatus;
	}
	
	public Reservation(int rvNo, String rvType, Integer rvpNo, String rvName, int rvCount, Date rvDate,
			Timestamp rvStartTime, Timestamp rvEndTime, String rvUsage, String rvMember, String rvCategory,
			String rvMemberFullName, String rvStatus) {
		super();
		this.rvNo = rvNo;
		this.rvType = rvType;
		this.rvpNo = rvpNo;
		this.rvName = rvName;
		this.rvCount = rvCount;
		this.rvDate = rvDate;
		this.rvStartTime = rvStartTime;
		this.rvEndTime = rvEndTime;
		this.rvUsage = rvUsage;
		this.rvMember = rvMember;
		this.rvCategory = rvCategory;
		this.rvMemberFullName = rvMemberFullName;
		this.rvStatus = rvStatus;
	}
	
	public Reservation(Integer rvpNo, int rvCount) {
		super();
		this.rvpNo = rvpNo;
		this.rvCount = rvCount;
	}

	public int getRvNo() {
		return rvNo;
	}

	public void setRvNo(int rvNo) {
		this.rvNo = rvNo;
	}

	public String getRvType() {
		return rvType;
	}

	public void setRvType(String rvType) {
		this.rvType = rvType;
	}

	public Integer getRvpNo() {
		return rvpNo;
	}

	public void setRvpNo(Integer rvpNo) {
		this.rvpNo = rvpNo;
	}

	public String getRvName() {
		return rvName;
	}

	public void setRvName(String rvName) {
		this.rvName = rvName;
	}

	public int getRvCount() {
		return rvCount;
	}

	public void setRvCount(int rvCount) {
		this.rvCount = rvCount;
	}

	public Date getRvDate() {
		return rvDate;
	}

	public void setRvDate(Date rvDate) {
		this.rvDate = rvDate;
	}

	public Timestamp getRvStartTime() {
		return rvStartTime;
	}

	public void setRvStartTime(Timestamp rvStartTime) {
		this.rvStartTime = rvStartTime;
	}

	public Timestamp getRvEndTime() {
		return rvEndTime;
	}

	public void setRvEndTime(Timestamp rvEndTime) {
		this.rvEndTime = rvEndTime;
	}

	public String getRvUsage() {
		return rvUsage;
	}

	public void setRvUsage(String rvUsage) {
		this.rvUsage = rvUsage;
	}

	public String getRvMember() {
		return rvMember;
	}

	public void setRvMember(String rvMember) {
		this.rvMember = rvMember;
	}

	public String getRvMemberFullName() {
		return rvMemberFullName;
	}

	public void setRvMemberFullName(String rvMemberFullName) {
		this.rvMemberFullName = rvMemberFullName;
	}

	public String getRvStatus() {
		return rvStatus;
	}

	public void setRvStatus(String rvStatus) {
		this.rvStatus = rvStatus;
	}

	public String getRvCategory() {
		return rvCategory;
	}

	public void setRvCategory(String rvCategory) {
		this.rvCategory = rvCategory;
	}

	@Override
	public String toString() {
		return "Reservation [rvNo=" + rvNo + ", rvType=" + rvType + ", rvpNo=" + rvpNo + ", rvName=" + rvName
				+ ", rvCount=" + rvCount + ", rvDate=" + rvDate + ", rvStartTime=" + rvStartTime + ", rvEndTime="
				+ rvEndTime + ", rvUsage=" + rvUsage + ", rvMember=" + rvMember + ", rvMemberFullName="
				+ rvMemberFullName + ", rvStatus=" + rvStatus + "]";
	}
	
}
