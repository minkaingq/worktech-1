package com.groupware.worktech.member.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.groupware.worktech.adbook.model.exception.AdbookException;
import com.groupware.worktech.adbook.model.service.AdbookService;
import com.groupware.worktech.admin.model.service.AdminService;
import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.common.Pagination;
import com.groupware.worktech.commut.model.exception.CommutException;
import com.groupware.worktech.commut.model.service.CommutService;
import com.groupware.worktech.commut.model.vo.Commut;
import com.groupware.worktech.commut.model.vo.QRCode;
import com.groupware.worktech.member.model.exception.MemberException;
import com.groupware.worktech.member.model.service.MemberService;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.member.model.vo.Profile;

@SessionAttributes({"loginUser", "qr", "list",  "co"})
@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService mService; 
	
	@Autowired
	private AdminService aService;
	
	@Autowired
	private CommutService coService;
	
	@Autowired
	private AdbookService abService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	
	// 로그인(암호화) --> DB에 Spring 콘솔에 입력된 비밀번호(암호화)를 넣고 저장 후 로그인!
	@RequestMapping(value="login.me", method=RequestMethod.POST)
	public String login(Member m, Model model, HttpServletRequest request) {	
		
//		System.out.println(bcrypt.encode(m.getPwd()));
		
		Member loginMember = mService.memberLogin(m);
		
		if(loginMember != null) {
			if(bcrypt.matches(m.getPwd(), loginMember.getPwd())) {
				model.addAttribute("loginUser", loginMember);
				
				if(loginMember.getmGrade().equals("USER")) {
					QRCode qr = coService.getinfo(loginMember.getmNo());
					
					if(qr != null) {
						model.addAttribute("qr", qr);
					}
					
					ArrayList<Member> list = abService.selectAdbookMainList(loginMember.getmNo());
					
					if(list != null) {
						model.addAttribute("list", list);
					} else {
						throw new AdbookException("메인 사내 주소록 조회에 실패하였습니다.");
					}
					
					Commut co = coService.selectGowork(loginMember.getmNo());
					model.addAttribute("co", co);					
				}
				return "redirect:home.do";
			} 
		}
		
		model.addAttribute("msg", "아이디 또는 비밀번호를 확인하세요");
		return "../../../index";
	}
	
	//로그아웃
	@RequestMapping("logout.me")
	public String logout(SessionStatus session) {
		session.setComplete();
		
		return "redirect:index.jsp";
	}
	
	// 사원 등록페이지로 이동
	@RequestMapping("enrollView.me")
	public String enrollView(Model model, @ModelAttribute Department d) {
		
		// 부서 등록
		ArrayList<Department> list = aService.selectDepList();
				
		if(list != null) {
			model.addAttribute("list", list);
		}
		
		return "adminMemAddForm";
	}
	
	// 사원 등록 (& 비밀번호 암호화) → 사원목록 페이지로 이동
	@RequestMapping("minsert.me")
	public String insertMember(@ModelAttribute Member m,
								Model model, @RequestParam(value="page", required=false) Integer page) {
		// 비밀번호 : 등록한 이메일 앞자리
		String pwd = m.getEmail().substring(0, m.getEmail().indexOf("@"));
		m.setPwd(pwd);
	
		// 비밀번호 암호화 
		String encPwd = bcrypt.encode(m.getPwd());
		m.setPwd(encPwd); 
		
	//	System.out.println(m);
			
		int result = mService.insertMember(m);
		
		// 사원목록 페이지로 이동 : 페이징 처리
		// 페이징 처리
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int listCount = mService.getMemListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		// 사원 목록 : 관리자 제외
		ArrayList<Member> mList = mService.selectMemList(pi);
		// 총 사원의 수
		int memCount = mService.countMember();
		// 관리자
		ArrayList<Member> aList = mService.selectAdminList(pi);
		
		if(result > 0) {
			model.addAttribute("mList", mList);
			model.addAttribute("aList", aList);
			model.addAttribute("pi", pi);
			model.addAttribute("memCount", memCount);
		} else {
			throw new MemberException("사원 등록에 실패하였습니다.");
		}
		return "adminMemList";
	}
		
		
	// 사번 중복 확인
	@RequestMapping("dupId.me")
	public void duplicateId(@RequestParam("mNo") String mNo, HttpServletResponse response) {
			
		// 삼항연산자 사용 : 일치하면(중복되면) Dup / 일치하지 않으면(중복되지 않으면) NoDup
		String result = mService.duplicateMNo(mNo) == 0 ? "NoDup" : "Dup";
			
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}	

	// 사원목록 페이지로 이동 + 페이징
	@RequestMapping("mList.me")
	public String mListView(Model model, @RequestParam(value="page", required=false) Integer page) {
		
		// 페이징 처리
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = mService.getMemListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		// 사원 목록 : 관리자 제외
		ArrayList<Member> mList = mService.selectMemList(pi);
		// 총 사원의 수
		int memCount = mService.countMember();
		// 관리자
		ArrayList<Member> aList = mService.selectAdminList(pi);
		
		if(mList != null) {
			model.addAttribute("mList", mList);
			model.addAttribute("aList", aList);
			model.addAttribute("pi", pi);
			model.addAttribute("memCount", memCount);
		} else {
			throw new MemberException("사원 목록 조회에 실패하였습니다.");
		}
		return "adminMemList";
	}

	
	// member 검색
	@RequestMapping("searchMem.me")
	public String searchMember(@RequestParam("searchCondition") String condition,
							   @RequestParam("searchValue") String value,
							   @RequestParam(value="page", required=false) Integer page, Model model ) {
		
		// 검색 조건 :  searchCondition | 검색 내용 : searchValue
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("value", value);
		
		// 페이징 처리
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		// 기존 : 총 사원의 수
		int memCount = mService.countMember();
		
		// 검색한 사원의  수
		int listCount = mService.getSearchResultListCount(map);
		// 페이딩 처리 계산
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		// 검색 결과
		ArrayList<Member> mList = mService.selectSearchResultList(pi, map);
		
		if( mList != null ) {
			model.addAttribute("mList", mList);
			model.addAttribute("pi", pi);
			model.addAttribute("searchCondition", condition);
			model.addAttribute("searchValue", value);
			model.addAttribute("memCount", memCount);
		} else {
			throw new MemberException("사원 목록 검색에 실패하였습니다.");
		}
		
		return "adminMemList";
	}

	
	// 사원 삭제 (개별)
	@RequestMapping("mdelete.me")
	@ResponseBody
	public void deleteMember(@RequestParam("mNo") String mNo) {
		
		System.out.println(mNo);
		
		int result = mService.deleteMember(mNo);
		
	}

	
	// 사원 삭제(선택)
	@RequestMapping("selectDelete.me")
	@ResponseBody
	public void deleteSelectMember(@RequestParam(value="valueArr") String valueArr ) {

		// valueArr값 받아온것 확인
		System.out.println(valueArr);
		// 여러개의 값들이 하나의 String으로 들어옴 → split을 이용해서 나누기
		String[] selectList = valueArr.split(" ");
		for(int i = 0; i < selectList.length; i++) {
			int result = mService.deleteSelectMember(selectList[i]);
		}

	}

	
	// 사원정보 상세보기 페이지로 이동
	@RequestMapping("mdetail.me")
	public String detailMemView(@RequestParam("mNo") String mNo, @RequestParam("page") int page, Model model) {
		
		Member m = mService.selectMember(mNo);
		
		if(m != null) {
			model.addAttribute("member", m);
			model.addAttribute("page", page);
		} else {
			throw new MemberException("사원 정보 상세보기에 실패하였습니다.");
		}
		
		return "adminMemView";
	}
	
	// 사원정보 상세보기 페이지에서 사원 삭제
	@RequestMapping("delete.me")
	public String deleteDetailMember(@RequestParam("mNo" ) String mNo) {
		
//		System.out.println(mNo);
		
		int result = mService.deleteDetailMem(mNo);
		
		if(result > 0) {
			return "redirect:mList.me";
		} else {
			throw new MemberException("사원 삭제에 실패하였습니다.");
		}

	}
	
	// 관리자 사원 정보 수정 페이지로 이동
	@RequestMapping("adminUpdateMem.me")
	public String adminUpdateMemview(@RequestParam("mNo") String mNo, @RequestParam("page") int page, Model model){
		Member m = mService.selectMember(mNo);
		model.addAttribute("member", m).addAttribute("page", page);
		
		// 부서 목록
		ArrayList<Department> list = aService.selectDepList();
		if(list != null) {
			model.addAttribute("list", list);
		}
		
		return "adminUpdateMem";
	}
	
	
	// 관리자 : 사원 정보 수정 
	@RequestMapping("AdminUdateMem.me")
	public String adminUpdateMem(@ModelAttribute Member m, @RequestParam("page") int page, Model model) {
		int result = mService.adminUpdateMem(m);
		
		if(result > 0) {
			model.addAttribute("page", page);
		} else {
			throw new MemberException("사원 정보 수정에 실패하였습니다.");
		}
		return "redirect:mdetail.me?mNo=" + m.getmNo();
	}
	
	
	// 관리자 : 사원 비밀번호 수정페이지로 이동
	@RequestMapping("updateMemPwdView.me")
	public String updateMemberPwdView(@ModelAttribute Member m) {
		return "adminUpdateMemPwd";
	}
	
	
	// 관리자 비밀번호 페이지로 이동
	@RequestMapping("adminPwdView.me")
	public String adminPwdView(@RequestParam("adminMNo") String mNo, @RequestParam("adminName") String name, Model model) {
//		System.out.println(mNo);
//		System.out.println(name);
		
		model.addAttribute("mNo", mNo);
		model.addAttribute("name", name);
		return "adminUpdatePwd";
	}
	
	// 관리자 비밀번호 변경
	@RequestMapping("adminPwd.me")
	public String adminPwd(@RequestParam("pwd") String oldPwd, @RequestParam("newPwd") String Pwd, Model model) {
		// 비밀번호 받아오기
//		System.out.println(oldPwd); // 기존 비밀번호
//		System.out.println(Pwd); // 새로운 비밀번호 리스트
		String[] pwdList = Pwd.split(",");
		String newPwd = pwdList[1]; // 새로운 비밀번호
		
		// 아이디 받아오기 
		Member m = (Member)model.getAttribute("loginUser");
//		System.out.println(m); 
		Member dbMember = mService.memberLogin(m);
		
		int result = 0;
		
		if(bcrypt.matches(oldPwd, dbMember.getPwd())) {
			HashMap<String, String> map = new HashMap<String, String> ();
			map.put("mNo", m.getmNo());
			map.put("newPwd", bcrypt.encode(newPwd));
			
			result = mService.updatePassword(map);
		}
		
		if(result > 0) {
			return "redirect:mList.me";
		} else {
			throw new MemberException("비밀번호 수정에 실패하였습니다.");
		}
	}

	// 마이페이지로 이동
	@RequestMapping("myPage.me")
	public String myPageView() {
		return "mypage";
	}
	
	// 마이페이지 : 비밀번호 변경 페이지로 이동
	@RequestMapping("updatePwdView.me")
	public String myPagePwdView() {
		return "updatePwd";
	}

	
	// 관리자 비밀번호 변경
	@RequestMapping("updatePwd.me")
	public String memPwd(@RequestParam("pwd") String oldPwd, @RequestParam("newPwd") String Pwd, Model model) {
		// 비밀번호 받아오기
//		System.out.println(oldPwd); // 기존 비밀번호
//		System.out.println(Pwd); // 새로운 비밀번호 리스트
		String[] pwdList = Pwd.split(",");
		String newPwd = pwdList[1]; // 새로운 비밀번호
			
		// 아이디 받아오기 
		Member m = (Member)model.getAttribute("loginUser");
//		System.out.println(m); 
		Member dbMember = mService.memberLogin(m);
		
		int result = 0;
			
		if(bcrypt.matches(oldPwd, dbMember.getPwd())) {
			HashMap<String, String> map = new HashMap<String, String> ();
			map.put("mNo", m.getmNo());
			map.put("newPwd", bcrypt.encode(newPwd));
			
			result = mService.updatePassword(map);
		}
			
		if(result > 0) {
			return "redirect:myPage.me";
		} else {
			throw new MemberException("비밀번호 수정에 실패하였습니다.");
		}
	}
	
	// 내정보 수정 페이지로 이동
	@RequestMapping("detailMyPage.me")
	public String updateMyPageView() {
		return "updateMypage";
	}
	
	
	// 내 정보 수정
	@RequestMapping("mUpdate.me")
	public String updateMember(@ModelAttribute Member m, Model model,
								@RequestParam("post") String post, 
								@RequestParam("address1") String address1, @RequestParam("address2") String address2, @RequestParam("address3") String address3, 
								@RequestParam("year") int year, @RequestParam("month") int month, @RequestParam("date") int date, 
								@RequestParam("proImg") MultipartFile proImg, MultipartHttpServletRequest request) {
		
		/*------------------------------ 주소 ------------------------------*/
		m.setAddress(post + "/" + address1 + "/" + address2 + "/" + address3);
		
		/*------------------------------ 생년월일 ------------------------------*/
		Date birthDay = new Date(new GregorianCalendar(year, month-1, date).getTimeInMillis());
		m.setBirthDay(birthDay);
		
		/*------------------------------ 프로필 사진------------------------------*/
		Profile profile = new Profile();
		
		if( proImg != null && !proImg.isEmpty() ) {
		
			HashMap<String, String> profileInfo = saveFile(proImg, request); 
			
			if(profileInfo.get("renameFileName") != null) {
				profile.setpName(proImg.getOriginalFilename());
				profile.setpReName(profileInfo.get("renameFileName"));
				profile.setpUrl(profileInfo.get("renamePath"));
				profile.setmNo(m.getmNo());
				
				// 프로필 insert 및 update
				int result = mService.updateProfile(profile);
				if(result > 0) {
//					System.out.println("프로필 사진 등록 성공");
				} else {
					throw new MemberException("프로필 사진 등록에 실패하였습니다.");
				}
			}
			
		}
		// 프로필 사진 경로
		m.setProfile(profile);
		
		// 수정된 내용 확인
//		System.out.println(profile);
//		System.out.println(m);
		
		// 수정된 내용 저장
		int result  = mService.updateMemberInfo(m);
		if(result>0) {
			model.addAttribute("loginUser", m);
			return "redirect:myPage.me";
		} else {
			throw new MemberException("내 정보 수정에 실패하였습니다.");
		}

	}
	
	
	public HashMap<String, String> saveFile(MultipartFile file, HttpServletRequest request) {
		// 저장경로 : profileUploadFiles
		String root = request.getSession().getServletContext().getRealPath("resources"); // 작은 resources
		System.out.println(root);
		String savePath = root + "/profileUploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs(); 
		}
		
		// 이름 변경
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String pName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + pName.substring(pName.lastIndexOf(".") + 1); 
		
		String renamePath = folder + "/" + renameFileName;
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String, String> profileInfo = new HashMap<String, String>();
		profileInfo.put("renameFileName", renameFileName);
		profileInfo.put("renamePath", renamePath);
		
		return profileInfo;
		
	}
	
	
	// 임시비밀번호 페이지로 이동
	@RequestMapping("findPwdView.me")
	public String findPwdView() {
		return "findPwd";
	}

	// 임시 비밀번호 발급
	@RequestMapping("findPassword.me")
	public String findPwd(@RequestParam("mNo") String mNo, @RequestParam("mEmail") String mEmail) {
		// 사용자가 입력한 사번과 개인 이메일
//		System.out.println(mNo);
//		System.out.println(mEmail);
		
		// 해당 사원 정보 가져오기
		Member m = mService.selectmemEmail(mNo);
		String memEmail = m.getmEmail(); // 해당하는 사번의 개인 이메일
//		System.out.println(memEmail);
		
		String name = m.getName();  // 해당하는 사번의 이름
		
		// 이메일이 일치할 경우 : 임시비밀번호 발급
		if( mEmail.equals(memEmail)) { 
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			
//			System.out.println(pw); // 임시 비밀번호
			
			// 이메일 발송
			String receiver = memEmail; // 받는사람
			String title = "[ WORKTECH ] " + name +"님의  임시 비밀번호를 알려드립니다.";
			String content = "<div align='center' style='border:1px solid black; font-family:verdana'>"
					+ "<h3 style='color: blue;'>"
					+ name + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>"
					+ "<p>임시 비밀번호 : " + pw + "</p></div>";
			
			String host = "smtp.naver.com"; // 네이버에서 보내기(smtp.naver.com) | gmail에서 보내기 (smtp.gmail.com)
			String sender = " "; // 실제 보내는 사람의 유효한 메일 [ ※ test시 각자의 naver/gmail 계정을 추가하세요 ]
			String senderPwd= " "; // 그 메일의 실제 비밀번호  [ ※ test시 각자의 naver/gmail 계정의 비밀번호를 추가하세요 ]
			
			Properties prop = new Properties(); 
			prop.setProperty("mail.smtp.host", host);
			prop.setProperty("mail.smtp.auth", "true");
			prop.put("mail.smtp.starttls.enable","true");
			
			Session session = Session.getDefaultInstance(prop, new Authenticator() {
				// 익명 클래스 : 내부적으로 객체를 만들게끔하는것 (gui)
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					// 보내는 사람에 대해서 session을 만들어줌
					return new PasswordAuthentication(sender, senderPwd);
				}
			});
			
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(sender));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
				message.setSubject(title);
				message.setText(content, "UTF-8", "html");
				
				// 전송
				Transport.send(message);
				
