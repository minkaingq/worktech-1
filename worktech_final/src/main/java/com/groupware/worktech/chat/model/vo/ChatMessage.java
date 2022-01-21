package com.groupware.worktech.chat.model.vo;

import java.sql.Timestamp;

public class ChatMessage {
	private int msgId;
	private String msgContent;
	private Timestamp sendTime;
	private String time; // 발송 시간 포맷 변경
	private String date; // 발송 날짜 포맷 변경
	private String readYN; // 시스템 메시지, 일반 메시지 구분
	private int chatRoomNo;
	private String sendMember; // 보낸 사람 사번
	private String sendMemberName; // 보낸 사람 이름
	private String sendMemberFullName; // 보낸 사람 풀네임
	private String pReName;
	
	public ChatMessage() {}

	public ChatMessage(int msgId, String msgContent, Timestamp sendTime, String time, String date, String readYN,
			int chatRoomNo, String sendMember, String sendMemberName) {
		super();
		this.msgId = msgId;
		this.msgContent = msgContent;
		this.sendTime = sendTime;
		this.time = time;
		this.date = date;
		this.readYN = readYN;
		this.chatRoomNo = chatRoomNo;
		this.sendMember = sendMember;
		this.sendMemberName = sendMemberName;
	}
	
	public ChatMessage(int msgId, String msgContent, Timestamp sendTime, String time, String date, String readYN,
			int chatRoomNo, String sendMember, String sendMemberName, String profileUrl) {
		super();
		this.msgId = msgId;
		this.msgContent = msgContent;
		this.sendTime = sendTime;
		this.time = time;
		this.date = date;
		this.readYN = readYN;
		this.chatRoomNo = chatRoomNo;
		this.sendMember = sendMember;
		this.sendMemberName = sendMemberName;
		this.pReName = profileUrl;
	}

	public ChatMessage(int msgId, String msgContent, Timestamp sendTime, String time, String date, String readYN,
			int chatRoomNo, String sendMember, String sendMemberName, String sendMemberFullName, String profileUrl) {
		super();
		this.msgId = msgId;
		this.msgContent = msgContent;
		this.sendTime = sendTime;
		this.time = time;
		this.date = date;
		this.readYN = readYN;
		this.chatRoomNo = chatRoomNo;
		this.sendMember = sendMember;
		this.sendMemberName = sendMemberName;
		this.sendMemberFullName = sendMemberFullName;
		this.pReName = profileUrl;
	}

	public int getMsgId() {
		return msgId;
	}

	public void setMsgId(int msgId) {
		this.msgId = msgId;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getReadYN() {
		return readYN;
	}

	public void setReadYN(String readYN) {
		this.readYN = readYN;
	}

	public int getChatRoomNo() {
		return chatRoomNo;
	}

	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}

	public String getSendMember() {
		return sendMember;
	}

	public void setSendMember(String sendMember) {
		this.sendMember = sendMember;
	}

	public String getSendMemberName() {
		return sendMemberName;
	}

	public void setSendMemberName(String sendMemberName) {
		this.sendMemberName = sendMemberName;
	}

	public String getSendMemberFullName() {
		return sendMemberFullName;
	}

	public void setSendMemberFullName(String sendMemberFullName) {
		this.sendMemberFullName = sendMemberFullName;
	}

	public String getpReName() {
		return pReName;
	}

	public void setpReName(String pReName) {
		this.pReName = pReName;
	}

	@Override
	public String toString() {
		return "ChatMessage [msgId=" + msgId + ", msgContent=" + msgContent + ", sendTime=" + sendTime + ", time="
				+ time + ", date=" + date + ", readYN=" + readYN + ", chatRoomNo=" + chatRoomNo + ", sendMember="
				+ sendMember + ", sendMemberName=" + sendMemberName + ", sendMemberFullName=" + sendMemberFullName
				+ ", pReName=" + pReName + "]";
	}

}
