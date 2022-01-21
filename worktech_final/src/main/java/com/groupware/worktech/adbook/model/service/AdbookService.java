package com.groupware.worktech.adbook.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.adbook.model.dao.AdbookDAO;
import com.groupware.worktech.adbook.model.vo.Adbook;
import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.vo.Member;

@Service
public class AdbookService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AdbookDAO abDAO;

	public int getAdbookListCount(HashMap<String, String> selectMap) {
		return abDAO.getAdbookListCount(sqlSession, selectMap);
	}

	public ArrayList<Member> selectAdbookList(PageInfo pi, HashMap<String, String> selectMap) {
		return abDAO.selectAdbookList(sqlSession, pi, selectMap);
	}
	
	public int getSearchAdbookListCount(String searchValue) {
		return abDAO.getSearchAdbookListCount(sqlSession, searchValue);
	}

	public ArrayList<Member> selectSearchAdbookList(PageInfo pi, String searchValue) {
		return abDAO.selectSearchAdbookList(sqlSession, pi, searchValue);
	}

	public int insertpAdbook(Adbook adbook) {
		return abDAO.insertpAdbook(sqlSession, adbook);
	}

	public int getpAdbookListCount(String mNo) {
		return abDAO.getpAdbookListCount(sqlSession, mNo);
	}

	public ArrayList<Adbook> selectpAdbookList(PageInfo pi, String mNo) {
		return abDAO.selectpAdbookList(sqlSession, pi, mNo);
	}

	public Adbook selectpAdbookDetail(int adNo) {
		return abDAO.selectpAdbookDetail(sqlSession, adNo);
	}

	public int updatepAdbook(Adbook adbook) {
		return abDAO.updatepAdbook(sqlSession, adbook);
	}

	public int deletepAdbook(int[] checked) {
		int result = 0;
		
		for(int i = 0; i < checked.length; i++) {
			result += abDAO.deletepAdbook(sqlSession, checked[i]);
		}
		
		return result;
	}

	public int checkpAdDup(HashMap<String, String> checkMap) {
		return abDAO.checkpAdDup(sqlSession, checkMap);
	}

	public int getSearchpAdbookListCount(HashMap<String, String> searchMap) {
		return abDAO.getSearchpAdbookListCount(sqlSession, searchMap);
	}

	public ArrayList<Adbook> selectSearchpAdbookList(PageInfo pi, HashMap<String, String> searchMap) {
		return abDAO.selectSearchpAdbookList(sqlSession, pi, searchMap);
	}

	public ArrayList<Member> selectAdbookMainList(String mNo) {
		return abDAO.selectAdbookMainList(sqlSession, mNo);
	}


	
}
