package com.groupware.worktech.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.groupware.worktech.admin.model.exception.AdminException;
import com.groupware.worktech.admin.model.service.AdminService;
import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.admin.model.vo.RvProduct;
import com.groupware.worktech.admin.model.vo.RvRange;
import com.groupware.worktech.board.model.exception.BoardException;
import com.groupware.worktech.board.model.service.BoardService;
import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.board.model.vo.BoardFile;
import com.groupware.worktech.chat.model.exception.ChatException;
import com.groupware.worktech.chat.model.service.ChatService;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.common.Pagination;

@Controller
public class AdminController {

	@Autowired
	private AdminService aService;
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private ChatService cService;
	
	// 관리자 공지사항 게시판 부분 시작
	@RequestMapping("noticeList.ad")
	public String noticeList(@RequestParam(value="page", required=false) Integer page, @RequestParam(value="boardLimit", required = false) Integer boardLimit,
							 Model model) {
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = bService.getListCount("NOTICE");
		PageInfo pi = null;
		
		if(boardLimit != null) {
			pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
			model.addAttribute("boardLimit", boardLimit);
		} else {
			pi = Pagination.getPageInfo(currentPage, listCount);
		}
		ArrayList<Board> list = bService.selectNoticeList(pi);
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			
		} else {
			throw new BoardException("공지사항 목록 조회에 실패하였습니다.");
		}
		
		return "adminNoticeList";
	}
	
	@RequestMapping("ninsertView.ad")
	public String noticeInsertView() {
		return "adminNoticeInsertForm";
	}
	
	@RequestMapping("ninsert.ad")
	public String insertNotice(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile[] uploadFile, 
								MultipartHttpServletRequest request) {
		
		ArrayList<BoardFile> fileList = new ArrayList<BoardFile>();

		if(uploadFile != null && !uploadFile[0].isEmpty()) {
			
			for(int i=0; i<uploadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(uploadFile[i], request); 
				
				if(fileInfo.get("renameFileName") != null) {
					BoardFile f = new BoardFile();
					f.setfName(uploadFile[i].getOriginalFilename());
					f.setfRname(fileInfo.get("renameFileName"));
					f.setfURL(fileInfo.get("renamePath"));
					f.setRefBNo(b.getbNo());
					
					fileList.add(f);

				}
			}
		}
		
		b.setFileList(fileList);
		
		int result = bService.insertNotice(b);
		
		if(result >= b.getFileList().size() + 1) {
			return "redirect:noticeList.ad";
		} else {
			throw new BoardException("공지글 등록에 실패하였습니다.");
		}
		
	}
	
	public HashMap<String, String> saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		// buploadFiles 폴더에 저장
		String savePath = root + "/buploadFiles";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originFileName = file.getOriginalFilename();
		String renameFileName = randomStr(2) + sdf.format(new Date(System.currentTimeMillis())) + randomStr(3) + "." 
								+ originFileName.substring(originFileName.lastIndexOf(".") + 1);
		
		String renamePath = folder + "/" + renameFileName;
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String, String> fileInfo = new HashMap<String, String>();
		fileInfo.put("renameFileName", renameFileName);
		fileInfo.put("renamePath", renamePath);
		
		return fileInfo;
	}
	
	public String randomStr(int length) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = length;
		Random random = new Random();

		String generatedString = random.ints(leftLimit,rightLimit + 1)
		  .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		  .limit(targetStringLength)
		  .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		  .toString();

		return generatedString;
	}
	
	@RequestMapping("ndetail.ad")
	public String noticeDetail(@RequestParam("page") int page, @RequestParam("bNo") int bNo,
			@RequestParam(value = "upd", required = false) String upd, @RequestParam(value = "boardLimit", required = false) Integer boardLimit, 
			@RequestParam(value ="searchCondition", required = false) String condition, @RequestParam(value = "searchValue", required = false) String value, Model model) {
		Board b = bService.selectNotice(bNo, upd);

		model.addAttribute("b", b).addAttribute("page", page);
		
		if(boardLimit != null) {
			model.addAttribute("boardLimit", boardLimit);
		}
		
		if(value != null) {
			model.addAttribute("searchCondition", condition).addAttribute("searchValue", value);
		}
		
		return "adminNoticeDetail";
	}
	
	@RequestMapping("nupdateView.ad")
	public String updateNoticeView(@RequestParam("page") int page, @RequestParam("bNo") int bNo, @RequestParam(value = "upd", required = false) String upd, Model model) {
		Board b = bService.selectNotice(bNo, upd);
		
		model.addAttribute("b", b).addAttribute("page", page); 
		
		return "adminNoticeUpdate";
	}
	
	@Transactional
	@RequestMapping("nupdate.ad")
	public String updateNotice(@ModelAttribute Board b, @RequestParam("reloadFile") MultipartFile[] reloadFile,
							   @RequestParam(value="fNo",required=false) ArrayList<Integer> fNoes, @RequestParam("page") int page, 
							   @RequestParam("flag") int flag, HttpServletRequest request, Model model) {
		ArrayList<BoardFile> oldFileList = bService.selectNotice(b.getbNo(), "Y").getFileList();

		// 저장되어 있는 파일 삭제
		if(fNoes != null && !fNoes.isEmpty()) { 
			
			for(int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getfNo();
				
				if(!fNoes.contains(fNo)) {
					deleteFile(oldFileList.get(i).getfRname(), request);
					
					int result = bService.deleteNoticeFile(fNo);
					
					if(result <= 0) {
						throw new BoardException("첨부 파일 삭제에 실패하였습니다."); 
					}
				}
				
			}
		} else if(flag == 1) {
			for(int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getfNo();
				
				deleteFile(oldFileList.get(i).getfRname(), request);
				
				int result = bService.deleteNoticeFile(fNo);
				
				if(result <= 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다."); 
				}
			}
		}
		
		// 새로 추가한 파일 등록
		ArrayList<BoardFile> fileList = null;
		
		if(reloadFile != null && !reloadFile[0].getOriginalFilename().trim().equals("")) {
			fileList = new ArrayList<BoardFile>();
			for(int i=0; i<reloadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(reloadFile[i], request); 
				
				if(fileInfo.get("renameFileName") != null) {
					BoardFile f = new BoardFile();
					f.setfName(reloadFile[i].getOriginalFilename());
					f.setfRname(fileInfo.get("renameFileName"));
					f.setfURL(fileInfo.get("renamePath"));
					f.setRefBNo(b.getbNo());
					
					fileList.add(f);
				}
			}
		}
		
		b.setFileList(fileList);
		
		int result = bService.updateNotice(b);
		
		int length = 0;
		
		if(fileList != null) {
			length = fileList.size();
		} 
		
		if(result >= length + 1) {
			model.addAttribute("page", page);
			return "redirect:ndetail.ad?bNo=" + b.getbNo() + "&upd=Y";
		} else {
			throw new BoardException("공지글 수정에 실패하였습니다.");
		}
	}
	
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/buploadFiles";
		
		File f = new File(savePath + "/" + fileName);
		
		if(f.exists()) {
			f.delete();
		}
	}
	
	@RequestMapping("noticeDelete.ad")
	public String deleteBoard(@RequestParam("bNo") int bNo, HttpServletRequest request) {
		Board b = bService.selectNotice(bNo, "Y");
		
		ArrayList<BoardFile> bfList = b.getFileList();
		if(bfList != null && bfList.get(0).getfName() != null) { // 첨부파일이 존재하면 첨부파일 삭제
			for(BoardFile bf : bfList) {
				deleteFile(bf.getfRname(), request);
				
				int result = bService.deleteNoticeFile(bf.getfNo());
				
				if(result <= 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다."); 
				}
			}
		}
		
		int result = bService.deleteNotice(bNo);
		
		if(result > 0) {
			return "redirect:noticeList.ad";
		} else {
			throw new BoardException("공지글 삭제에 실패하였습니다."); 
		}
	}
	
	
