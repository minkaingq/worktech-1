package com.groupware.worktech.chat.common;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.groupware.worktech.chat.model.exception.ChatException;
import com.groupware.worktech.chat.model.service.ChatService;
import com.groupware.worktech.chat.model.vo.ChatMessage;
import com.groupware.worktech.member.model.vo.Member;

@Controller
public class WebSocketHandler extends TextWebSocketHandler implements InitializingBean {
	// WebSocketSession : 웹소켓이 연결될 때 생기는 Session
	private static List<WebSocketSession> sessions = new ArrayList<>();
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	private static int i;
	
	@Autowired
	private ChatService cService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// Connection이 연결되었을 때 -> 클라이언트가 서버에 접속을 성공했을 경우에 실행
		i++;
        System.out.println(session.getId() + " 연결 성공 => 총 접속 인원 : " + i + "명"); // 접속 인원 확인 위함
		
        sessions.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// Socket에 메시지를 보냈을 때 실행
		
		String msg = message.getPayload();
		
		ChatMessage chatMsg = objectMapper.readValue(msg, ChatMessage.class);
		
		int result = 0;
		
		if(chatMsg.getReadYN() != null && chatMsg.getReadYN().equals("Y")) {
			// 받은 메시지가 시스템 메시지인 경우
			result = cService.insertSystemMessage(chatMsg);
		} else {
			// 받은 메시지가 일반 메시지인 경우
			result = cService.insertMessage(chatMsg);
		}
		
		if(result <= 0) {
			throw new ChatException("메시지 저장 실패");
		} else {
//			System.out.println("메시지 저장 성공");
			
			for(WebSocketSession sess : sessions) {
				sess.sendMessage(message);
			}
		}
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// Connection이 close되었을 때
		i--;
        System.out.println(session.getId() + " 연결 종료 => 총 접속 인원 : " + i + "명"); // 접속 인원 확인 위함
		
		sessions.remove(session);
	}

	@Override
	public void afterPropertiesSet() throws Exception {}
}
