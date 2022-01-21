package com.groupware.worktech.chat.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.chat.model.exception.ChatException;
import com.groupware.worktech.chat.model.service.ChatService;
import com.groupware.worktech.chat.model.vo.ChatMessage;
import com.groupware.worktech.chat.model.vo.ChatRoom;
import com.groupware.worktech.chat.model.vo.GatheringMember;
import com.groupware.worktech.member.model.vo.Member;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService cService;
	
	@RequestMapping("chatView.ct")
	public String chatListView(Model model, HttpSession session) {
		String mNo = ((Member)session.getAttribute("loginUser")).getmNo();
		
		ArrayList<ChatRoom> list = cService.selectChatList(mNo);
		
		if(list != null) {
			for(ChatRoom c : list) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("chatRoomNo", Integer.toString(c.getChatRoomNo()));
				map.put("mNo", mNo);
				
				int notReadCount = cService.getNotReadCount(map);
				
				c.setNotReadCount(notReadCount);
				
				if(c.getSendTime() != null) {
					String date = new SimpleDateFormat("yyyy-MM-dd").format(c.getSendTime());
					String time = new SimpleDateFormat("HH:mm").format(c.getSendTime());
					
					c.setDate(date);
					c.setTime(time);
				}
			}
			
			model.addAttribute("list", list);
			return "chatList";
		} else {
			throw new ChatException("채팅 목록 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("chatDetail.ct")
	public String chatDetail(@RequestParam("chatRoomNo") int chatRoomNo, Model model,
							@RequestParam(value="names", required = false) ArrayList<String> names) {
		// 해당 채팅방 정보 가져오기
		ChatRoom cr = cService.getChatRoomInfo(chatRoomNo);
		
		if(cr != null) {
			// 해당 채팅방 인원 목록 가져오기
			ArrayList<GatheringMember> memberList = cService.getGatheringMemberList(chatRoomNo);
			
			if(memberList != null) {
				// 해당 채팅방 메시지 가져오기
				ArrayList<ChatMessage> messageList = cService.getMessageList(chatRoomNo);
				
				for(ChatMessage cm : messageList) {
					if(cm.getSendTime() != null) {
						String date = new SimpleDateFormat("yyyy-MM-dd").format(cm.getSendTime());
						String time = new SimpleDateFormat("HH:mm").format(cm.getSendTime());
						
						cm.setDate(date);
						cm.setTime(time);
					}
				}
				
				if(names != null) {
					model.addAttribute("names", names);
				}
				
				model.addAttribute("cr", cr);
				model.addAttribute("memberList", memberList);
				model.addAttribute("messageList", messageList);
				
				return "chatMessage";
			}
		}
		
		throw new ChatException("채팅방 입장에 실패하였습니다.");
	}
	
	@RequestMapping("addChatView.ct")
	public String addChatView(Model model) {
		ArrayList<Department> list = cService.getChatDepartmentList();
		
		if(list != null) {
			JSONArray jArr = new JSONArray();
			
			for(Department d : list) {
				JSONObject jo = new JSONObject();
				jo.put("id", d.getdNo());
				jo.put("pId", d.getdParent());
				jo.put("name", d.getdName());
				
				jArr.add(jo);
			}
			
			model.addAttribute("jsonArray", jArr);
			return "insertChatView";
		} else {
			throw new ChatException("채팅방 생성 화면 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("deptSelect.ct")
	public void selectDeptMember(@RequestParam("dNo") int dNo, HttpServletResponse response, HttpSession session) {
		String mNo = ((Member)session.getAttribute("loginUser")).getmNo();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mNo", mNo);
		map.put("dNo", Integer.toString(dNo));
		
		ArrayList<Member> list = cService.selectDeptMember(map);
		
		if(list != null) {
			response.setContentType("application/json; charset=UTF-8");
			
			Gson gson = new Gson();
			
			try {
				gson.toJson(list, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			throw new ChatException("부서원 목록 조회에 실패하였습니다.");
		}
	}
	
	// 단체 대화 생성
	@Transactional
	@RequestMapping("addGroupChat.ct")
	public String insertGroupChat(@RequestParam("mNo") ArrayList<String> mNoes, @RequestParam(value = "chatTitle", required = false) String chatTitle,
								  @RequestParam("chatType") int chatType, HttpSession session, Model model) {
		// 채팅방 이름이 없는 경우 멤버 이름으로 채팅방 이름 생성
		if(chatType == 0) {
			if(chatTitle.equals("")) {
				ArrayList<String> mNames = cService.selectMemberName(mNoes); 
				
				for(int i = 0; i < mNames.size(); i++) {
					chatTitle += mNames.get(i);
					
					// 너무 길면 자르기
					if(chatTitle.length() > 18) {
						chatTitle.substring(0, 16);
						chatTitle += "...";
						break;
					}
					
					if(i != mNames.size() - 1) {
						chatTitle += ", ";
					}
				}
			}
		} else if(chatType == 1) {
			chatTitle = "공지사항 채팅";
		}
		
		String chatOpen = ((Member)session.getAttribute("loginUser")).getmNo();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("chatTitle", chatTitle);
		map.put("chatOpen", chatOpen);
		map.put("chatType", Integer.toString(chatType));
		
		int creatChatroom = cService.insertGroupChatroom(map);
		
		if(creatChatroom > 0) {
			mNoes.add(chatOpen);
			
			int createChatList = cService.insertGroupChatList(mNoes);
			
			if(createChatList >= mNoes.size()) {
				ChatRoom chatroomInfo = cService.selectCreateChatRoom();
				
				if(chatroomInfo != null) {
					ArrayList<GatheringMember> memberList = cService.getGatheringMemberList(chatroomInfo.getChatRoomNo());

					model.addAttribute("cr", chatroomInfo);
					model.addAttribute("memberList", memberList);
					
					return "chatMessage";
				}
			}
		}
		
		throw new ChatException("채팅방 생성에 실패하였습니다.");
	}
	
	@RequestMapping("reloadChatList.ct")
	public void reloadChatList(HttpServletResponse response, HttpSession session) {
		String mNo = ((Member)session.getAttribute("loginUser")).getmNo();
		
		ArrayList<ChatRoom> list = cService.selectChatList(mNo);
		
		if(list != null) {
			response.setContentType("application/json; charset=UTF-8");
			
			for(ChatRoom c : list) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("chatRoomNo", Integer.toString(c.getChatRoomNo()));
				map.put("mNo", mNo);
				
				int notReadCount = cService.getNotReadCount(map);
				
				c.setNotReadCount(notReadCount);
				
				if(c.getSendTime() != null) {
					String date = new SimpleDateFormat("yyyy-MM-dd").format(c.getSendTime());
					String time = new SimpleDateFormat("HH:mm").format(c.getSendTime());
					
					c.setDate(date);
					c.setTime(time);
				}
			}
			
			GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss");
			Gson gson = gb.create();

			try {
				gson.toJson(list, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			throw new ChatException("채팅 목록 재조회에 실패하였습니다.");
		}
	}
	
	// 개인 대화 생성
	@Transactional
	@RequestMapping("addPersonalChat.ct")
	public String insertPersonalChat(@RequestParam("selectmNo") String selectmNo,
									HttpSession session, Model model) {
		String mNo = ((Member)session.getAttribute("loginUser")).getmNo();
		HashMap<String, String> chatroomInfo = new HashMap<String, String>();
		String chatTitle = "Personal";
		chatroomInfo.put("chatTitle", chatTitle);
		chatroomInfo.put("selectmNo", selectmNo);
		chatroomInfo.put("mNo", mNo);
		
		// 개인 대화가 없다면 CHATROOM 테이블에 INSERT하기 위해 채팅방 번호가 있는지 확인
		int existChatroomNo = cService.getExistChatroom(chatroomInfo);
		
		if(existChatroomNo == 0) {
			// 채팅방 테이블 INSERT
			int creatChatroom = cService.insertPersonalChatroom(chatroomInfo);
			
			if(creatChatroom > 0) {
				int createChatList = 0;
				createChatList += cService.insertPersonalChatList(selectmNo);
				createChatList += cService.insertPersonalChatList(mNo);
				
				if(createChatList >= 2) {
					ChatRoom cr = cService.selectCreateChatRoom();
					
					if(cr != null) {
						ArrayList<GatheringMember> memberList = cService.getGatheringMemberList(cr.getChatRoomNo());

						model.addAttribute("cr", cr);
						model.addAttribute("memberList", memberList);
						return "chatMessage";
					}
				}
			}
			
			throw new ChatException("1:1 채팅 생성에 실패하였습니다.");
			
		} else {
			model.addAttribute("chatRoomNo", existChatroomNo);
			
			return "redirect:chatDetail.ct";
		}
		
	}
	
	@RequestMapping("updateTime.ct")
	public void updateChatRoomReadTime(@RequestParam("mNo") String mNo, @RequestParam("chatRoomNo") int chatRoomNo, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("mNo", mNo);
		map.put("chatRoomNo", chatRoomNo);
		
		String result = cService.updateChatRoomReadTime(map) == 0 ? "fail" : "success";
		
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("renameChatTitle.ct")
	public String renameChatRoomTitle(@ModelAttribute ChatRoom cr, Model model) {
		int result = cService.updateChatRoomTitle(cr);
		
		if(result > 0) {
			model.addAttribute("chatRoomNo", cr.getChatRoomNo());
			
			return "redirect:chatDetail.ct";
		} else {
			throw new ChatException("채팅방 제목 변경에 실패하였습니다.");
		}
	}
	
	@RequestMapping("quitChatRoom.ct")
	public String quitChatRoom(@ModelAttribute GatheringMember gm) {
		int result = cService.deleteGatheringMember(gm);
		
		if(result > 0) {
			return "redirect:chatView.ct";
		} else {
			throw new ChatException("채팅방 나가기에 실패하였습니다.");
		}
	}
	
	@RequestMapping("deleteChatRoom.ct")
	public String deleteChatRoom(@RequestParam("chatRoomNo") int chatRoomNo) {
		int result = cService.deleteChatRoom(chatRoomNo);
		
		if(result > 0) {
			return "redirect:chatView.ct";
		} else {
			throw new ChatException("채팅방 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("inviteChatMemberView.ct")
	public String addInviteView(Model model, @RequestParam("chatRoomNo") int chatRoomNo) {
		ArrayList<Department> list = cService.getChatDepartmentList();
		
		if(list != null) {
			JSONArray jArr = new JSONArray();
			
			for(Department d : list) {
				JSONObject jo = new JSONObject();
				jo.put("id", d.getdNo());
				jo.put("pId", d.getdParent());
				jo.put("name", d.getdName());
				
				jArr.add(jo);
			}
			
			model.addAttribute("jsonArray", jArr);
			model.addAttribute("chatRoomNo", chatRoomNo);
			return "inviteChatView";
		} else {
			throw new ChatException("채팅방 초대 화면 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("deptInviteSelect.ct")
	public void selectInviteDeptMember(@RequestParam("dNo") int dNo, @RequestParam("chatRoomNo") int chatRoomNo, 
										HttpServletResponse response, HttpSession session) {
		
		ArrayList<String> mNoList = cService.getGatheringMNoList(chatRoomNo);
		
		if(mNoList != null) {
			String myMNo = ((Member)session.getAttribute("loginUser")).getmNo();
			mNoList.add(myMNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("mNoList", mNoList);
			map.put("dNo", dNo);
			
			ArrayList<Member> list = cService.selectInviteDeptMember(map);
			
			if(list != null) {
				response.setContentType("application/json; charset=UTF-8");
				
				Gson gson = new Gson();
				
				try {
					gson.toJson(list, response.getWriter());
				} catch (JsonIOException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				throw new ChatException("초대할 부서원 목록 조회에 실패하였습니다.");
			}
		} else {
			throw new ChatException("초대할 부서원 목록 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("addMoreMember.ct")
	public String insertMoreMember(@RequestParam("mNo") ArrayList<String> mNoes, @RequestParam("chatRoomNo") int chatRoomNo, 
									HttpSession session, Model model) {
		int result = 0;
		
		for(String mNo : mNoes) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("mNo", mNo);
			map.put("chatRoomNo", chatRoomNo);
			
			result += cService.insertMoreMember(map);
		}
		
		
		if(result >= mNoes.size()) {
			ArrayList<String> names = cService.selectNames(mNoes);
			if(names != null) {
				model.addAttribute("names", names);
			}
			model.addAttribute("chatRoomNo", chatRoomNo);
			
			return "redirect:chatDetail.ct";
		} else {
			throw new ChatException("멤버 초대에 실패하였습니다.");
		}
		

	}
	
}
