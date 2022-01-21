package com.groupware.worktech.mail.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.common.Pagination;
import com.groupware.worktech.member.model.service.MemberService;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.mail.model.exception.MailException;
import com.groupware.worktech.mail.model.service.MailService;
import com.groupware.worktech.mail.model.vo.Mail;
import com.groupware.worktech.mail.model.vo.MailFile;
import com.groupware.worktech.mail.model.vo.MailSR;

@Controller
public class MailController {
	
	@Autowired
	private MailService mailService;

	@Autowired
	private MemberService mService;
	
	// 전체 메일함 
	@RequestMapping("alllist.mail")
	public ModelAndView alllist(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();
		int listCount = mailService.getAllListCount(mNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mailService.selectAllList(pi, mNo);

		int count = mailService.selectCountNotRead(mNo);  // 읽지 않은 메일 개수가져오기

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("allmaillist");
		} else {
			throw new MailException("전체메일함 조회에 실패했습니다.");
		}

		return mv;
	}
	
	// 메일 쓰기 페이지
	@RequestMapping("send.mail")
	public ModelAndView mailSendForm(ModelAndView mv, HttpSession session) {
		
		String mNo = ((Member)session.getAttribute("loginUser")).getmNo();
		
		int count = mailService.selectCountNotRead(mNo);
		
		mv.addObject("count", count);
		mv.setViewName("mailsend");
		
		return mv;
	}

	@RequestMapping("read.mail")
	public String mailReadForm() {
		return "mailread";
	}
	
	// 메일 검색
	@RequestMapping("search.mail")
	public ModelAndView searchMail(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam("command") String command, @RequestParam("searchValue") String searchValue,
			HttpSession session, ModelAndView mv) {
		
		System.out.println("메일 검색 커맨드 : " + command);

		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("searchValue", searchValue);
		map.put("command", command);
		map.put("mNo", mNo);

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mailService.getSearchListCount(map);
		System.out.println("listcount : " + listCount);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mailService.searchList(pi, map);
		int count = mailService.selectCountNotRead(mNo); // 읽지 않은 메일 개수 가져오기
		System.out.println("count : " + count);
		System.out.println("list  :" + list);

		mv.addObject("list", list).addObject("page", page).addObject("count", count).addObject("pi", pi)
				.addObject("searchValue", searchValue);
		mv.setViewName(command);

		return mv;
	}

