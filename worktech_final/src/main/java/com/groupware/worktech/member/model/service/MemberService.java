package com.groupware.worktech.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSessionManager;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.dao.MemberDAO;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.member.model.vo.Profile;

@Service("mService")
public class MemberService {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired 
	private SqlSessionTemplate sqlSession;

	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	public int duplicateMNo(String mNo) {
		return mDAO.duplicateMNo(sqlSession, mNo);
	}

	public Member memberLogin(Member m) {
		return mDAO.memberLogin(sqlSession, m);
	}

	// 사원 목록
	public ArrayList<Member> selectMemList(PageInfo pi) {
		return mDAO.selectMemList(sqlSession, pi);
	}

	// 관리자
	public ArrayList<Member> selectAdminList(PageInfo pi) {
		return mDAO.selectAdminList(sqlSession, pi);
	}

	public int getMemListCount() {
		return mDAO.getMemListCount(sqlSession);
	}
	
	// 사원 수
	public int countMember() {
		return mDAO.countMember(sqlSession);
	}

	// 사원 검색 : 사원수
	public int getSearchResultListCount(HashMap<String, String> map) {
		return mDAO.getSearchResultListCount(sqlSession, map);
	}

	// 사원 검색 : 검색 결과 
	public ArrayList<Member> selectSearchResultList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectSearchResultList(sqlSession, pi, map);
	}

	// 사원 삭제
	public int deleteMember(String mNo) {
		return mDAO.deleteMember(sqlSession, mNo);
	}

	// 사원 삭제 개별
	public int deleteSelectMember(String selectList) {
		return mDAO.deleteSelectMember(sqlSession, selectList);
	}

	// 사원 상세보기
	public Member selectMember(String mNo) {
		return mDAO.selectMember(sqlSession, mNo);
	}

	// 사원정보 상세보기 페이지에서 사원 삭제
	public int deleteDetailMem(String mNo) {
		return mDAO.deleteDetailMem(sqlSession, mNo);
	}

	// 관리자 : 사원 정보 수정 
	public int adminUpdateMem(Member m) {
		return mDAO.adminUpdateMem(sqlSession, m);
	}

	// 비밀번호 변경
	public int updatePassword(HashMap<String, String> map) {
		return mDAO.updatePassword(sqlSession, map);
	}

	// 내 정보 수정 : 마이페이지 프로필 이미지 저장
	public int updateProfile(Profile p) {
		return mDAO.updateProfile(sqlSession, p);
	}

	// 내 정보 수정
	public int updateMemberInfo(Member m) {
		return mDAO.updateMemberInfo(sqlSession, m);
	}

	// profile 가져오기
	public Profile selectProfile(String mNo) {
		return mDAO.selectProfile(sqlSession, mNo);
	}

	public ArrayList<Member> selectMainMemList() {
		return mDAO.selectMainMemList(sqlSession);
	}

	// 임시 비밀번호 발급 : 해당 사원의 mEmail 받아오기
	public Member selectmemEmail(String mNo) {
		return mDAO.selectmemEmail(sqlSession, mNo);
	}

	// 임시비밀번호 : 비밀번호 변경
	public int updatePwd(HashMap<String, String> map) {
		return mDAO.updatePwd(sqlSession, map);
	}

	
	


	
	


}
