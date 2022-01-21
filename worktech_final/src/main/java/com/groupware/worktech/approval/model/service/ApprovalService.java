package com.groupware.worktech.approval.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.approval.model.dao.ApprovalDAO;
import com.groupware.worktech.approval.model.vo.Approval;
import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.common.PageInfo;

@Service("AppService")
public class ApprovalService {
	
	@Autowired
	private ApprovalDAO AppDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Approval> selectMainList(String mNo) {
		return AppDAO.selectMainList(sqlSession, mNo);
	}
	
	public ArrayList<Approval> selectWaitList(PageInfo pi, String mNo) {
		return AppDAO.selectWaitList(sqlSession, pi, mNo);
	}

	public ArrayList<Approval> selectProgressList(PageInfo pi, String mNo) {
		return AppDAO.selectProgressList(sqlSession, pi, mNo);
	}

	public ArrayList<Approval> selectCompleteList(PageInfo pi, String mNo) {
		return AppDAO.selectCompleteList(sqlSession, pi, mNo);
	}

	public int getListCountWait() {
		return AppDAO.getListCountWait(sqlSession);
	}

	public int getListCountProgress() {
		return AppDAO.getListCountProgress(sqlSession);
	}

	public int getListCountComplete() {
		return AppDAO.getListCountComplete(sqlSession);
	}

	public int insertApproval(Approval app) {
		int result = AppDAO.insertApproval(sqlSession, app);
		
		if(result > 0 && !app.getFileList().isEmpty()) {
			for(int i = 0; i < app.getFileList().size(); i++) {
				result += AppDAO.insertApprovalFile(sqlSession, app.getFileList().get(i));
			}
		}
		return result;
	}

	public Approval selectApproval(int appNo) {		
		return AppDAO.selectApproval(sqlSession, appNo);
	}


	public int deleteForm(int formNo) {
		return AppDAO.deleteForm(sqlSession, formNo);
	}

	public int updateApproval(Approval app) {
		int result = AppDAO.updateApproval(sqlSession, app);
		
		if(result > 0 && app.getFileList() != null) {
			for(int i = 0; i < app.getFileList().size(); i++) {
				result += AppDAO.updateApprovalFile(sqlSession, app.getFileList().get(i));
			}
		}
			
		return result;
	}

	public int ApprovalApp(int appNo) {
		return AppDAO.ApprovalApp(sqlSession, appNo);
	}

	public int ApprovalReturn(int appNo) {
		return AppDAO.ApprovalReturn(sqlSession, appNo);
	}

	public int deleteApproval(int appNo) {
		return AppDAO.deleteApproval(sqlSession, appNo);
	}




}