	@RequestMapping("readmail.mail")
	public ModelAndView selectMail(@RequestParam("mId") int id,
			@RequestParam(value = "page", required = false) Integer page, ModelAndView mv, HttpSession session) {

		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("mNo", mNo);

		System.out.println(id);
		System.out.println(mNo);

		Mail mail = mailService.selectMail(map);
		System.out.println(mail);
		// R_date가 null이면 읽은 시간 추가(읽음 표시)
		ArrayList<MailSR> list = mail.getMailSRList();

		if (list.get(0).getRDate() == null) {
//			System.out.println("업데이트");
			int result = mailService.updateRDate(map);
		}

		int count = mailService.selectCountNotRead(mNo);
		String mId = getMId(mail.getReceiveEmp());
		Member m = mailService.getMId(mId); // 받는 사람 이름 구하는 메소드

		System.out.println(m);

		if (mail != null) {
			if (m != null) {
				mail.setReceiverName(m.getName());
				System.out.println(mail);
			}
			mv.addObject("mail", mail);
			mv.addObject("page", page);
			mv.addObject("count", count);
			mv.setViewName("mailread");
		} else {
			throw new MailException("메일 상세보기에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("readtemp.mail")
	public ModelAndView selectTempMail(@RequestParam("mId") int id,
			@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) {
		Mail mail = mailService.selectTempMail(id);
		System.out.println("selectTempMail : " + mail);

		if (mail != null) {
			mv.addObject("mail", mail);
			mv.addObject("page", page);
			mv.setViewName("tempread");
		} else {
			throw new MailException("메일 상세보기에 실패했습니다.");
		}
		return mv;
	}

	@RequestMapping("updateFavorites.mail") // 메일 즐겨찾기 추가
	@ResponseBody
	public void updateFavorites(@RequestParam("mailNo") int mailNo, HttpSession session, HttpServletResponse response)
			throws IOException {
		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mNo", mNo);
		map.put("id", mailNo);

		Mail mail = mailService.selectMail(map);
		System.out.println(mail);

		if (mail.getMailSRList().get(0).getFavorites() == null) {
			map.put("favorites", "Y");
		} else {
			if (mail.getMailSRList().get(0).getFavorites().equals("N") || mail.getMailSRList().get(0).getFavorites() == "N") {
				map.put("favorites", "Y");
			} else {
				map.put("favorites", "N");
			}
		}

		// mail의 favorites가 null이거나 n 이면 y, n이면 y로
		int result = mailService.updateFavorites(map);

		if (result > 0) {
			response.getWriter().append("success");
		}
	}
	
	// 중요메일함
	@RequestMapping("favoriteslist.mail")
	public ModelAndView FavoriteList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();
		int listCount = mailService.getFavoritesListCount(mNo);
		System.out.println("favorites listcount : " + listCount);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mailService.selectFavoritesList(pi, mNo);

		int count = mailService.selectCountNotRead(mNo); // 읽지 않은 메일 개수 가져오기

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("favoritesmaillist");
		} else {
			throw new MailException("즐겨찾기 조회에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("sendlist.mail")
	public ModelAndView sendList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();
		int listCount = mailService.getsendListCount(mNo);
		int count = mailService.selectCountNotRead(mNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mailService.selectSendList(pi, mNo);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("sendmaillist");
		} else {
			throw new MailException("보낸메일함 조회에 실패했습니다.");
		}

		return mv;
	}
	
	@RequestMapping("checkReadTime.mail")
	public ModelAndView checkReadTime(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		if (request.getSession().getAttribute("loginUser") == null) {
			throw new MailException("로그인이 필요합니다.");
		}
		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mailService.getsendListCount(mNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		ArrayList<Mail> list = mailService.selectSendList(pi, mNo);
		ArrayList<Mail> rList = mailService.selectCheckList(mNo);
		for(Mail m : list) {
			for(int i = 0; i < rList.size(); i++) {
				if(rList.get(i).getMailNo() == m.getMailNo()) {
					m.setReceiverRTime(rList.get(i).getMailSRList().get(0).getRDate());
				}
			}
		}
		int count = mailService.selectCountNotRead(mNo);
		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("checkReadTime");
		} else {
			throw new MailException("받은 메일함 조회에 실패했습니다.");
		}
		return mv;
	}
	

	@RequestMapping("receivelist.mail") // 받은 메일함 조회
	public ModelAndView receivemaillist(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		if (request.getSession().getAttribute("loginUser") == null) {
			throw new MailException("로그인이 필요합니다.");
		}

		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mailService.getReceiveListCount(mNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mailService.selectReceiveList(pi, mNo);

		int count = mailService.selectCountNotRead(mNo);

		System.out.println(list);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("receivemaillist");
		} else {
			throw new MailException("받은 메일함 조회에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("templist.mail")
	public ModelAndView tempList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();

		if (mNo == null) {
			throw new MailException("로그인이 필요합니다.");
		}

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mailService.getTempListCount(mNo);
		int count = mailService.selectCountNotRead(mNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mailService.selectTempList(pi, mNo);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("tempmaillist");
		} else {
			throw new MailException("임시보관함 조회에 실패했습니다.");
		}

		return mv;
	}

	@RequestMapping("searchemp.mail") // 메일 보내기 사원 자동완성
	@ResponseBody
	public void searchEmp(HttpServletResponse response, @RequestParam("keyword") String keyword)
			throws JsonIOException, IOException {
		response.setContentType("application/json; charset=UTF-8");

		ArrayList<Member> list = mailService.searchEmp(keyword);

		Gson gson = new Gson();
		gson.toJson(list, response.getWriter());
	}

	
	@RequestMapping("deletemail.mail") // 메일 삭제 (커맨드 패턴 적용)
	public String deleteMail(@RequestParam("check") int[] check, @RequestParam("command") String command,
			HttpSession session) {
		System.out.println("command :" + command);

		String mNo = ((Member) session.getAttribute("loginUser")).getmNo();

		int result = 0;

		for (int i = 0; i < check.length; i++) {
			int mailNo = check[i];
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mNo", mNo);
			System.out.println("mNo : " + mNo);
			map.put("mailNo", mailNo);
			System.out.println("mailNo : " + mailNo);
			map.put("command", command);
			result += mailService.deleteMail(map);
		}

		System.out.println(result);

		if (result > 0) {
			switch (command) {
			case "templist":
				return "redirect:templist.mail";
			case "sendlist":
				return "redirect:sendlist.mail";
			case "receivelist":
				return "redirect:receivelist.mail";
			case "favoriteslist":
				return "redirect:favoriteslist.mail";
			case "deletelist":
				return "redirect:deletelist.mail";
			}
		} else {
			throw new MailException("메일 삭제에 실패했습니다.");
		}
		return null;
	}
	
	// 휴지통 메일
	@RequestMapping("deletelist.mail")
	public ModelAndView deleteList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv,
			HttpServletRequest request) {

		String mNo = ((Member) request.getSession().getAttribute("loginUser")).getmNo();

		if (mNo == null) {
			throw new MailException("로그인이 필요합니다.");
		}

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		int boardLimit = 15;
		int listCount = mailService.getDeleteListCount(mNo);
		int count = mailService.selectCountNotRead(mNo);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
		System.out.println(Pagination.getPageInfo(currentPage, listCount, boardLimit));

		ArrayList<Mail> list = mailService.selectDeleteList(pi, mNo);

		System.out.println(list);

		if (list != null) {
			mv.addObject("list", list).addObject("pi", pi).addObject("count", count);
			mv.setViewName("deletemaillist");
		} else {
			throw new MailException("임시보관함 조회에 실패했습니다.");
		}

		return mv;
	}
	
	
	
	@RequestMapping(value = "tmpInsert.mail")
	public String tempInsert(@ModelAttribute Mail mail, MultipartHttpServletRequest mtpRequest) throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();

		Member e = (Member) mtpRequest.getSession().getAttribute("loginUser");
		String mNo = e.getmNo();

		mail.setMNo(mNo);

		System.out.println(mail);
		int result1 = mailService.insertTempMail(mail);

		if (result1 <= 0) { // 메일 등록 취소 시 예외처리
			throw new MailException("메일 저장에 실패했습니다.");
		}

		if (!uploadFile.isEmpty()) { // 받아온 파일이 있을 때만 MAIL과 MAIL_FILE CURRVAL로 연결
			System.out.println("업로드된 파일 수 : " + fileList.size());
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath);

				mailFileList.add(mailfile);

				System.out.println(mailfile);
			}
			int result2 = mailService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴

			if (result2 <= 0) {
				throw new MailException("파일 저장에 실패했습니다.");
			}
		}

		return "redirect:templist.mail";
	}
	
	
	
	
	@RequestMapping("mailInsert.mail")
	public String mailInsert(@ModelAttribute Mail mail, MultipartHttpServletRequest mtpRequest) throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();
		int result1 = 0;
		Member e = (Member) mtpRequest.getSession().getAttribute("loginUser");
		String mNo = e.getmNo();
		if(mail.getMailNo() != 0) {
			boolean flag = true;
			mail.setMNo(mNo);
			mail.setMailFileList(mailService.selectTempMail(mail.getMailNo()).getMailFileList());
			for(MailFile mf : mail.getMailFileList()) {
				mf.setMailNo(0);
				if(mf.getmOriginalName() == null) {
					flag = false;
				}
			}
			mailService.insertMail(mail);
			if(flag) {
				mailService.insertMailFile(mail.getMailFileList());
			}
		} else {
			mail.setMNo(mNo);
			mailService.insertMail(mail);
		}
		if (!uploadFile.isEmpty()) { 
			System.out.println("업로드된 파일 수 : " + fileList.size());
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath);

				mailFileList.add(mailfile);
			}
			int result2 = mailService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴

