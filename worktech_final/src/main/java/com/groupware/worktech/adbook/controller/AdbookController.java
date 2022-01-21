package com.groupware.worktech.adbook.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupware.worktech.adbook.model.exception.AdbookException;
import com.groupware.worktech.adbook.model.service.AdbookService;
import com.groupware.worktech.adbook.model.vo.Adbook;
import com.groupware.worktech.admin.model.service.AdminService;
import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.common.Pagination;
import com.groupware.worktech.member.model.vo.Member;

@Controller
public class AdbookController {

	@Autowired
	private AdbookService abService;
	
	@Autowired
	private AdminService aService;
	
	@RequestMapping("adbookList.ab")
	public String adbookList(@RequestParam(value="page", required=false) Integer page,
							 @RequestParam(value="selectCategory", required=false) String selectCategory, 
							 @RequestParam(value="selectValue", required=false) String selectValue,
							 Model model) {
		ArrayList<Department> dList = aService.selectDepList();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, String> selectMap = new HashMap<String, String>();
		selectMap.put("selectCategory", selectCategory);
		selectMap.put("selectValue", selectValue);
		
		int listCount = abService.getAdbookListCount(selectMap);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Member> list = abService.selectAdbookList(pi, selectMap);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("selectCategory", selectCategory);
			model.addAttribute("selectValue", selectValue);
			model.addAttribute("dList", dList);
		} else {
			throw new AdbookException("사내 주소록 조회에 실패하였습니다.");
		}
		
		return "adbookList";
	}
	
	@RequestMapping("searchAdbook.ab")
	public String searchAdbook(@RequestParam("searchValue") String searchValue, @RequestParam(value="page", required=false) Integer page, Model model) {
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = abService.getSearchAdbookListCount(searchValue);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Member> list = abService.selectSearchAdbookList(pi, searchValue);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("searchValue", searchValue);
		}
		
		return "adbookList";
	}
	
	@RequestMapping("pAdbookList.ab")
	public String personalAdbookList(@RequestParam(value="page", required=false) Integer page, HttpServletRequest request, Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		String mNo = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		
		int listCount = abService.getpAdbookListCount(mNo);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Adbook> list = abService.selectpAdbookList(pi, mNo);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
		}
		
		return "personalAdbookList";
	}
	
	@RequestMapping("pAdbookInsertView.ab")
	public String pAdbookInsertView() {
		return "personalAdbookForm";
	}
	
	@RequestMapping("pAdbookInsert.ab")
	public String insertpAdbook(@ModelAttribute Adbook adbook, HttpServletRequest request) {
		String mNo = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		adbook.setAdWriter(mNo);
		
		int result = abService.insertpAdbook(adbook);
		
		if(result > 0) {
			return "redirect:pAdbookList.ab";
		} else {
			throw new AdbookException("개인 주소록 추가에 실패하였습니다.");
		}
	}
	
	@RequestMapping("pAdbookUpdateView.ab")
	public String pAdbookDetail(@RequestParam("adNo") int adNo, Model model) {
		Adbook adbook = abService.selectpAdbookDetail(adNo);
		
		if(adbook != null) {
			model.addAttribute("a", adbook);
		} else {
			throw new AdbookException("개인 주소록 상세 조회에 실패하였습니다.");
		}
		
		return "personalAdbookUpdateForm";
	}
	
	@RequestMapping("pAdbookUpdate.ab")
	public String updatepAdbook(@ModelAttribute Adbook adbook) {
		int result = abService.updatepAdbook(adbook);
		
		if(result > 0) {
			return "redirect:pAdbookList.ab";
		} else {
			throw new AdbookException("개인 주소록 수정에 실패하였습니다.");
		}
	}
	
	@RequestMapping("pAdbookDelete.ab")
	public String deletepAdbook(@RequestParam("checked") int[] checked) {
		int result = abService.deletepAdbook(checked);
		
		if(result < checked.length) {
			throw new AdbookException("개인 주소록 삭제에 실패하였습니다.");
		}

		return "redirect:pAdbookList.ab";
	}
	
	@RequestMapping("checkpAdDup.ab")
	@ResponseBody
	public int checkpAdDup(@RequestParam("phone") String phone, @RequestParam("email") String email,
						   @RequestParam(value="adNo", required=false) String adNo, HttpServletRequest request) {
		HashMap<String, String> checkMap = new HashMap<String, String>();
		checkMap.put("phone", phone);
		checkMap.put("email", email);
		checkMap.put("adNo", adNo);
		
		String adWriter = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		checkMap.put("adWriter", adWriter);
		
		int count = abService.checkpAdDup(checkMap);
		
		return count;
	}
	
	@RequestMapping("searchpAdbook.ab")
	public String searchpAdbook(@RequestParam("searchValue") String searchValue, @RequestParam(value="page", required=false) Integer page,
								HttpServletRequest request, Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		String adWriter = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		
		HashMap<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("adWriter", adWriter);
		searchMap.put("searchValue", searchValue);
		
		int listCount = abService.getSearchpAdbookListCount(searchMap);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Adbook> list = abService.selectSearchpAdbookList(pi, searchMap);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("searchValue", searchValue);
		} else {
			throw new AdbookException("개인 주소록 검색에 실패하였습니다.");
		}
		
		return "personalAdbookList";
	}
}