//				System.out.println("메일 발송 성공");
			} catch (AddressException e) {
				e.printStackTrace();
//				System.out.println("메일 발송 실패");
			} catch (MessagingException e) {
				e.printStackTrace();
//				System.out.println("메일 발송 실패");
			}
			
			// 임시 비밀번호 암호화 후 저장
			String encPwd = bcrypt.encode(pw);
//			System.out.println(encPwd);
			m.setPwd(encPwd); 
			
			// 비밀 번호 update
			HashMap <String, String> map = new HashMap();
			map.put("mNo", mNo);
			map.put("encPwd", encPwd);
			
			int result = mService.updatePwd(map);
			
//			System.out.println(m);
			
		} else {
			throw new MemberException("개인 이메일이 일치하지 않습니다.");
		}
		
		return "redirect:/";
	}

	
	
	
	
	
	
	
	
	
	
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	// admin main ajax
	@RequestMapping("mListMain.me")
	public void mListMain(HttpServletResponse response) {
		
		// 메인 사원 목록 
		ArrayList<Member> mList = mService.selectMainMemList();
		
		if(mList != null) {
			
			response.setContentType("application/json; charset=UTF-8");
			
			GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
			
			Gson gson = gb.create();
			try {
				gson.toJson(mList, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} else {
			throw new MemberException("메인 화면 사원 목록 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("mGetMaitCount.me")
	public void mMainCount(HttpServletResponse response) {
		// 총 사원의 수
		int memCount = mService.countMember();
		
		try {
			response.getWriter().println(memCount);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}