package com.groupware.worktech.adbook.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.adbook.model.vo.Adbook;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.vo.Member;

@Repository
public class AdbookDAO {

	public int getAdbookListCount(SqlSessionTemplate sqlSession, HashMap<String, String> selectMap) {
		return sqlSession.selectOne("adbookMapper.getAdbookListCount", selectMap);
	}

	public ArrayList<Member> selectAdbookList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> selectMap) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adbookMapper.selectAdbookList", selectMap, rowBounds);
	}

	public int getSearchAdbookListCount(SqlSessionTemplate sqlSession, String searchValue) {
		return sqlSession.selectOne("adbookMapper.getSearchAdbookListCount", searchValue);
	}
	
	public ArrayList<Member> selectSearchAdbookList(SqlSessionTemplate sqlSession, PageInfo pi, String searchValue) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adbookMapper.selectSearchAdbookList", searchValue, rowBounds);
	}

	public int insertpAdbook(SqlSessionTemplate sqlSession, Adbook adbook) {
		return sqlSession.insert("adbookMapper.insertpAdbook", adbook);
	}

	public int getpAdbookListCount(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("adbookMapper.getpAdbookListCount", mNo);
	}

	public ArrayList<Adbook> selectpAdbookList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adbookMapper.selectpAdbookList", mNo, rowBounds);
	}

	public Adbook selectpAdbookDetail(SqlSessionTemplate sqlSession, int adNo) {
		return sqlSession.selectOne("adbookMapper.selectpAdbookDetail", adNo);
	}

	public int updatepAdbook(SqlSessionTemplate sqlSession, Adbook adbook) {
		return sqlSession.update("adbookMapper.updatepAdbook", adbook);
	}

	public int deletepAdbook(SqlSessionTemplate sqlSession, int adNo) {
		return sqlSession.update("adbookMapper.deletepAdbook", adNo);
	}

	public int checkpAdDup(SqlSessionTemplate sqlSession, HashMap<String, String> checkMap) {
		return sqlSession.selectOne("adbookMapper.checkpAdDup", checkMap);
	}

	public int getSearchpAdbookListCount(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap) {
		return sqlSession.selectOne("adbookMapper.getSearchpAdbookListCount", searchMap);
	}

	public ArrayList<Adbook> selectSearchpAdbookList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> searchMap) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adbookMapper.selectSearchpAdbookList", searchMap, rowBounds);
	}

	public ArrayList<Member> selectAdbookMainList(SqlSessionTemplate sqlSession, String mNo) {
		return (ArrayList)sqlSession.selectList("adbookMapper.selectAdbookMainList", mNo);
	}


	

}
