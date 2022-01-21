package com.groupware.worktech.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.approval.model.exception.ApprovalException;
import com.groupware.worktech.approval.model.service.ApprovalService;
import com.groupware.worktech.approval.model.vo.Approval;
import com.groupware.worktech.approval.model.vo.Form;
import com.groupware.worktech.board.model.exception.BoardException;
import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.board.model.vo.BoardFile;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.common.Pagination;
import com.groupware.worktech.member.model.vo.Member;

@Controller
public class ApprovalController {
	
	@Autowired
	private ApprovalService AppService;

	@RequestMapping("approvalmain.ap")
	public ModelAndView approvalList(HttpServletRequest request, ModelAndView mv) {
		
		String mNo = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		
		ArrayList<Approval> list = AppService.selectMainList(mNo);
		
		
		if(list != null) {
			mv.addObject("list", list);
			mv.setViewName("approvalmain");
		} else {
			throw new ApprovalException("전자 결재 메인페이지 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	
	@RequestMapping("approvalwait.ap")
	public ModelAndView approvalWait(@RequestParam(value="page", required = false) Integer page, HttpServletRequest request, ModelAndView mv) {
		
		String mNo = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
				
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = AppService.getListCountWait();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);	
		
		ArrayList<Approval> list = AppService.selectWaitList(pi, mNo);
		
		
		if(list != null) {
			mv.addObject("pi", pi);
			mv.addObject("list", list);
			mv.setViewName("approvalWait");
		} else {
			throw new ApprovalException("결제 대기함 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("approvalprogress.ap")
	public ModelAndView approvalProgress(@RequestParam(value="page", required = false) Integer page, HttpServletRequest request, ModelAndView mv) {
		
		String mNo = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = AppService.getListCountProgress();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);		
		ArrayList<Approval> list = AppService.selectProgressList(pi, mNo);
		
		
		if(list != null) {
			mv.addObject("pi", pi);
			mv.addObject("list", list);
			mv.setViewName("approvalProgress");
		} else {
			throw new ApprovalException("결제 대기함 조회에 실패하였습니다.");
		}

		return mv;
	}
	
	@RequestMapping("approvalcomplete.ap")
	public ModelAndView approvalComplete(@RequestParam(value="page", required = false) Integer page, HttpServletRequest request, ModelAndView mv) {
		
		String mNo = ((Member)request.getSession().getAttribute("loginUser")).getmNo();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = AppService.getListCountComplete();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);		
		ArrayList<Approval> list = AppService.selectCompleteList(pi, mNo);
		
		
		if(list != null) {
			mv.addObject("pi", pi);
			mv.addObject("list", list);
			mv.setViewName("approvalComplete");
		} else {
			throw new ApprovalException("결제 대기함 조회에 실패하였습니다.");
		}

		return mv;
	}
	
	@RequestMapping("approvalwrite.ap")
	public String approvalWrite() {
		return "approvalWrite";
	}
	
	@RequestMapping("appinsert.ap")
	public String insertApproval(@ModelAttribute Approval app, @RequestParam("uploadAppFile") MultipartFile[] uploadFile, HttpServletRequest request) {
		ArrayList<Form> fileList = new ArrayList<Form>();
		
		if(uploadFile != null && !uploadFile[0].isEmpty()) {
			for(int i = 0; i < uploadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(uploadFile[i], request);
				
				if(fileInfo.get("renameFileName") != null) {
					Form f = new Form();
					f.setFormName(uploadFile[i].getOriginalFilename());
					f.setFormRname(fileInfo.get("renameFileName"));
					f.setFormURL(fileInfo.get("renamePath"));
					f.setAppNo(app.getAppNo());
					
					fileList.add(f);
				}
			}
		}
		
		app.setFileList(fileList);
		
		int result = AppService.insertApproval(app);
		
		if(result > 0) {
			return "redirect:approvalmain.ap";
		} else {
			throw new BoardException("새 결재 등록에 실패하였습니다.");
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
	
	@RequestMapping("appdetail.ap")
	public String ApprvoalDetail(@RequestParam("appNo") int appNo, @RequestParam(value="page", required=false) Integer page, Model model) {
		Approval app = AppService.selectApproval(appNo);
		
		
		if(app != null) {
			model.addAttribute("app", app);
			model.addAttribute("page", page);
		} else {
			throw new BoardException("결재 상세 조회에 실패하였습니다.");
		}
		
		return "approvalDetail";
	}
	
	@RequestMapping("appupdateView.ap")
	public String ApprovalUpdateView(@RequestParam("appNo") int appNo, Model model) {
		Approval app = AppService.selectApproval(appNo);
		
		model.addAttribute("app", app);
		
		return "approvalUpdate";
	}
	
	@Transactional
	@RequestMapping("appupdate.ap")
	public String approvalUpdate(@ModelAttribute Approval app, @RequestParam("reloadAppFile") MultipartFile[] reloadFile,
									@RequestParam(value = "formNo", required = false) ArrayList<Integer> formNoes,
									@RequestParam("flag") int flag, HttpServletRequest request, Model model) {
		
		ArrayList<Form> oldFileList = AppService.selectApproval(app.getAppNo()).getFileList();

		// 저장되어 있는 파일 삭제
		if (formNoes != null && !formNoes.isEmpty()) {

			for (int i = 0; i < oldFileList.size(); i++) {
				int formNo = oldFileList.get(i).getFormNo();

				if (!formNoes.contains(formNo)) {
					deleteFile(oldFileList.get(i).getFormRname(), request);

					int result = AppService.deleteForm(formNo);

					if (result <= 0) {
						throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
					}
				}

			}
		} else if (flag == 1) {
			for (int i = 0; i < oldFileList.size(); i++) {
				int fNo = oldFileList.get(i).getFormNo();

				deleteFile(oldFileList.get(i).getFormRname(), request);

				int result = AppService.deleteForm(fNo);

				if (result <= 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
				}
			}
		}

		// 새로 추가한 파일 등록
		ArrayList<Form> fileList = null;

		if (reloadFile != null && !reloadFile[0].getOriginalFilename().trim().equals("")) {
			fileList = new ArrayList<Form>();
			for (int i = 0; i < reloadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(reloadFile[i], request);

				if (fileInfo.get("renameFileName") != null) {
					Form form = new Form();
					form.setFormName(reloadFile[i].getOriginalFilename());
					form.setFormRname(fileInfo.get("renameFileName"));
					form.setFormURL(fileInfo.get("renamePath"));
					form.setAppNo(app.getAppNo());

					fileList.add(form);
				}
			}
		}

		app.setFileList(fileList);

		int result = AppService.updateApproval(app);

		int length = 0;

		if (fileList != null) {
			length = fileList.size();
		}

		if (result >= length + 1) {
			return "redirect:appdetail.ap?appNo=" + app.getAppNo() ;
		} else {
			throw new BoardException("결재 수정에 실패하였습니다.");
		}
	}	
	
	public void deleteFile(String FormRname, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/buploadFiles";
		
		File f = new File(savePath + "/" + FormRname);
		
		if(f.exists()) {
			f.delete();
		}
	}
	
	
	@RequestMapping("approvalApp.ap")
	public String ApprovalApp(@RequestParam("appNo") int appNo, Model model) {
		int result = AppService.ApprovalApp(appNo);
		
		if(result > 0) {
			return "redirect:approvalwait.ap";
		} else {
			throw new BoardException("결재 승인에 실패하였습니다.");
		}
	}
	
	@RequestMapping("approvalReturn.ap")
	public String ApprovalReturn(@RequestParam("appNo") int appNo, Model model) {
		int result = AppService.ApprovalReturn(appNo);
		
		if(result > 0) {
			return "redirect:approvalwait.ap";
		} else {
			throw new BoardException("결재 반려에 실패하였습니다.");
		}
	}
	
	@RequestMapping("approvalDelete.ap")
	public String deleteApproval(@RequestParam("appNo") int appNo, Model model) {
		Approval app = AppService.selectApproval(appNo);
		
		ArrayList<Form> fileList = app.getFileList();
		
		if(fileList != null && fileList.get(0).getFormRname() != null) {
			for(int i = 0; i < fileList.size(); i++) {
				int result = AppService.deleteForm(fileList.get(i).getFormNo());
				
				if(result < 0) {
					throw new BoardException("첨부 파일 삭제에 실패하였습니다.");
				}
			}
		}
		
		
		int result = AppService.deleteApproval(appNo);;
		
		if(result > 0) {
			return "redirect:approvalprogress.ap";
		} else {
			throw new BoardException("게시글 삭제에 실패하였습니다.");
		}
	}	

}