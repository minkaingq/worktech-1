package com.groupware.worktech.calendar.controller;

import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.groupware.worktech.calendar.model.exception.CalendarException;
import com.groupware.worktech.calendar.model.service.CalendarService;
import com.groupware.worktech.calendar.vo.Calendar;
import com.groupware.worktech.member.model.vo.Member;

@Controller
public class CalendarController {
	
	@Autowired
	CalendarService calService;
	
	@RequestMapping("myCal.cr")
	public String myCalendar() {
		return "pCalendar";
	}
	
	@RequestMapping("insertView.cr")
	public String insertView(@RequestParam("calStart") String calStart, @RequestParam("calEnd") String calEnd, Model model) {
		model.addAttribute("calStart", calStart);
		model.addAttribute("calEnd", calEnd);
		return "insertPCalendarView";
	}
	
	@RequestMapping("insertPCal.cr")
	public String inserePersonalCalendar(@ModelAttribute Calendar c, @RequestParam("calStartStr") String calStartStr,
										@RequestParam("calEndStr") String calEndStr, HttpSession session) {
		c.setCalWriter(((Member)session.getAttribute("loginUser")).getmNo());
		
		// Timestamp에 넣기 위해 변환
		calStartStr = calStartStr.replace("T", " ");
		calEndStr = calEndStr.replace("T", " ");
		
		if(calStartStr.length() == 23) {
			calStartStr = calStartStr.substring(0, calStartStr.lastIndexOf("."));
		} else if (calStartStr.length() == 16) {
			calStartStr += ":00";
		}
		
		if(calEndStr.length() == 23) {
			calEndStr = calEndStr.substring(0, calEndStr.lastIndexOf("."));
		} else if (calEndStr.length() == 16) {
			calEndStr += ":00";
		}
		
		c.setCalStart(Timestamp.valueOf(calStartStr));
		c.setCalEnd(Timestamp.valueOf(calEndStr));
		
		int result = calService.insertPCalendar(c);
		
		if(result > 0) {
			return "redirect:myCal.cr";
		} else {
			throw new CalendarException("일정 등록에 실패하였습니다.");
		}
	}

}
