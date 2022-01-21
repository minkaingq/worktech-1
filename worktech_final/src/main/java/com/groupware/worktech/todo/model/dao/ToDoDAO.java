package com.groupware.worktech.todo.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.todo.model.vo.ToDo;

@Repository("tDAO")
public class ToDoDAO {

	public int insertToDo(SqlSessionTemplate sqlSession, ToDo toDo) {
		return sqlSession.insert("toDoMapper.insertToDo", toDo);
	}

	public ArrayList<ToDo> getAllList(SqlSessionTemplate sqlSession, String empNo) {
		return (ArrayList)sqlSession.selectList("toDoMapper.getAllList", empNo);
	}

	public int deleteToDo(SqlSessionTemplate sqlSession, Map map) {
		return sqlSession.delete("toDoMapper.deleteToDo", map);
	}

	public int updateToDo(SqlSessionTemplate sqlSession, ToDo toDo) {
		return sqlSession.update("toDoMapper.updateToDo", toDo);
	}

	public ArrayList<ToDo> getTodaySchedule(SqlSessionTemplate sqlSession, String empNo) {
		return (ArrayList)sqlSession.selectList("toDoMapper.getTodaySchedule", empNo);
	}
}
