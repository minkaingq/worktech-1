package com.groupware.worktech.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.admin.model.vo.RvProduct;
import com.groupware.worktech.admin.model.vo.RvRange;
import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.common.PageInfo;

@Repository("aDAO")
public class AdminDAO {

	
	// 부서 목록
	public ArrayList<Department> selectDepList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectDepList");
	}
	
	// 부서 구성원 수
	public ArrayList<Integer> depCountList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.depCountList");
	}
	public int depCount(SqlSessionTemplate sqlSession, String dNo) {
		return sqlSession.selectOne("adminMapper.depCount", dNo);
	}
	

	// 부서 등록
	public int insertDepartment(SqlSessionTemplate sqlSession, Department d) {
		return sqlSession.insert("adminMapper.insertDepartment", d);
	}

	// 부서 이름 중복확인
	public int duplicateDName(SqlSessionTemplate sqlSession, String dName) {
		return sqlSession.selectOne("adminMapper.duplicateDName", dName);
	}
	
	
	// 부서 삭제
	public int deleteDep(SqlSessionTemplate sqlSession, String dNo) {
		return sqlSession.update("adminMapper.deleteDep", dNo);
	}
	
	public ArrayList<Department> getDepartmentList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.getDepartmentList");
	}

	public int insertRvProduct(SqlSessionTemplate sqlSession, RvProduct rp) {
		return sqlSession.insert("adminMapper.insertRvProduct", rp);
	}

	public int insertRvRange(SqlSessionTemplate sqlSession, ArrayList<RvRange> rrList) {
		int result = 0;
		
		for(RvRange r: rrList) {
			result += sqlSession.insert("adminMapper.insertRvRange", r);
		}
		
		return result;
	}

	public int getRvListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMapper.getRvListCount");
	}

	public ArrayList<RvProduct> selectRvProductList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectRvProductList", null, rowBounds);
	}

	public RvProduct selectRvProduct(SqlSessionTemplate sqlSession, int pdNo) {
		return sqlSession.selectOne("adminMapper.selectRvProduct", pdNo);
	}

	public int deleteRvProduct(SqlSessionTemplate sqlSession, int pdNo) {
		return sqlSession.update("adminMapper.deleteRvProduct", pdNo);
	}

	public ArrayList<Integer> getOriginRvRangeList(SqlSessionTemplate sqlSession, int pdNo) {
		return (ArrayList)sqlSession.selectList("adminMapper.getOriginRvRangeList", pdNo);
	}

	public int updateRvRange(SqlSessionTemplate sqlSession, RvRange rr) {
		return sqlSession.insert("adminMapper.updateRvRange", rr);
	}

	public int deleteRvRange(SqlSessionTemplate sqlSession, RvRange rr) {
		return sqlSession.delete("adminMapper.deleteRvRange", rr);
	}

	public int updateRvProduct(SqlSessionTemplate sqlSession, RvProduct rp) {
		return sqlSession.update("adminMapper.updateRvProduct", rp);
	}

}
