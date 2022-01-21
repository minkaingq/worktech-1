package com.groupware.worktech.calendar.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.calendar.model.vo.Calendar;

@Repository("calDAO")
public class CalendarDAO {

	public int insertPCalendar(SqlSessionTemplate sqlSession, Calendar c) {
		return sqlSession.insert("calendarMapper.insertPCalendar", c);
	}

}
