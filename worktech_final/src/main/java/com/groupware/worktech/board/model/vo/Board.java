package com.groupware.worktech.board.model.vo;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;

public class Board {
	private int bNo;
	private String bTitle;
	private String bContent;
	private Date bDate;
	private int bCount;
	private String bType;
	private String bCritical;
	private String bWriter;
	private String name; // 게시판 작성자 이름
	private int categoryNo;
	private String categoryName;
	private String bStatus;
	private ArrayList<BoardFile> fileList;
	
	public Board() {}

	public Board(int bNo, String bTitle, String bContent, Date bDate, int bCount, String bType, String bCritical,
			String bWriter, String name, int categoryNo, String categoryName, String bStatus,
			ArrayList<BoardFile> fileList) {
		super();
		this.bNo = bNo;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bDate = bDate;
		this.bCount = bCount;
		this.bType = bType;
		this.bCritical = bCritical;
		this.bWriter = bWriter;
		this.name = name;
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
		this.bStatus = bStatus;
		this.fileList = fileList;
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

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public Date getbDate() {
		return bDate;
	}

	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}

	public int getbCount() {
		return bCount;
	}

	public void setbCount(int bCount) {
		this.bCount = bCount;
	}

	public String getbType() {
		return bType;
	}

	public void setbType(String bType) {
		this.bType = bType;
	}

	public String getbCritical() {
		return bCritical;
	}

	public void setbCritical(String bCritical) {
		this.bCritical = bCritical;
	}

	public String getbWriter() {
		return bWriter;
	}

	public void setbWriter(String bWriter) {
		this.bWriter = bWriter;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	
	public ArrayList<BoardFile> getFileList() {
		return fileList;
	}

	public void setFileList(ArrayList<BoardFile> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "Board [bNo=" + bNo + ", bTitle=" + bTitle + ", bContent=" + bContent + ", bDate=" + bDate + ", bCount="
				+ bCount + ", bType=" + bType + ", bCritical=" + bCritical + ", bWriter=" + bWriter + ", name=" + name
				+ ", categoryNo=" + categoryNo + ", categoryName=" + categoryName + ", bStatus=" + bStatus
				+ ", fileList=" + fileList + "]";
	}
	}

	