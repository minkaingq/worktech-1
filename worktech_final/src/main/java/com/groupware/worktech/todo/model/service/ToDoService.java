package com.groupware.worktech.todo.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.groupware.worktech.todo.model.vo.ToDo;

public interface ToDoService {

	int insertToDo(ToDo toDo);

	ArrayList<ToDo> getAllList(String empNo);

	int deleteToDo(Map map);

	int updateToDo(ToDo toDo);

	ArrayList<ToDo> getTodayScehdule(String empNo);

}

