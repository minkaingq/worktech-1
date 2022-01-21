package com.groupware.worktech.alarm.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.groupware.worktech.member.model.vo.Member;

@Repository
public class AlarmHandler extends TextWebSocketHandler {

	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String mNo = getmNo(session);
		userSessionsMap.put(mNo, session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String sender = getmNo(session);
		
		String msg = message.getPayload();
		String[] strs = msg.split(",");

		if(strs != null && strs.length == 6) {
			String type = strs[0];
			String receiver = strs[1];
			
			WebSocketSession bWriterSession = userSessionsMap.get(receiver);
			
			// 일반 게시판 글 작성자가 로그인 중이라면
			if("cReply".equals(type) && bWriterSession != null && !sender.equals(receiver)) {
				TextMessage tmpMsg = new TextMessage(msg);
				bWriterSession.sendMessage(tmpMsg);
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String mNo = getmNo(session);
		userSessionsMap.remove(mNo, session);
	}

	private String getmNo(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member m = (Member)httpSession.get("loginUser");
		String mNo = m.getmNo();
		return mNo;
	}
}
