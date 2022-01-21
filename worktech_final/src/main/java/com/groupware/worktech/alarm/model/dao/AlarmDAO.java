package com.groupware.worktech.alarm.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.alarm.model.vo.Alarm;

@Repository
public class AlarmDAO {

	public ArrayList<Alarm> selectAlarmList(SqlSessionTemplate sqlSession, String mNo) {
		return (ArrayList)sqlSession.selectList("alarmMapper.selectAlarmList", mNo);
	}

	public int selectAlarmNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("alarmMapper.selectAlarmNo");
	}

	public int checkAlarm(SqlSessionTemplate sqlSession, int alarmNo) {
		return sqlSession.update("alarmMapper.checkAlarm", alarmNo);
	}

}
