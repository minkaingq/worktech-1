package com.groupware.worktech.commut.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.groupware.worktech.commut.model.exception.CommutException;
import com.groupware.worktech.commut.model.service.CommutService;
import com.groupware.worktech.commut.model.vo.Commut;
import com.groupware.worktech.commut.model.vo.QRCode;
import com.groupware.worktech.commut.qrutil.QrUtil;
import com.groupware.worktech.member.model.vo.Member;

@SessionAttributes("co")
@Controller
public class CommutController {
	
	@Autowired
	private CommutService coService; 
	
	@RequestMapping("qrMake.co")
	public String qrqode(HttpServletRequest request, HttpSession session, Model model) {
		
		String id = ((Member)session.getAttribute("loginUser")).getmNo();
		
		String url = "gowork.co?mNo="+id;
		int width = 150;
		int height = 150;
		
		// 어디에 저장할 건지 위치 설정
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/qrcode";
		
		String file_name = id+".png";
		String file_path = savePath + "/" + file_name;
		
		QrUtil.makeQR(url, width, height, savePath, file_name);
		
		QRCode qr = new QRCode(0, file_name, file_path, id);
		
		int result = coService.insertQRCode(qr);
		
		if(result > 0) {
			QRCode newQR = coService.getinfo(id);
			if(newQR != null) {
				model.addAttribute("qr", newQR);
			}
			return "redirect:home.do";
		} else {
			throw new CommutException("QRCode 저장에 실패하였습니다.");
		}
		

		
	}
	
	@RequestMapping("qrcode.co")
	public String checkQRCode() {
		return "commut";
	}
	
	@RequestMapping("qrSelect.co")
	public String selectQRCode(HttpServletRequest request, HttpSession session, Model model) {
		String m_no = ((Member)session.getAttribute("loginUser")).getmNo();
		
		QRCode qr = new QRCode();
		qr.setM_no(m_no);
		
		qr = coService.selectQr(qr);
		
//		System.out.println(qr);
		
		if(qr != null) {
			model.addAttribute("QRCode", qr);	
		} else {
			throw new CommutException("QRCode 불러오기에 실패하였습니다.");
		}
		
		return "qrcode";
	}
	
	@RequestMapping("gowork.co")
	public String goWork(@RequestParam("mNo") String mNo, Model model) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		String today = sdf.format(new Date(System.currentTimeMillis()));

			Timestamp goWork = Timestamp.valueOf(today);
			
			Commut c = new Commut(0, null, goWork, mNo);
			
			int result = coService.insertGoWork(c);

			if(result > 0) {
				Commut co = coService.selectGowork(mNo);
				System.out.println(co);
				model.addAttribute("co", co);
				return "redirect:home.do";
			} else {
				throw new CommutException("출근 기록에 실패하였습니다.");
			}

		
	}
	
	@RequestMapping("leavework.co")
	public String leaveWork(HttpServletRequest request, HttpSession session, Model model) {
		
		String mNo = ((Member)session.getAttribute("loginUser")).getmNo();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		String today = sdf.format(new Date(System.currentTimeMillis()));

			Timestamp leaveWork = Timestamp.valueOf(today);
			
			Commut c = new Commut(leaveWork, mNo);
			
			int result = coService.updateLeaveWork(c);
			
			if(result > 0) {
				Commut co = coService.selectGowork(mNo);
				model.addAttribute("co", co);
				return "redirect:home.do";	
			} else {
				throw new CommutException("퇴근 기록에 실패하였습니다.");
			}
			
	}
		
}
