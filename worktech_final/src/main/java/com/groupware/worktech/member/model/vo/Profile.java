package com.groupware.worktech.member.model.vo;

public class Profile {
	
	private int pNo;
	private String pUrl;
	private String pName;
	private String pReName;
	private String mNo;
	
	public Profile() {}

	public Profile(int pNo, String pUrl, String pName, String pReName, String mNo) {
		super();
		this.pNo = pNo;
		this.pUrl = pUrl;
		this.pName = pName;
		this.pReName = pReName;
		this.mNo = mNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getpUrl() {
		return pUrl;
	}

	public void setpUrl(String pUrl) {
		this.pUrl = pUrl;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getpReName() {
		return pReName;
	}

	public void setpReName(String pReName) {
		this.pReName = pReName;
	}

	public String getmNo() {
		return mNo;
	}

	public void setmNo(String mNo) {
		this.mNo = mNo;
	}

	@Override
	public String toString() {
		return "Profile [pNo=" + pNo + ", pUrl=" + pUrl + ", pName=" + pName + ", pReName=" + pReName + ", mNo=" + mNo
				+ "]";
	}

	
}
