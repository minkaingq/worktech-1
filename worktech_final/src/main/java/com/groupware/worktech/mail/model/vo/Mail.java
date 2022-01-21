package com.groupware.worktech.mail.model.vo;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Mail {

	private int mailNo;
	private String receiveEmp; // 받는 사람
	private String etype; // 외부, 내부
	private String etitle;
	private String econtent;
	private String estatus;
	private Timestamp sDate; // 보낸 시간
	private String mNo;
	private String senderMailId; // 보낸 사람 메일 주소
	private String senderName;
	private String receiverName; // 받는 사람 이름
	private ArrayList<MailFile> mailFileList;
	private ArrayList<MailSR> mailSRList; 
	private Timestamp receiverRTime; // 읽은 시간
	
	public Timestamp getReceiverRTime() {
		return receiverRTime;
	}

	public void setReceiverRTime(Timestamp receiverRTime) {
		this.receiverRTime = receiverRTime;
	}

	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Timestamp sDate, String mNo, String senderMailId, String senderName, String receiverName,
			ArrayList<MailFile> mailFileList, ArrayList<MailSR> mailSRList, Timestamp receiverRTime) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.sDate = sDate;
		this.mNo = mNo;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.receiverName = receiverName;
		this.mailFileList = mailFileList;
		this.mailSRList = mailSRList;
		this.receiverRTime = receiverRTime;
	}

	public Mail() {}
	
	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Timestamp sDate, String senderMailId, String senderName, ArrayList<MailFile> mailFileList) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.sDate = sDate;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.mailFileList = mailFileList;
	}

	public String getmNo() {
		return mNo;
	}

	public void setMNo(String mNo) {
		this.mNo = mNo;
	}
	
	

	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Timestamp sDate, String mNo, String senderMailId, String senderName,
			ArrayList<MailFile> mailFileList) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.sDate = sDate;
		this.mNo = mNo;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.mailFileList = mailFileList;
	}

	public int getMailNo() {
		return mailNo;
	}
	public void setMailNo(int mailNo) {
		this.mailNo = mailNo;
	}
	public String getReceiveEmp() {
		return receiveEmp;
	}
	public void setReceiveEmp(String receiveEmp) {
		this.receiveEmp = receiveEmp;
	}
	public String getEtype() {
		return etype;
	}
	public void setEtype(String etype) {
		this.etype = etype;
	}
	public String getEtitle() {
		return etitle;
	}
	public void setEtitle(String etitle) {
		this.etitle = etitle;
	}
	public String getEcontent() {
		return econtent;
	}
	public void setEcontent(String econtent) {
		this.econtent = econtent;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public Timestamp getsDate() {
		return sDate;
	}
	public void setsDate(Timestamp sDate) {
		this.sDate = sDate;
	}
	public String getSenderMailId() {
		return senderMailId;
	}
	public void setSenderMailId(String senderMailId) {
		this.senderMailId = senderMailId;
	}
	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus,
			Timestamp sDate, String mNo, String senderMailId, String senderName, String receiverName,
			ArrayList<MailFile> mailFileList) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.sDate = sDate;
		this.mNo = mNo;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.receiverName = receiverName;
		this.mailFileList = mailFileList;
	}



	public Mail(int mailNo, String receiveEmp, String etype, String etitle, String econtent, String estatus, Timestamp sDate,
			String mNo, String senderMailId, String senderName, String receiverName, ArrayList<MailFile> mailFileList,
			ArrayList<MailSR> mailSRList) {
		super();
		this.mailNo = mailNo;
		this.receiveEmp = receiveEmp;
		this.etype = etype;
		this.etitle = etitle;
		this.econtent = econtent;
		this.estatus = estatus;
		this.sDate = sDate;
		this.mNo = mNo;
		this.senderMailId = senderMailId;
		this.senderName = senderName;
		this.receiverName = receiverName;
		this.mailFileList = mailFileList;
		this.mailSRList = mailSRList;
	}

	public ArrayList<MailSR> getMailSRList() {
		return mailSRList;
	}

	public void setMailSRList(ArrayList<MailSR> mailSRList) {
		this.mailSRList = mailSRList;
	}

	@Override
	public String toString() {
		return "Mail [mailNo=" + mailNo + ", receiveEmp=" + receiveEmp + ", etype=" + etype + ", etitle=" + etitle
				+ ", econtent=" + econtent + ", estatus=" + estatus + ", sDate=" + sDate + ", mNo=" + mNo
				+ ", senderMailId=" + senderMailId + ", senderName=" + senderName + ", receiverName=" + receiverName
				+ ", mailFileList=" + mailFileList + ", mailSRList=" + mailSRList + ", receiverRTime=" + receiverRTime
				+ "]";
	}

	public ArrayList<MailFile> getMailFileList() {
		return mailFileList;
	}
	public void setMailFileList(ArrayList<MailFile> mailFileList) {
		this.mailFileList = mailFileList;
	}

}