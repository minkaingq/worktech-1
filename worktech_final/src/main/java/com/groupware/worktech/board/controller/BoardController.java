package com.groupware.worktech.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.groupware.worktech.alarm.model.service.AlarmService;
import com.groupware.worktech.board.model.exception.BoardException;
import com.groupware.worktech.board.model.service.BoardService;
import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.board.model.vo.BoardFile;
import com.groupware.worktech.board.model.vo.Category;
import com.groupware.worktech.board.model.vo.Reply;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.common.Pagination;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private AlarmService alService;
	
	@RequestMapping("commonList.bo")
	public String commonBoardList(@RequestParam(value="page", required=false) Integer page, @RequestParam(value="category", required=false) Integer category, Model model) {
		ArrayList<Category> cList = bService.selectAllCategory();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = 0;
		if(category != null) {
			listCount = bService.getCategoryListCount(category);
		} else {
			listCount = bService.getListCount("COMMON");
		}
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Board> list = bService.selectCommonList(pi, category);
		
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("category", category);
			model.addAttribute("cList", cList);
		} else {
			throw new BoardException("일반 게시판 전체 조회에 실패하였습니다.");
		}
		
		return "commonBoardList";
	}
	
	@RequestMapping("cinsertView.bo")
	public String commonBoardInsertView() {
		return "commonBoardInsertForm";
	}
	
	@RequestMapping("cinsert.bo")
	public String insertCommonBoard(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile[] uploadFile, HttpServletRequest request) {
		ArrayList<BoardFile> fileList = new ArrayList<BoardFile>();
		
		if(uploadFile != null && !uploadFile[0].isEmpty()) {
			for(int i = 0; i < uploadFile.length; i++) {
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
		
		int result = bService.insertCommonBoard(b);
		
		if(result > 0) {
			return "redirect:commonList.bo";
		} else {
			throw new BoardException("게시글 등록에 실패하였습니다.");
		}
		
	}

	public HashMap<String, String> saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/buploadFiles";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originalFileName = file.getOriginalFilename();
		String renameFileName = randomStr(2) + sdf.format(new Date(System.currentTimeMillis())) + randomStr(3) + "." + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		
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
		int leftLimit = 48;
		int rightLimit = 122;
		int targetStringLength = length;
		Random random = new Random();
		
		String generatedString = random.ints(leftLimit, rightLimit + 1)
								 .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
								 .limit(targetStringLength)
								 .collect(StringBuilder::new,  StringBuilder::appendCodePoint, StringBuilder::append)
								 .toString();
		return generatedString;
	}
	
	@RequestMapping("cdetail.bo")
	public String commonBoardDetail(@RequestParam("bNo") int bNo, @RequestParam(value="page", required=false) Integer page, 
									@RequestParam(value="category", required=false) Integer category, 
									@RequestParam(value="upd", required=false) String upd, 
									@RequestParam(value="searchCategory", required=false) String searchCategory,
									@RequestParam(value="searchValue", required=false) String searchValue, Model model) {
		Board b = bService.selectCommonBoard(bNo, upd);
		
		if(b != null) {
			model.addAttribute("b", b);
			model.addAttribute("page", page);
			model.addAttribute("category", category);
			model.addAttribute("searchCategory", searchCategory);
			model.addAttribute("searchValue", searchValue);
		} else {
			throw new BoardException("게시글 상세 조회에 실패하였습니다.");
		}
		
		return "commonBoardDetail";
	}
	
	@RequestMapping("cupdateView.bo")
	public String commonBoardUpdateView(@RequestParam("bNo") int bNo, 
										@RequestParam("upd") String upd, Model model) {
		Board b = bService.selectCommonBoard(bNo, upd);
		
		model.addAttribute("b", b);
		
		return "commonBoardUpdate";
	}

	
	@Transactional
	@RequestMapping("cupdate.bo")
	public String commonBoardUpdate(@ModelAttribute Board b, @RequestParam("reloadFile") MultipartFile[] reloadFile,
									@RequestParam(value = "fNo", required = false) ArrayList<Integer> fNoes, 
									@RequestParam("upd") String upd,
									@RequestParam("flag") int flag, HttpServletRequest request, Model model) {
		
		ArrayList<BoardFile> oldFileList = bService.selectCommonBoard(b.getbNo(), upd).getFileList();

		// 저장되어 있는 파일 삭제
		if (fNoes != null && !fNoes.isEmpty()) {

			for (int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getfNo();

				if (!fNoes.contains(fNo)) {
					deleteFile(oldFileList.get(i).getfRname(), request);

					int result = bService.deleteNoticeFile(fNo);

					if (result <= 0) {
						throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
					}
				}
			}
		} else if (flag == 1) {
			for (int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getfNo();

				deleteFile(oldFileList.get(i).getfRname(), request);

				int result = bService.deleteNoticeFile(fNo);

				if (result <= 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
				}
			}
		}

		// 새로 추가한 파일 등록
		ArrayList<BoardFile> fileList = null;

		if (reloadFile != null && !reloadFile[0].getOriginalFilename().trim().equals("")) {
			fileList = new ArrayList<BoardFile>();
			for (int i = 0; i < reloadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(reloadFile[i], request);

				if (fileInfo.get("renameFileName") != null) {
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

		int result = bService.updateCommonBoard(b);

		int length = 0;

		if (fileList != null) {
			length = fileList.size();
		}

		if (result >= length + 1) {
			return "redirect:cdetail.bo?bNo=" + b.getbNo() + "&upd=Y";
		} else {
			throw new BoardException("게시글 수정에 실패하였습니다.");
		}
	}
	
	public void deleteFile(String fRname, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/buploadFiles";
		
		File f = new File(savePath + "/" + fRname);
		
		if(f.exists()) {
			f.delete();
		}
	}
	
	@RequestMapping("commonDelete.bo")
	public String deleteCommonBoard(@RequestParam("bNo") int bNo, Model model) {
		Board b = bService.selectCommonBoard(bNo, "Y");
		
		ArrayList<BoardFile> fileList = b.getFileList();
		
		if(fileList != null && fileList.get(0).getfRname() != null) {
			for(int i = 0; i < fileList.size(); i++) {
				int result = bService.deleteNoticeFile(fileList.get(i).getfNo());
				
				if(result < 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
				}
			}
		}
		
		int result = bService.deleteNotice(bNo);
		
		if(result > 0) {
			return "redirect:commonList.bo";
		} else {
			throw new BoardException("게시글 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("searchCommon.bo")
	public String searchCommonBoard(@RequestParam("searchCategory") String searchCategory, @RequestParam("searchValue") String searchValue, 
									@RequestParam(value="page", required=false) Integer page, @RequestParam(value="category", required=false) Integer category, Model model) {
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, Object> searchCountMap = new HashMap<String, Object>();
		searchCountMap.put("searchCategory", searchCategory);
		searchCountMap.put("searchValue", searchValue);
		searchCountMap.put("category", category);
		
		int listCount = bService.getCommonSearchListCount(searchCountMap);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		HashMap<String, Object> searchListMap = new HashMap<String, Object>();
		searchListMap.put("pi", pi);
		searchListMap.put("searchCategory", searchCategory);
		searchListMap.put("searchValue", searchValue);
		searchListMap.put("category", category);
		
		ArrayList<Board> list = bService.selectCommonSearchList(searchListMap);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("searchCategory", searchCategory);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("pi", pi);
			model.addAttribute("category", category);
		}
		
		return "commonBoardList";
	}
	
	@RequestMapping("addCommonReply.bo")
	@ResponseBody
	public int insertCommonReply(@ModelAttribute Reply r) {
		int result = bService.insertCommonReply(r);
		int alarmNo = alService.selectAlarmNo() - 1;
		
		if(result > 0) {
			return alarmNo;
		} else {
			throw new BoardException("댓글 등록에 실패하였습니다.");
		}
	}
	
	@RequestMapping("commonReplyList.bo")
	public void commonReplyList(@RequestParam("bNo") int bNo, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<Reply> list = bService.selectCommonReplyList(bNo);
		
		GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
		
		Gson gson = gb.create();
		
		try {
			gson.toJson(list, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("deleteCommonReply.bo")
	@ResponseBody
	public String deleteCommonReply(@RequestParam("bNo") int bNo, @RequestParam("rNo") int rNo) {
		int result = bService.deleteCommonReply(rNo);
		
		if(result > 0) {
			return "success";
		} else {
			throw new BoardException("댓글 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("commonTopList.bo")
	public void commonTopList(HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<Board> list = bService.selectCommonTopList();
		
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
	
	// summernote 이미지 삽입
	@RequestMapping("uploadSummernoteImageFile")
	@ResponseBody
	public String SummerNoteImageFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		JSONObject jsonObject = new JSONObject();
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/fileupload/";
		
		String originalFileName = file.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File folder = new File(fileRoot);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = file.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.put("url", "resources/fileupload/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.put("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.put("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject.toString();
	}

	
	
	
	
	
	
	
	
	
	// 화상회의 게시판
		@RequestMapping("zoom.bo")
	public /*String*/ModelAndView zBoardList(@RequestParam(value="page", required=false) Integer page, /*Model model*/ ModelAndView mv) {	
			
			int currentPage = 1;
			if(page != null) {
				currentPage = page;
			}
			
			int listCount = bService.getZListCount();
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			ArrayList<Board> list = bService.selectZList(pi);
			
			if(list != null) {
				mv.addObject("pi", pi);
				mv.addObject("list", list);
				mv.setViewName("zoomListView");
				
			} else {
				throw new BoardException("게시글 전체 조회에 실패하였습니다.");
			}
			
			return mv;
		}
		
		@RequestMapping("zinsertView.bo")
		public String insertView() {
			return "zoomInsertForm";
		}
		
		@RequestMapping("zinsert.bo")
		public String zoomInsert(@ModelAttribute Board b) {
			System.out.println("b"+b);
			
			int result = bService.zoomInsert(b);
			
			if(result>0) {
				return "redirect:zoom.bo";
			} else {
				throw new BoardException("게시글 등록 실패");
			}
		}
		
		@RequestMapping("zoomdetail.bo")
		public String zoomDetail(@RequestParam("bNo") int bNo, @RequestParam(value="page", required=false) Integer page, 
							Model model) {
			Board b = bService.selectZoom(bNo);

			if(b != null) {
			model.addAttribute("b", b);
			model.addAttribute("page", page);
			} else {
			throw new BoardException("게시글 상세 조회에 실패하였습니다.");
			}
			
			return "zoomDetail";
			} 
		
		@RequestMapping("zoomDelete.bo")
		public String zoomDelete(@RequestParam("bNo") int bNo, Model model) {
			Board b = bService.selectZoom(bNo);
			
			int result = bService.zoomDelete(bNo);
			
			if(result > 0) {
				return "redirect:zoom.bo";
			} else {
				throw new BoardException("게시글 삭제에 실패하였습니다.");
			}
		}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	// 익명 게시판

	
	@RequestMapping("ainsertView.bo")
	public String anonymBoardInsertView() {
		return "anonyBoardInsertForm";
	}
	
	@RequestMapping("anonyList.bo")
	public String anonymBoardList(@RequestParam(value="page", required = false) Integer page, @RequestParam(value="boardLimit", required = false) Integer boardLimit,
												Model model) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = bService.getListCount("ANONY");
		PageInfo pi = null;
		
		if(boardLimit != null) {
			pi = Pagination.getPageInfo(currentPage, listCount, boardLimit);
			model.addAttribute("boardLimit", boardLimit);
		} else {
			pi = Pagination.getPageInfo(currentPage, listCount);
		}
		ArrayList<Board> list = bService.selectAnonyList(pi);
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			
		} else {
			throw new BoardException("익명 게시판 목록 조회에 실패하였습니다.");
		}
	
		return "anonyBoardList";
	}
	
	@RequestMapping("ainsert.bo")
	public String anonymBoardInsert(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile[] uploadFile,
									MultipartHttpServletRequest request) {
		
		ArrayList<BoardFile> fileList = new ArrayList<BoardFile>();
		
		if(uploadFile != null && !uploadFile[0].isEmpty()) {
			for(int i = 0; i < uploadFile.length; i++) {
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
		
		int result = bService.insertAnonyBoard(b);
		
		if(result > 0) {
			return "redirect:anonyList.bo";
		} else {
			throw new BoardException("게시글 등록에 실패하였습니다.");
		}
		}

	@RequestMapping("adetail.bo")
	public String anonyBoardDetail(@RequestParam("bNo") int bNo, @RequestParam(value="page", required=false) Integer page,
			@RequestParam(value="upd", required=false) String upd,
			@RequestParam(value="searchCategory", required=false) String searchCategory,
			@RequestParam(value="searchValue", required=false) String searchValue, Model model) {
		
		Board b = bService.selectAnonyBoard(bNo, upd);
		
		if(b != null) {
			model.addAttribute("b", b);
			model.addAttribute("page", page);
			model.addAttribute("searchCategory", searchCategory);
			model.addAttribute("searchValue", searchValue);
		} else {
			throw new BoardException("게시글 상세 조회에 실패하였습니다.");
		}
		
		return "anonyBoardDetail";
	}
	
	@RequestMapping("aupdateView.bo")
	public String anonyBoardUpdate(@RequestParam("bNo") int bNo, @RequestParam("upd") String upd, Model model) {
	
		Board b = bService.selectAnonyBoard(bNo, upd);
		
		model.addAttribute("b", b);
		
		return "anonyBoardUpdate";
	}
	
	@Transactional
	@RequestMapping("aupdate.bo")
	public String anonyBoardUpdate(@ModelAttribute Board b, @RequestParam("reloadFile") MultipartFile[] reloadFile,
			@RequestParam(value = "fNo", required = false) ArrayList<Integer> fNoes, @RequestParam("upd") String upd,
			@RequestParam("flag") int flag, HttpServletRequest request, Model model) {
		
		ArrayList<BoardFile> oldFileList = bService.selectAnonyBoard(b.getbNo(), upd).getFileList();

		// 저장되어 있는 파일 삭제
		if (fNoes != null && !fNoes.isEmpty()) {

			for (int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getfNo();

				if (!fNoes.contains(fNo)) {
					deleteFile(oldFileList.get(i).getfRname(), request);

					int result = bService.deleteNoticeFile(fNo);

					if (result <= 0) {
						throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
					}
				}
			}
		} else if (flag == 1) {
			for (int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getfNo();

				deleteFile(oldFileList.get(i).getfRname(), request);

				int result = bService.deleteNoticeFile(fNo);

				if (result <= 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
				}
			}
		}

		// 새로 추가한 파일 등록
		ArrayList<BoardFile> fileList = null;

		if (reloadFile != null && !reloadFile[0].getOriginalFilename().trim().equals("")) {
			fileList = new ArrayList<BoardFile>();
			for (int i = 0; i < reloadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(reloadFile[i], request);

				if (fileInfo.get("renameFileName") != null) {
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

		int result = bService.updateAnonyBoard(b);

		int length = 0;

		if (fileList != null) {
			length = fileList.size();
		}

		if (result >= length + 1) {
			return "redirect:adetail.bo?bNo=" + b.getbNo() + "&upd=Y";
		} else {
			throw new BoardException("게시글 수정에 실패하였습니다.");
		}
		
	}
	
	@RequestMapping("anonyDelete.bo") 
	public String deleteAnonyBoard(@RequestParam("bNo") int bNo, Model model) {
		Board b = bService.selectAnonyBoard(bNo, "Y");
				
				ArrayList<BoardFile> fileList = b.getFileList();
				
				if(fileList != null && fileList.get(0).getfRname() != null) {
					for(int i = 0; i < fileList.size(); i++) {
						int result = bService.deleteNoticeFile(fileList.get(i).getfNo());
						
						if(result < 0) {
							throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
						}
					}
				}
				
				int result = bService.deleteAnony(bNo);
				
				if(result > 0) {
					return "redirect:anonyList.bo";
				} else {
					throw new BoardException("게시글 삭제에 실패하였습니다.");
				}
	}
	
	@RequestMapping("addAnonyReply.bo")
	@ResponseBody
	public int insertAnonyReply(@ModelAttribute Reply r) {
		int result = bService.insertAnonyReply(r);
		int alarmNo = alService.selectAlarmNo() - 1;
				
				if(result > 0) {
					return alarmNo;
				} else {
					throw new BoardException("댓글 등록에 실패하였습니다.");
			}
	
	}
	
	@RequestMapping("searchAnony.bo")
	public String searchAnonyBoard(@RequestParam("searchCategory") String searchCategory, @RequestParam("searchValue") String searchValue, 
									@RequestParam(value="page", required=false) Integer page, Model model) {
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, Object> searchCountMap = new HashMap<String, Object>();
		searchCountMap.put("searchCategory", searchCategory);
		searchCountMap.put("searchValue", searchValue);
		
		int listCount = bService.getAnonySearchListCount(searchCountMap);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		HashMap<String, Object> searchListMap = new HashMap<String, Object>();
		searchListMap.put("pi", pi);
		searchListMap.put("searchCategory", searchCategory);
		searchListMap.put("searchValue", searchValue);
		
		ArrayList<Board> list = bService.selectAnonySearchList(searchListMap);
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("searchCategory", searchCategory);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("pi", pi);
		}
		
		return "anonyBoardList";
		
	}
	
}