			if (result2 <= 0) {
				throw new MailException("파일 저장에 실패했습니다.");
			}
		}

		int result3 = mailService.insertMailSRReceiver(getMId(mail.getReceiveEmp()));
		int result4 = mailService.insertMailSRSender(mail.getmNo()); // 보낸 메일함에 저장

		return "redirect:sendlist.mail";
	}
	
	
	// 메일 타입
	private boolean isType(Mail mail) {
		String id = mail.getReceiveEmp();
		int index = id.lastIndexOf('@');

		System.out.println(id.substring(index + 1));

		if (id.substring(index + 1).equals("workhome.com")) {
			return true; // true일 경우 사내메일
		} else {
			return false; // 외부메일
		}
	}

	
	@RequestMapping(value = "tmpUpdate.mail")
	public String updateTemp(@ModelAttribute Mail mail, MultipartHttpServletRequest mtpRequest, ModelAndView mv)
			throws MailException {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "/mailUploadFiles";
		List<MultipartFile> fileList = mtpRequest.getFiles("uploadFile");
		MultipartFile uploadFile = mtpRequest.getFile("uploadFile");
		List<MailFile> mailFileList = new ArrayList<MailFile>();
		Member e = (Member) mtpRequest.getSession().getAttribute("loginUser");
		String mNo = e.getmNo();

		mail.setMNo(mNo);

		System.out.println(mail);
		int result1 = mailService.updateMail(mail);

		if (result1 <= 0) {
			throw new MailException("메일 임시 저장에 실패했습니다.");
		}

		if (!uploadFile.isEmpty()) { // 받아온 파일이 있을 때만 MAIL과 MAIL_FILE CURRVAL로 연결
			System.out.println("업로드된 파일 수 : " + fileList.size());
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				String mChangeName = saveFile(mtpRequest, mf);

				MailFile mailfile = new MailFile(mf.getOriginalFilename(), mChangeName, filePath, mail.getMailNo());
				System.out.println(mailfile);
				mailFileList.add(mailfile);
			}
			int result2 = mailService.insertMailFile(mailFileList); // 파일 삽입 결과 리턴

			if (result2 <= 0) {
				throw new MailException("파일 저장에 실패했습니다.");
			}
		}

		return "redirect:templist.mail";
	}

	// ajax 
	@RequestMapping("fileDeleteAjax.mail")
	@ResponseBody
	public String deleteFileAjax(@RequestParam("mFileNo") int mFileNo, HttpServletRequest request) {

		MailFile mF = mailService.selectMailFile(mFileNo);
		int result = mailService.deleteMailFile(mFileNo);

		if (result > 0) {
			deleteFile(request, mF);
			return "success";
		} else {
			throw new MailException("파일 삭제에 실패했습니다.");
		}
	}

	// 파일 저장용 메소드
	public String saveFile(MultipartHttpServletRequest mtpRequest, MultipartFile file) {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/mailUploadFiles";

		File folder = new File(savePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		String originFileName = file.getOriginalFilename(); // 파일의 원래 이름 가져오기
		System.out.println(originFileName);
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "."
				+ originFileName.substring(originFileName.lastIndexOf(".") + 1); // 현재 시간에 대한 밀리세컨즈를 가져온다.
		String renamePath = folder + "\\" + renameFileName;

		try {
			file.transferTo(new File(renamePath));
		} catch (Exception e) {
			System.out.println("파일 전송 에러");
			e.printStackTrace();
		}

		
		return renameFileName;
	}

	// 파일 삭제용 메소드
	public void deleteFile(MultipartHttpServletRequest mtpRequest, MailFile mf) {
		String root = mtpRequest.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/mailUploadFiles";

		File f = new File(savePath + "/" + mf.getmChangeName());
		if (f.exists()) { // buploadFiles에 renameFileName이 존재하면 지우기
			f.delete();
		}
	}

	public void deleteFile(HttpServletRequest request, MailFile mf) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/mailUploadFiles";

		File f = new File(savePath + "/" + mf.getmChangeName());
		if (f.exists()) { // buploadFiles에 renameFileName이 존재하면 지우기
			f.delete();
		}
	}

	
	private String getMId(String email) {
		return email.substring(0, email.lastIndexOf('@'));
	}
}
