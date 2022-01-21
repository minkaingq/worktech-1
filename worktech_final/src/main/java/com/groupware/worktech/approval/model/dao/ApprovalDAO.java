package com.groupware.worktech.approval.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.approval.model.vo.Approval;
import com.groupware.worktech.approval.model.vo.Form;
import com.groupware.worktech.common.PageInfo;

@Repository("AppDAO")
public class ApprovalDAO {

	public ArrayList<Approval> selectMainList(SqlSessionTemplate sqlSession, String mNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("approvalMapper.selectMainList", mNo);
	}


	public ArrayList<Approval> selectWaitList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectWaitList", mNo, rowBounds);
	}

	public ArrayList<Approval> selectProgressList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectProgressList", mNo, rowBounds);
	}

	public ArrayList<Approval> selectCompleteList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectCompleteList", mNo, rowBounds);
	}

	public int getListCountWait(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("approvalMapper.getListCountWait");
	}

	public int getListCountProgress(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("approvalMapper.getListCountProgress");
	}

	public int getListCountComplete(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("approvalMapper.getListCountComplete");
	}

	public int insertApproval(SqlSessionTemplate sqlSession, Approval app) {
		return sqlSession.insert("approvalMapper.insertApproval", app);
	}

	public int insertApprovalFile(SqlSessionTemplate sqlSession, Form form) {
		return sqlSession.insert("approvalMapper.insertApprovalFile", form);
	}


	public int insertApprovalLine(SqlSessionTemplate sqlSession, Approval app) {
		return sqlSession.insert("approvalMapper.insertApproval", app);
	}

	public Approval selectApproval(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.selectOne("approvalMapper.selectApproval", appNo);
	}


	public int deleteForm(SqlSessionTemplate sqlSession, int formNo) {
		return sqlSession.delete("approvalMapper.deleteForm", formNo);
	}


	public int updateApproval(SqlSessionTemplate sqlSession, Approval app) {
		return sqlSession.update("approvalMapper.updateApproval", app);
	}


	public int updateApprovalFile(SqlSessionTemplate sqlSession, Form form) {
		return sqlSession.insert("approvalMapper.updateApprovalFile", form);
	}


	public int ApprovalApp(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.update("approvalMapper.ApprovalApp", appNo);
	}


	public int ApprovalReturn(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.update("approvalMapper.ApprovalReturn", appNo);
	}


	public int deleteApproval(SqlSessionTemplate sqlSession, int appNo) {
		return sqlSession.update("approvalMapper.deleteApproval", appNo);
	}




	
}
