package com.groupware.worktech.chat.model.vo;

import java.sql.Timestamp;

import com.groupware.worktech.member.model.vo.Profile;

public class GatheringMember {
	private int gatheringNo; // 참여자 리스트 번호
	private int chatRoomNo; // 채팅방 번호
	private String gatheringMember; // 참여자 사번
	private String gatheringMemberName; // 참여자 이름
	private Timestamp chatReadtime; // 해당 채팅방 읽은 시간
	private Profile profile; // 프로필 사진 경로
	private String gatheringMemberJobGrade;
	private String gatheringMemberDName;
	
	public GatheringMember() {}
	
	public GatheringMember(int gatheringNo, int chatRoomNo, String gatheringMember, Profile profile) {
		super();
		this.gatheringNo = gatheringNo;
		this.chatRoomNo = chatRoomNo;
		this.gatheringMember = gatheringMember;
		this.profile = profile;
	}

	public GatheringMember(int gatheringNo, int chatRoomNo, String gatheringMember, String gatheringMemberName,
			Profile profile) {
		super();
		this.gatheringNo = gatheringNo;
		this.chatRoomNo = chatRoomNo;
		this.gatheringMember = gatheringMember;
		this.gatheringMemberName = gatheringMemberName;
		this.profile = profile;
	}

	public GatheringMember(int gatheringNo, int chatRoomNo, String gatheringMember, String gatheringMemberName,
			Timestamp chatReadtime, Profile profile) {
		super();
		this.gatheringNo = gatheringNo;
		this.chatRoomNo = chatRoomNo;
		this.gatheringMember = gatheringMember;
		this.gatheringMemberName = gatheringMemberName;
		this.chatReadtime = chatReadtime;
		this.profile = profile;
	}
	
	public GatheringMember(int gatheringNo, int chatRoomNo, String gatheringMember, String gatheringMemberName,
			Timestamp chatReadtime, Profile profile, String gatheringMemberJobGrade, String gatheringMemberDName) {
		super();
		this.gatheringNo = gatheringNo;
		this.chatRoomNo = chatRoomNo;
		this.gatheringMember = gatheringMember;
		this.gatheringMemberName = gatheringMemberName;
		this.chatReadtime = chatReadtime;
		this.profile = profile;
		this.gatheringMemberJobGrade = gatheringMemberJobGrade;
		this.gatheringMemberDName = gatheringMemberDName;
	}

	public int getGatheringNo() {
		return gatheringNo;
	}

	public void setGatheringNo(int gatheringNo) {
		this.gatheringNo = gatheringNo;
	}

	public int getChatRoomNo() {
		return chatRoomNo;
	}

	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}

	public String getGatheringMember() {
		return gatheringMember;
	}

	public void setGatheringMember(String gatheringMember) {
		this.gatheringMember = gatheringMember;
	}
	
	public String getGatheringMemberName() {
		return gatheringMemberName;
	}

	public void setGatheringMemberName(String gatheringMemberName) {
		this.gatheringMemberName = gatheringMemberName;
	}
	
	public Timestamp getChatReadtime() {
		return chatReadtime;
	}

	public void setChatReadtime(Timestamp chatReadtime) {
		this.chatReadtime = chatReadtime;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}
	
	public String getGatheringMemberJobGrade() {
		return gatheringMemberJobGrade;
	}

	public void setGatheringMemberJobGrade(String gatheringMemberJobGrade) {
		this.gatheringMemberJobGrade = gatheringMemberJobGrade;
	}

	public String getGatheringMemberDName() {
		return gatheringMemberDName;
	}

	public void setGatheringMemberDName(String gatheringMemberDName) {
		this.gatheringMemberDName = gatheringMemberDName;
	}

	@Override
	public String toString() {
		return "GatheringMember [gatheringNo=" + gatheringNo + ", chatRoomNo=" + chatRoomNo + ", gatheringMember="
				+ gatheringMember + ", gatheringMemberName=" + gatheringMemberName + ", chatReadtime=" + chatReadtime
				+ ", profile=" + profile + ", gatheringMemberJobGrade=" + gatheringMemberJobGrade
				+ ", gatheringMemberDName=" + gatheringMemberDName + "]";
	}

}
