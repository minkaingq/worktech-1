package com.groupware.worktech.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.chat.model.dao.ChatDAO;
import com.groupware.worktech.chat.model.vo.ChatMessage;
import com.groupware.worktech.chat.model.vo.ChatRoom;
import com.groupware.worktech.chat.model.vo.GatheringMember;
import com.groupware.worktech.member.model.vo.Member;

@Service("cService")
public class ChatService {
	
	@Autowired
	private ChatDAO cDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<ChatRoom> selectChatList(String mNo) {
		return cDAO.selectChatList(sqlSession, mNo);
	}

	public ArrayList<Department> getChatDepartmentList() {
		return cDAO.getChatDepartmentList(sqlSession);
	}

	public ArrayList<Member> selectDeptMember(HashMap<String, String> map) {
		return cDAO.selectDeptMember(sqlSession, map);
	}

	public ArrayList<String> selectMemberName(ArrayList<String> mNoes) {
		return cDAO.selectMemberName(sqlSession, mNoes);
	}

	public int insertGroupChatroom(HashMap<String, String> map) {
		return cDAO.insertGroupChatroom(sqlSession, map);
	}

	public int insertGroupChatList(ArrayList<String> mNoes) {
		int result = 0;
		
		for(String mNo : mNoes) {
			result += cDAO.insertGroupChatList(sqlSession, mNo);
		}
		
		return result;
	}

	public ChatRoom selectCreateChatRoom() {
		return cDAO.selectCreateChatRoom(sqlSession);
	}

	public ArrayList<ChatMessage> selectMessageList(int chatRoomNo) {
		return cDAO.selectMessageList(sqlSession, chatRoomNo);
	}

	public int getNotReadCount(HashMap<String, String> map) {
		return cDAO.getNotReadCount(sqlSession, map);
	}

	public int getExistChatroom(HashMap<String, String> chatroomInfo) {
		return cDAO.getExistChatroom(sqlSession, chatroomInfo);
	}

	public int insertPersonalChatroom(HashMap<String, String> chatroomInfo) {
		return cDAO.insertPersonalChatroom(sqlSession, chatroomInfo);
	}

	public int insertPersonalChatList(String mNo) {
		return cDAO.insertPersonalChatList(sqlSession, mNo);
	}

	public ArrayList<GatheringMember> getGatheringMemberList(int chatRoomNo) {
		return cDAO.getGatheringMemberList(sqlSession, chatRoomNo);
	}

	public ChatRoom getChatRoomInfo(int chatRoomNo) {
		return cDAO.getChatRoomInfo(sqlSession, chatRoomNo);
	}

	public ArrayList<ChatMessage> getMessageList(int chatRoomNo) {
		return cDAO.getMessageList(sqlSession, chatRoomNo);
	}

	public int insertMessage(ChatMessage chatMsg) {
		return cDAO.insertMessage(sqlSession, chatMsg);
	}

	public int updateChatRoomReadTime(HashMap<String, Object> map) {
		return cDAO.updateChatRoomReadTime(sqlSession, map);
	}

	public int updateChatRoomTitle(ChatRoom cr) {
		return cDAO.updateChatRoomTitle(sqlSession, cr);
	}

	public int deleteGatheringMember(GatheringMember gm) {
		return cDAO.deleteGatheringMember(sqlSession, gm);
	}

	public int deleteChatRoom(int chatRoomNo) {
		return cDAO.deleteChatRoom(sqlSession, chatRoomNo);
	}

	public ArrayList<String> getGatheringMNoList(int chatRoomNo) {
		return cDAO.getGatheringMNoList(sqlSession, chatRoomNo);
	}

	public ArrayList<Member> selectInviteDeptMember(HashMap<String, Object> map) {
		return cDAO.selectInviteDeptMember(sqlSession, map);
	}

	public int insertMoreMember(HashMap<String, Object> map) {
		return cDAO.insertMoreMember(sqlSession, map);
	}

	public ArrayList<String> selectNames(ArrayList<String> mNoes) {
		return cDAO.selectNames(sqlSession, mNoes);
	}

	public int insertSystemMessage(ChatMessage chatMsg) {
		return cDAO.insertSystemMessage(sqlSession, chatMsg);
	}
}