//	ajax를 이용한 파일 삭제
//	@RequestMapping("deleteNoticeFile.ad")
//	@ResponseBody
//	public String deleteNoticeFile(@RequestParam("fNo") int fNo, HttpServletRequest request) {
//		BoardFile bf = bService.selectFile(fNo);
//		
//		String root = request.getSession().getServletContext().getRealPath("resources");
//		String savePath = root + "/buploadFiles";
//		
//		File f = new File(savePath + "/" + bf.getfRname());
//		
//		if(f.exists()) {
//			f.delete();
//		}
//		
//		int result = bService.deleteNoticeFile(fNo);
//		
//		if(result > 0) {
//			return "success";
//		} else {
//			throw new BoardException("첨부 파일 삭제에 실패하였습니다."); 
//		}
//	}
	
	@RequestMapping("searchNotice.ad")
	public String searchNotice(@RequestParam("searchCondition") String condition, @RequestParam("searchValue") String value, 
							   @RequestParam(value="page", required=false) Integer page, @RequestParam(value="boardLimit", required = false) Integer boardLimit,
							   Model model) {
		HashMap<String, String> search = new HashMap<>();
		search.put("condition", condition);
		search.put("value", value);
		search.put("type", "NOTICE");
		
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = bService.getNoticeSearchListCount(search);
		PageInfo pi = null;

		if(boardLimit != null) {
			pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
			model.addAttribute("boardLimit", boardLimit);
		} else {
			pi = Pagination.getPageInfo(currentPage, listCount);
		}
		
		ArrayList<Board> list = bService.selectNoticeSearchList(pi, search);
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("searchCondition", condition);
			model.addAttribute("searchValue", value);
		} else {
			throw new BoardException("공지사항 검색 목록 조회에 실패하였습니다.");
		}
		
		return "adminNoticeList";
	}
	// 관리자 공지사항 게시판 부분 끝
	
	// 관리자 예약 자산 추가 부분 시작
	@RequestMapping("addRvView.ad")
	public String addRvView(Model model) {
		ArrayList<Department> list = aService.getDepartmentList();

		if (list != null) {
			model.addAttribute("list", list);
		}

		return "adminRvAddForm";
	}

	@RequestMapping("rvProductList.ad")
	public String rvpList(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "boardLimit", required = false) Integer boardLimit, Model model) {
		int currentPage = 1;

		if (page != null) {
			currentPage = page;
		}

		int listCount = aService.getRvListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<RvProduct> list = aService.selectRvProductList(pi);
		if (list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);

		} else {
			throw new AdminException("예약 자산 목록 조회에 실패하였습니다.");
		}

		return "adminRvProductList";
	}
	
	@RequestMapping("addRvProduct.ad")
	public String addRvProduct(@ModelAttribute RvProduct rp, @RequestParam(value = "department", required = false) int[] dNoes) {
		ArrayList<RvRange> rrList = new ArrayList<RvRange>();

		for (int i = 0; i < dNoes.length; i++) {
			RvRange r = new RvRange();
			r.setPdDNo(dNoes[i]);
			rrList.add(r);
		}

		rp.setRvRange(rrList);

		int result = aService.insertRvProduct(rp);

		if (result >= rrList.size() + 1) {
			return "redirect:rvProductList.ad";
		} else {
			throw new AdminException("예약 자산 등록에 실패하였습니다.");
		}
	}
	
	@RequestMapping("rvpdetail.ad")
	public String rvDetail(@RequestParam("page") int page, @RequestParam("pdNo") int pdNo, Model model) {
		RvProduct rp = aService.selectRvProduct(pdNo);
		
		if(rp != null) {
			model.addAttribute("rp", rp);
			model.addAttribute("page", page);
			return "adminRvDetail";
		} else {
			throw new AdminException("예약 자산 상세 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("rvupdateView.ad")
	public String updateRvPView(@RequestParam("page") int page, @RequestParam("pdNo") int pdNo, Model model) {
		RvProduct rp = aService.selectRvProduct(pdNo);
		ArrayList<Department> list = aService.getDepartmentList();

		model.addAttribute("rp", rp).addAttribute("page", page).addAttribute("list", list);

		return "adminRvUpdate";
	}
	
	@Transactional
	@RequestMapping("rvupdate.ad")
	public String updateRvProduct(@ModelAttribute RvProduct rp, @RequestParam(value = "department", required = false) ArrayList<Integer> editRrList,
								  @RequestParam("page") int page) {
		int result = 0;
		
		result = aService.updateRvProduct(rp);
		
		if(result > 0) {
		
			ArrayList<Integer> originRrList = aService.getOriginRvRangeList(rp.getPdNo());
			ArrayList<Integer> insertRrNoList = new ArrayList<Integer>(); // 받아온 목록 - DB에 저장된 목록 (차집합)
			insertRrNoList.addAll(editRrList); 
			ArrayList<Integer> deleteRrNoList = new ArrayList<Integer>(); // DB에 저장된 목록 - 받아온 목록 (차집합)
			deleteRrNoList.addAll(originRrList);
			
			for(int i : originRrList) {
				for(int j : editRrList) {
					if(i == j) {
						insertRrNoList.remove((Integer)j);
						deleteRrNoList.remove((Integer)j);
					}
				}
			}
			
			ArrayList<RvRange> insertRrList = new ArrayList<RvRange>();
			ArrayList<RvRange> deleteRrList = new ArrayList<RvRange>();
			
			for(int pdDNo : insertRrNoList) {
				RvRange rr = new RvRange();
				rr.setPdDNo(pdDNo);
				rr.setPdNo(rp.getPdNo());
				
				insertRrList.add(rr);
			}
			
			for(int pdDNo : deleteRrNoList) {
				RvRange rr = new RvRange();
				rr.setPdDNo(pdDNo);
				rr.setPdNo(rp.getPdNo());
				
				deleteRrList.add(rr);
			}
	
			result += aService.updateRvRange(insertRrList);
			result += aService.deleteRvRange(deleteRrList);
			
			if (result >= insertRrList.size() + deleteRrList.size() + 1) {
				return "redirect:rvpdetail.ad?pdNo=" + rp.getPdNo() + "&page=" + page;
			} 
		} 
		
		throw new AdminException("예약 자산 수정에 실패하였습니다.");
	}
	
	@RequestMapping("rvProductDelete.ad")
	public String rvpDelete(@RequestParam("pdNo") int pdNo) {
		int result = aService.deleteRvProduct(pdNo); // status만 변경하므로 range는 삭제하지 않음
		
		if(result > 0) {
			return "redirect:rvProductList.ad";
		} else {
			throw new AdminException("예약 자산 삭제에 실패하였습니다.");
		}
	}
	
	// 관리자 예약 자산 추가 부분 끝
	
	@RequestMapping("mainPage.do")
	public String mainView() {
		return "main";
	}
	
	// 부서 목록 페이지로 이동
	@RequestMapping("dList.ad")
	public String departmentList(Model model) {
		// 트리
		ArrayList<Department> list = cService.getChatDepartmentList();
		
		// 부서 목록
		ArrayList<Department> dList = aService.selectDepList();
		// 부서 구성원 수	
		ArrayList<Integer> countList = aService.depCountList();
					
		if(list != null) {
			JSONArray jArr = new JSONArray();
			
			for(Department d : list) {
				JSONObject jo = new JSONObject();
				jo.put("id", d.getdNo());
				jo.put("pId", d.getdParent());
				jo.put("name", d.getdName());
				
				jArr.add(jo);
			}	
			
			if(dList != null) {
				model.addAttribute("list",dList);
				model.addAttribute("countList", countList);
			} else {
				throw new ChatException("부서 목록 조회에 실패하였습니다.");
			}
			
		model.addAttribute("jsonArray", jArr);
			
		} else {
			throw new ChatException("부서 트리 조회에 실패하였습니다.");
		}
		return "adminDepartment";
	}

	
	// 부서 등록 페이지로 이동 => department list 같이 보내기
	@RequestMapping("addDep.ad")
	public String insertDepView(Model model) {
		
		ArrayList<Department> list = aService.selectDepList();
		
		if(list != null) {
			model.addAttribute("list", list);
		}
		
		return "adminInsertDep";
	}
	
	// 부서 등록
	@RequestMapping("dInsert.ad")
	public String insertDepartment(@ModelAttribute Department d, Model model) {
			
		System.out.println(d);
		
		// 등록
		int result = aService.insertDepartment(d);
		
		// 부서 목록
		ArrayList<Department> list = aService.selectDepList();
		
		// 부서 구성원 수	
		ArrayList<Integer> countList = aService.depCountList();
			
		if( result > 0 ) {
			model.addAttribute("list", list);
			model.addAttribute("countList", countList);
			return "adminDepartment";
		} else {
			throw new AdminException("부서 등록에 실패했습니다.");
		}
			
	}
	
	
	// 부서 이름 중복 확인 (ajax)
	@RequestMapping("dupDName.ad")
	public void duplicatedDName(@RequestParam("dName") String dName, HttpServletResponse response) {
			
		String result = aService.duplicateDName(dName) == 0 ? "NoDup" : "Dup";
		
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
		
	
	// 부서 삭제
	@RequestMapping("deleteDep.ad")
	@ResponseBody
	public void deleteDepartment(@RequestParam("dNo") String dNo) {
		
		System.out.println(dNo);
		
		int result = aService.deleteDep(dNo);
		
//		return null;
	}
	
	// 관리자 메인 공지사항 리스트
	@RequestMapping("noticeRecentList.ad")
	public void noticeRecentList(HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<Board> list = bService.selectNoticeRecentList();
		GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
		Gson gson = gb.create();
		
		if(list != null) {
			try {
				gson.toJson(list, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	// 부서 트리
//	@ResponseBody
//	@RequestMapping(value="deTree.ad", produces="application/json; charet=UTF-8")	
//	public List<Code> findCodeByGroup(@RequestParam("codeGroupId") String codeGroupId) {
	
	@RequestMapping("deTree.ad")
	public String findCodeByGroup(Model model) {
		// 트리
		ArrayList<Department> list = cService.getChatDepartmentList();
				
		if(list != null) {
			JSONArray jArr = new JSONArray();
					
			for(Department d : list) {
				JSONObject jo = new JSONObject();
				jo.put("id", d.getdNo());
				jo.put("pId", d.getdParent());
				jo.put("name", d.getdName());
				
				jArr.add(jo);
			}	
					
			model.addAttribute("jsonArray", jArr);	
			} else {
				throw new ChatException("부서 트리 조회에 실패하였습니다.");
			}
		return "departmentTree";
	
	}
	
	
	
	
	
}
