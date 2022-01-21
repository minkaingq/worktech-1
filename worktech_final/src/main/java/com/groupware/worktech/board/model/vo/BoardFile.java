package com.groupware.worktech.board.model.vo;

public class BoardFile {
	private int fNo;
	private String fURL;
	private String fName; // 원본 파일명
	private String fRname; // 수정 파일명
	private int refBNo; // 참조 글 번호
	
	public BoardFile() {}

	public BoardFile(int fNo, String fURL, String fName, String fRname, int refBNo) {
		super();
		this.fNo = fNo;
		this.fURL = fURL;
		this.fName = fName;
		this.fRname = fRname;
		this.refBNo = refBNo;
	}

	public int getfNo() {
		return fNo;
	}

	public void setfNo(int fNo) {
		this.fNo = fNo;
	}

	public String getfURL() {
		return fURL;
	}

	public void setfURL(String fURL) {
		this.fURL = fURL;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getfRname() {
		return fRname;
	}

	public void setfRname(String fRname) {
		this.fRname = fRname;
	}

	public int getRefBNo() {
		return refBNo;
	}

	public void setRefBNo(int refBNo) {
		this.refBNo = refBNo;
	}

	@Override
	public String toString() {
		return "File [fNo=" + fNo + ", fURL=" + fURL + ", fName=" + fName + ", fRname=" + fRname + ", refBNo=" + refBNo
				+ "]";
	}
}
