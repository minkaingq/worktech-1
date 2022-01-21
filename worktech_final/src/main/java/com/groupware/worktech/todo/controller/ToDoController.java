package com.groupware.worktech.todo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.todo.model.service.ToDoService;
import com.groupware.worktech.todo.model.vo.ToDo;

@Controller
public class ToDoController {

	@Autowired
	private ToDoService tService;

	@RequestMapping("todo.to")
	public String todoForm() {
		
		return "todo";
	}

	@RequestMapping(value = "insertTodo.to", method = RequestMethod.POST)
	public void insertTodo(@RequestBody ToDo toDo, HttpSession session, HttpServletResponse response) throws Exception {

		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();
		toDo.setmNo(mNo);

		System.out.println("toDo"+toDo);

		int result = tService.insertToDo(toDo);
		
		PrintWriter out = response.getWriter();
		if(result >= 1) {
			out.write(mNo);
		} 
		out.flush();
		out.close();
	}
	
	@RequestMapping(value = "updateToDo.to", method = RequestMethod.POST) // 모달 + 리사이즈
	public void updateToDo(@RequestBody ToDo toDo, HttpSession session, HttpServletResponse response) {
		
		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();
		toDo.setmNo(mNo);
		
		System.out.println("toDo"+toDo);
		
		int result = tService.updateToDo(toDo);
		System.out.println(result);
		PrintWriter out = null;
		try {
			out = response.getWriter();
			if(result >= 1) {
				out.write("success");
			} else {
				out.write("fail");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
	}
	
	@RequestMapping("getAllList.to")
	@ResponseBody
	public void getAllList(HttpSession session, HttpServletResponse response)  {
		String empNo = ((Member) session.getAttribute("loginUser")).getmNo();

		ArrayList<ToDo> list = tService.getAllList(empNo);
		
		System.out.println("list"+list);
		response.setContentType("application/json; charset=UTF-8");

		Gson gson = new GsonBuilder().setDateFormat("YYYY-MM-dd HH:mm").create();
		if(list != null) {
			try {
				gson.toJson(list, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("deleteTodo.to")
	@ResponseBody
	public void deleteToDo(HttpSession session, HttpServletResponse response, @RequestParam("tNo") String tNo) {
		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();
		Map map = new HashMap<String, String>();
		
		map.put("empNo", mNo);
		map.put("tNo", tNo);
		
		int result = tService.deleteToDo(map);
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
			if(result >= 1) {
				out.write("success");
			} else {
				out.write("fail");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
	}

}
