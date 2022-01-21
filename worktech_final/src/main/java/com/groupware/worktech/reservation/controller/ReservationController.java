package com.groupware.worktech.reservation.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.groupware.worktech.admin.model.vo.RvProduct;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.reservation.model.exception.RvException;
import com.groupware.worktech.reservation.model.service.RvService;
import com.groupware.worktech.reservation.model.vo.Reservation;

@Controller
public class ReservationController {
	
	@Autowired
	private RvService rvService;
	
	@RequestMapping("rvMeetingRoomView.rv")
	public String rvMeetingRoomView() {
		return "rvMeetingRoomView";
	}
	
	@RequestMapping("getrvMeetingRoomList.rv")
	public void getMeetingRoomList(HttpServletResponse response) {
		ArrayList<Reservation> list = rvService.getRvMeetingRoomList();
		
		if(list != null) {
			response.setContentType("application/json; charset=UTF-8");
			
			GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm");
			Gson gson = gb.create();
			
			try {
				gson.toJson(list, response.getWriter()); 
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("insertGenRvMeetingRoom.rv")
	public String rvAddForm() {
		return "insertRvMeetingRoom";
	}
	
	@RequestMapping("rvMeetingRoomInsert.rv")
	public String addReservation(@ModelAttribute Reservation r, @RequestParam("startTime") String startTime, 
								@RequestParam("endTime") String endTime, @RequestParam("rvName") String rvName,
								HttpSession session) {
		String rvMember = ((Member)session.getAttribute("loginUser")).getmNo();
		
		r.setRvMember(rvMember);
		
		startTime = String.format("%1$tY-%1$tm-%1$td", r.getRvDate()) + " " + startTime + ":00";
		endTime = String.format("%1$tY-%1$tm-%1$td", r.getRvDate()) + " " + endTime + ":00";
		
		Timestamp rvStartTime = Timestamp.valueOf(startTime);
		Timestamp rvEndTime = Timestamp.valueOf(endTime);
		
		r.setRvStartTime(rvStartTime);
		r.setRvEndTime(rvEndTime);
		
		int result = rvService.insertReservation(r);
		
		if(result > 0) {
			return "redirect:rvMeetingRoomView.rv";
		} else {
			throw new RvException("회의실 예약에 실패하였습니다.");
		}
		
	}
	
	@RequestMapping("checkTime.rv")
	public void checkDupTime(@RequestParam("rvStartTime") Date startTime, @RequestParam("rvEndTime") Date endTime,
							HttpServletResponse response) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		String strStartTime = sdf.format(startTime);
		String strEndTime = sdf.format(endTime);

		Date rvStartTime = null;
		Date rvEndTime = null;
		try {
			rvStartTime = sdf.parse(strStartTime);
			rvEndTime = sdf.parse(strEndTime);
			
			ArrayList<Reservation> list = rvService.getRvMeetingRoomList();
			
			int result = 0;
			for(Reservation li : list) {
				Date start = li.getRvStartTime();
				Date end = li.getRvEndTime();
				
				// rvStartTime : 입력받은 시작 시간
				// rvEndTime : 입력받은 종료 시간
				// start : DB에 저장되어 있는 시작 시간
				// end : DB에 저장되어 있는 종료 시간
				
				// 중복되는 시간이 있는지 확인
				if(start.compareTo(rvStartTime) == 0 || end.compareTo(rvEndTime) == 0) { // 시작 시간 혹은 끝나는 시간이 같은 경우
					result++;
					break;
				} else if(start.compareTo(rvStartTime) < 0 && end.compareTo(rvStartTime) > 0) { // 입력받은 시작 시간이 이미 저장된 시작 시간 ~ 종료 시간 사이인 경우
					result++;
					break;
				} else if (start.compareTo(rvEndTime) < 0 && end.compareTo(rvEndTime) > 0) { // 입력받은 종료 시간이 이미 저장된 시작 시간 ~ 종료 시간 사이
					result++;
					break;
				} else if (start.compareTo(rvStartTime) > 0 && end.compareTo(rvEndTime) < 0) { // 입력받은 시간이 DB에 저장된 시간을 포함하고 있는 경우
					result++;
					break;
				}
			}
			
			response.getWriter().println(result);
		} catch (ParseException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("meetRoomRvDetail.rv")
	public String meetingRoomDeatil(@RequestParam("rvNo") int rvNo, Model model) {
		Reservation rv = rvService.selectReservation(rvNo);
		
		if(rv != null) {
			model.addAttribute("rv", rv);
			
			return "detailRvMeetingRoom";
		} else {
			throw new RvException("회의실 예약 상세 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("rvMeetingRoomDelete.rv")
	public String deleteRvMeetingRoom(@RequestParam("rvNo") int rvNo) {
		int result = rvService.deleteReservation(rvNo);
		
		if(result > 0) {
			return "redirect:rvMeetingRoomView.rv";
		} else {
			throw new RvException("회의실 예약 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("insertSelectRvMeetingRoom.rv")
	public void addSelectMeetRoom(@RequestParam("startTime") String startTime, @RequestParam("rvUsage") String rvUsage,
			@RequestParam("endTime") String endTime, @RequestParam("date") String date,
			HttpSession session, HttpServletResponse response) {
		
		startTime = startTime.split(" G")[0];
		endTime = endTime.split(" G")[0];

		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss", Locale.US);
		SimpleDateFormat sdfTs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Timestamp rvStartTime = null;
		Timestamp rvEndTime = null;
		java.sql.Date rvDate = null;
		try {
			rvStartTime = Timestamp.valueOf(sdfTs.format(sdf.parse(startTime)));
			rvEndTime = Timestamp.valueOf(sdfTs.format(sdf.parse(endTime)));
			rvDate = java.sql.Date.valueOf(date);
			
			String rvMember = ((Member)session.getAttribute("loginUser")).getmNo();
			
			Reservation r = new Reservation(0, "MEETING", null, "회의실", 0, rvDate, (Timestamp)rvStartTime, (Timestamp)rvEndTime, rvUsage, rvMember, null, null);
			
			int result = rvService.insertReservation(r);
			
			if(result > 0) {
				response.getWriter().println(result);
			} else {
				throw new RvException("회의실 예약에 실패하였습니다.");
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	} 

	@RequestMapping("orvList.rv")
	public String orvList(Model model) {
		
		ArrayList<RvProduct> list = rvService.selectOrvList();
		
		// System.out.println(list);

		if(list != null) {
			model.addAttribute("list", list);
		} else {
			throw new RvException("기타 예약 목록 조회에 실패하였습니다.");
		}
		
		
		return "otherResevationList";
		
	}
	

	@RequestMapping("otherReservationInsertForm.rv")
	public String orvInsertForm(@RequestParam("pdNo") int pdNo, Model model) {
		
		
		RvProduct rv = new RvProduct();
		
		rv = rvService.selectFormOrvList(pdNo);
		
		if(rv != null) {
			model.addAttribute("rv", rv);
		} else {
			throw new RvException("기타 예약 폼 조회에 실패하였습니다.");
		}
		
		return "insertOtherReservation";
	}
	
	@RequestMapping("otherReservationInsert.rv")
	public String orvInsert(@ModelAttribute Reservation r, HttpSession session) {
		
		String rvMember = ((Member)session.getAttribute("loginUser")).getmNo();
		
		r.setRvMember(rvMember);
		
		int countUpdate = rvService.getCountUpdate(r);
		
		int result = rvService.insertOtherReservation(r);
		
		if(result > 0 && countUpdate > 0) {
			return "redirect:orvList.rv";			
		} else { 
			throw new RvException("기타 예약에 실패하였습니다.");
		}
		
	}
	
	@RequestMapping("myOrvList.rv")
	public String otherReservationListView(Model model, HttpSession session) {
		
		String rvMember = ((Member)session.getAttribute("loginUser")).getmNo();
		
		ArrayList<Reservation> list = rvService.selectMyOrvList(rvMember);
		
		if(list != null) {
			model.addAttribute("list", list);
		} else {
			throw new RvException("나의 예약 목록 조회에 실패하였습니다.");
		}

		return "myOtherReservationList";
	}
	
	@RequestMapping("myOrvDetail.rv")
	public String myOrvDetail(@RequestParam("rvNo") int rvNo, Model model) {
		
		Reservation rv = rvService.myOrvDetail(rvNo);
		
		if(rv != null) {
			model.addAttribute("rv", rv);
		} else {
			throw new RvException("나의 예약 목록 상세 조회에 실패하였습니다.");
		}
		
		return "detailMyOtherReservation";
	}
	
	@RequestMapping("orvListDelete.rv")
	public String myOrvListDelete(@ModelAttribute Reservation r, @RequestParam("rvNo") int rvNo, 
								  @RequestParam("rvpNo") int rvpNo, @RequestParam("rvCount") int rvCount, HttpSession session) {
		
		String rvMember = ((Member)session.getAttribute("loginUser")).getmNo();
		
		r.setRvMember(rvMember);
		
		Reservation rvp = new Reservation(rvpNo, rvCount);
		
		int result = rvService.myOrvListDelete(r);
		
		if(result > 0) {
			int countDelete = rvService.getCountDelete(rvp);
			if(countDelete > 0) {
				return "redirect:myOrvList.rv";			
			}
		} 
		
		throw new RvException("나의 예약 목록 신청 취소에 실패하였습니다.");
		
	} 
	
	@Scheduled(cron="0/10 * * * * *")
	public void updateMyOtherReservation() {
	
		int result = rvService.updateMyOtherReservation();
		
		if(result > 0) {
			System.out.println("들어왔나요?");
		}
	}
	
}
