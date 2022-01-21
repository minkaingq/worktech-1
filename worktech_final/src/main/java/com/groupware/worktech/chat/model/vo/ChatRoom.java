package com.groupware.worktech.chat.model.vo;

import java.sql.Timestamp;
import java.util.ArrayList;

public class ChatRoom {
	private int chatRoomNo;
	private String chatOpenMem;
	private String chatTitle;
	private int chatType;
	private String recentMsg; // 제일 최신 메시지
	private Timestamp sendTime; // 최신 메시지의 발송 시간
	private String time; // 발송 시간 포맷 변경
	private String date; // 발송 날짜 포맷 변경
	private int notReadCount; // 안 읽은 메시지 수
	private String chatStatus;
	private ArrayList<GatheringMember> gatheringList;
	
	public ChatRoom() {}

	public ChatRoom(int chatRoomNo, String chatOpenMem, String chatTitle, int chatType, String recentMsg,
			Timestamp sendTime, int notReadCount, ArrayList<GatheringMember> gatheringList) {
		super();
		this.chatRoomNo = chatRoomNo;
		this.chatOpenMem = chatOpenMem;
		this.chatTitle = chatTitle;
		this.chatType = chatType;
		this.recentMsg = recentMsg;
		this.sendTime = sendTime;
		this.notReadCount = notReadCount;
		this.gatheringList = gatheringList;
	}
	
	public ChatRoom(int chatRoomNo, String chatOpenMem, String chatTitle, int chatType, String recentMsg,
			Timestamp sendTime, String time, String date, int notReadCount, String chatStatus,
			ArrayList<GatheringMember> gatheringList) {
		super();
		this.chatRoomNo = chatRoomNo;
		this.chatOpenMem = chatOpenMem;
		this.chatTitle = chatTitle;
		this.chatType = chatType;
		this.recentMsg = recentMsg;
		this.sendTime = sendTime;
		this.time = time;
		this.date = date;
		this.notReadCount = notReadCount;
		this.chatStatus = chatStatus;
		this.gatheringList = gatheringList;
	}

	public int getChatRoomNo() {
		return chatRoomNo;
	}

	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}

	public String getChatOpenMem() {
		return chatOpenMem;
	}

	public void setChatOpenMem(String chatOpenMem) {
		this.chatOpenMem = chatOpenMem;
	}

	public String getChatTitle() {
		return chatTitle;
	}

	public void setChatTitle(String chatTitle) {
		this.chatTitle = chatTitle;
	}

	public int getChatType() {
		return chatType;
	}

	public void setChatType(int chatType) {
		this.chatType = chatType;
	}

	public ArrayList<GatheringMember> getGatheringList() {
		return gatheringList;
	}

	public void setGatheringList(ArrayList<GatheringMember> gatheringList) {
		this.gatheringList = gatheringList;
	}
	
	public String getRecentMsg() {
		return recentMsg;
	}

	public void setRecentMsg(String recentMsg) {
		this.recentMsg = recentMsg;
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

	public int getNotReadCount() {
		return notReadCount;
	}

	public void setNotReadCount(int notReadCount) {
		this.notReadCount = notReadCount;
	}
	
	public String getChatStatus() {
		return chatStatus;
	}

	public void setChatStatus(String chatStatus) {
		this.chatStatus = chatStatus;
	}

	@Override
	public String toString() {
		return "ChatRoom [chatRoomNo=" + chatRoomNo + ", chatOpenMem=" + chatOpenMem + ", chatTitle=" + chatTitle
				+ ", chatType=" + chatType + ", recentMsg=" + recentMsg + ", sendTime=" + sendTime + ", time=" + time
				+ ", date=" + date + ", notReadCount=" + notReadCount + ", chatStatus=" + chatStatus
				+ ", gatheringList=" + gatheringList + "]";
	}
}
