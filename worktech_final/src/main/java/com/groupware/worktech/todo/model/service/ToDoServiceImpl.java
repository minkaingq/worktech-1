package com.groupware.worktech.todo.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.todo.model.dao.ToDoDAO;
import com.groupware.worktech.todo.model.vo.ToDo;

@Service("tService")
public class ToDoServiceImpl implements ToDoService {

@Autowired
private ToDoDAO tDAO;

@Autowired
private SqlSessionTemplate sqlSession;

	@Override
	public int insertToDo(ToDo toDo) {
		return tDAO.insertToDo(sqlSession, toDo);
	}
	
	@Override
	public ArrayList<ToDo> getAllList(String empNo) {
		return tDAO.getAllList(sqlSession, empNo);
	}

	@Override
	public int deleteToDo(Map map) {
		return tDAO.deleteToDo(sqlSession, map);
	}

	@Override
	public int updateToDo(ToDo toDo) {
		return tDAO.updateToDo(sqlSession, toDo);
	}

	@Override
	public ArrayList<ToDo> getTodayScehdule(String empNo) {
		return tDAO.getTodaySchedule(sqlSession, empNo);
	}
}

