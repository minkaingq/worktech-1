package com.groupware.worktech.alarm.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.alarm.model.dao.AlarmDAO;
import com.groupware.worktech.alarm.model.vo.Alarm;

@Service
public class AlarmService {

	@Autowired
	private AlarmDAO alDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Alarm> selectAlarmList(String mNo) {
		return alDAO.selectAlarmList(sqlSession, mNo);
	}

	public int selectAlarmNo() {
		return alDAO.selectAlarmNo(sqlSession);
	}

	public int checkAlarm(int alarmNo) {
		return alDAO.checkAlarm(sqlSession, alarmNo);
	}
}
