package com.groupware.worktech.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.member.model.vo.Profile;

@Repository("mDAO")
public class MemberDAO {

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int duplicateMNo(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("memberMapper.duplicateMNo", mNo);
	}

	public Member memberLogin(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.memberLogin", m);
	}

	// 사원목록
	public ArrayList<Member> selectMemList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemList", null, rowBounds);
	}

	// 관리자
	public ArrayList<Member> selectAdminList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectAdminList", null, rowBounds);
	}

	public int getMemListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.getMemListCount");
	}

	// 사원 수
	public int countMember(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.countMember");
	}

	// 사원 검색 : 사원 수
	public int getSearchResultListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.getSearchResultListCount", map);
	}

	// 사원 검색 : 검색 결과 
	public ArrayList<Member> selectSearchResultList(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectSearchResultList", map, rowBounds);
	}

	// 사원 삭제
	public int deleteMember(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.update("memberMapper.deleteMember", mNo);
	}

	// 사원 개별 삭제
	public int deleteSelectMember(SqlSessionTemplate sqlSession, String selectList) {
		return sqlSession.update("memberMapper.deleteSelectMember", selectList);
	}

	// 사원 상세보기
	public Member selectMember(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("memberMapper.selectMember", mNo);
	}

	// 사원정보 상세보기 페이지에서 사원 삭제
	public int deleteDetailMem(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.update("memberMapper.deleteMember", mNo);
	}

	// 관리자 : 사원 정보 수정 
	public int adminUpdateMem(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.adminUpdateMem", m);
	}

	// 비밀번호 변경
	public int updatePassword(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updatePassword", map);
	}

	// 마이페이지 프로필 이미지 저장
	public int updateProfile(SqlSessionTemplate sqlSession, Profile p) {
		return sqlSession.update("memberMapper.updateProfile", p);
	}

	// 내 정보 수정
	public int updateMemberInfo(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMemberInfo", m);
	}

	// profile 가져오기
	public Profile selectProfile(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("memberMapper.selectProfile", mNo);
	}


	public ArrayList<Member> selectMainMemList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMainMemList");
	}


	// 임시 비밀번호 발급 : 해당 사원의 mEmail 받아오기
	public Member selectmemEmail(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("memberMapper.selectmemEmail", mNo);
	}

	// 임시비밀번호 : 비밀번호 변경
	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updatePwd", map);
	}

	

	
	

}
