package com.groupware.worktech.calendar.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.calendar.model.dao.CalendarDAO;
import com.groupware.worktech.calendar.model.vo.Calendar;

@Service("calService")
public class CalendarService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CalendarDAO calDAO;
	
	public int insertPCalendar(Calendar c) {
		return calDAO.insertPCalendar(sqlSession, c);
	}

}
