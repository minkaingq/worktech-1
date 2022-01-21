package com.groupware.worktech.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.chat.model.vo.ChatMessage;
import com.groupware.worktech.chat.model.vo.ChatRoom;
import com.groupware.worktech.chat.model.vo.GatheringMember;
import com.groupware.worktech.member.model.vo.Member;

@Repository("cDAO")
public class ChatDAO {

	public ArrayList<ChatRoom> selectChatList(SqlSessionTemplate sqlSession, String mNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatList", mNo);
	}

	public ArrayList<Department> getChatDepartmentList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("chatMapper.getChatDepartmentList");
	}

	public ArrayList<Member> selectDeptMember(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectDeptMember", map);
	}

	public ArrayList<String> selectMemberName(SqlSessionTemplate sqlSession, ArrayList<String> mNoes) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectMemberName", mNoes);
	}

	public int insertGroupChatroom(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.insert("chatMapper.insertGroupChatroom", map);
	}

	public int insertGroupChatList(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.insert("chatMapper.insertGroupChatList", mNo);
	}

	public ChatRoom selectCreateChatRoom(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("chatMapper.selectCreateChatRoom");
	}

	public ArrayList<ChatMessage> selectMessageList(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectMessageList", chatRoomNo);
	}

	public int getNotReadCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("chatMapper.getNotReadCount", map);
	}

	public int getExistChatroom(SqlSessionTemplate sqlSession, HashMap<String, String> chatroomInfo) {
		return sqlSession.selectOne("chatMapper.getExistChatroom", chatroomInfo);
	}

	public int insertPersonalChatroom(SqlSessionTemplate sqlSession, HashMap<String, String> chatroomInfo) {
		return sqlSession.insert("chatMapper.insertPersonalChatroom", chatroomInfo);
	}

	public int insertPersonalChatList(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.insert("chatMapper.insertGroupChatList", mNo);
	}

	public ArrayList<GatheringMember> getGatheringMemberList(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.getGatheringMemberList", chatRoomNo);
	}

	public ChatRoom getChatRoomInfo(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return sqlSession.selectOne("chatMapper.getChatRoomInfo", chatRoomNo);
	}

	public ArrayList<ChatMessage> getMessageList(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.getMessageList", chatRoomNo);
	}

	public int insertMessage(SqlSessionTemplate sqlSession, ChatMessage chatMsg) {
		return sqlSession.insert("chatMapper.insertMessage", chatMsg);
	}

	public int updateChatRoomReadTime(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("chatMapper.updateChatRoomReadTime", map);
	}

	public int updateChatRoomTitle(SqlSessionTemplate sqlSession, ChatRoom cr) {
		return sqlSession.update("chatMapper.updateChatRoomTitle", cr);
	}

	public int deleteGatheringMember(SqlSessionTemplate sqlSession, GatheringMember gm) {
		return sqlSession.delete("chatMapper.deleteGatheringMember", gm);
	}

	public int deleteChatRoom(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return sqlSession.update("chatMapper.deleteChatRoom", chatRoomNo);
	}

	public ArrayList<String> getGatheringMNoList(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.getGatheringMNoList", chatRoomNo);
	}

	public ArrayList<Member> selectInviteDeptMember(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectInviteDeptMember", map);
	}

	public int insertMoreMember(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("chatMapper.insertMoreMember", map);
	}

	public ArrayList<String> selectNames(SqlSessionTemplate sqlSession, ArrayList<String> mNoes) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectNames", mNoes);
	}

	public int insertSystemMessage(SqlSessionTemplate sqlSession, ChatMessage chatMsg) {
		return sqlSession.insert("chatMapper.insertSystemMessage", chatMsg);
	}

}
