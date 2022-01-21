package com.groupware.worktech.admin.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class RvProduct {
	private int pdNo;
	private String pdCategory;
	private String pdName;
	private Date pdDate;
	private int pdCount;
	private String pdStatus;
	private ArrayList<RvRange> rvRange;
	
	public RvProduct() {}
	
	public RvProduct(int pdNo, String pdCategory, String pdName, Date pdDate, int pdCount, String pdStatus,
			ArrayList<RvRange> rvRange) {
		super();
		this.pdNo = pdNo;
		this.pdCategory = pdCategory;
		this.pdName = pdName;
		this.pdDate = pdDate;
		this.pdCount = pdCount;
		this.pdStatus = pdStatus;
		this.rvRange = rvRange;
	}
	
	

	public RvProduct(int pdNo, String pdCategory, String pdName, Date pdDate, int pdCount, String pdStatus) {
		super();
		this.pdNo = pdNo;
		this.pdCategory = pdCategory;
		this.pdName = pdName;
		this.pdDate = pdDate;
		this.pdCount = pdCount;
		this.pdStatus = pdStatus;
	}

	public int getPdNo() {
		return pdNo;
	}

	public void setPdNo(int pdNo) {
		this.pdNo = pdNo;
	}

	public String getPdCategory() {
		return pdCategory;
	}

	public void setPdCategory(String pdCategory) {
		this.pdCategory = pdCategory;
	}

	public String getPdName() {
		return pdName;
	}

	public void setPdName(String pdName) {
		this.pdName = pdName;
	}

	public Date getPdDate() {
		return pdDate;
	}

	public void setPdDate(Date pdDate) {
		this.pdDate = pdDate;
	}

	public int getPdCount() {
		return pdCount;
	}

	public void setPdCount(int pdCount) {
		this.pdCount = pdCount;
	}

	public String getPdStatus() {
		return pdStatus;
	}

	public void setPdStatus(String pdStatus) {
		this.pdStatus = pdStatus;
	}

	public ArrayList<RvRange> getRvRange() {
		return rvRange;
	}

	public void setRvRange(ArrayList<RvRange> rvRange) {
		this.rvRange = rvRange;
	}

	@Override
	public String toString() {
		return "RvProduct [pdNo=" + pdNo + ", pdCategory=" + pdCategory + ", pdName=" + pdName + ", pdDate=" + pdDate
				+ ", pdCount=" + pdCount + ", rvRange=" + rvRange + "]";
	}
}
