package com.groupware.worktech.mail.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.mail.model.vo.Mail;
import com.groupware.worktech.mail.model.vo.MailFile;

@Repository("mailDAO")
public class MailDAO {

	public int insertMailFile(SqlSessionTemplate sqlSession, List<MailFile> mailFileList) {

		int result = 0;

		for (MailFile mf : mailFileList) {
			result += sqlSession.insert("mailMapper.insertMailFile", mf);
		}
		return result;
	}

	public int insertMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.insert("mailMapper.insertMail", m);
	}

	public int getTempListCount(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("mailMapper.getTempListCount", mNo);
	}

	public ArrayList<Mail> selectTempList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {

		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		// 건너뛰기
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("mailMapper.selectTempList", mNo, rowBounds);
	}

	public Mail selectTempMail(SqlSessionTemplate sqlSession, int id) {
		return sqlSession.selectOne("mailMapper.selectTempMail", id);
	}

	public int updateMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.update("mailMapper.updateMail", m);
	}

	public int deleteMailFile(SqlSessionTemplate sqlSession, int mFileNo) {
		return sqlSession.delete("mailMapper.deleteMailFile", mFileNo);
	}

	public MailFile selectMailFile(SqlSessionTemplate sqlSession, int mFileNo) {
		return sqlSession.selectOne("mailMapper.selectMailFile", mFileNo);
	}

	public int getReceiveListCount(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("mailMapper.getReceiveListCount", email);
	}

	public int insertTempMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.insert("mailMapper.insertTempMail", m);
	}

	public int getSendListCount(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("mailMapper.getSendListCount", mNo);
	}

	public ArrayList<Mail> selectSendList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("mailMapper.selectSendList", mNo, rowBounds);
	}

	public Mail selectMail(SqlSessionTemplate sqlSession, int id) {
		return sqlSession.selectOne("mailMapper.selectMail", id);
	}

	public Member getMId(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("mailMapper.getMId", mId);
	}

	public ArrayList<Mail> selectReceiveList(SqlSessionTemplate sqlSession, PageInfo pi, String email) {

		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("mailMapper.selectReceiveList", email, rowBounds);
	}

	public int deleteMail(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("mailMapper.deleteMail", map);
	}

	public int insertMailSRReceiver(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.insert("mailMapper.insertMailSRReceiver", mId);
	}

	public int insertMailSRSender(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.insert("mailMapper.insertMailSRSender", mNo);
	}

	public int getDeleteListCount(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("mailMapper.getDeleteListCount", mNo);
	}

	public ArrayList<Mail> selectDeleteList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {

		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("mailMapper.selectDeleteList", mNo, rowBounds);
	}

	public ArrayList<Member> searchEmp(SqlSessionTemplate sqlSession, String keyword) {
		return (ArrayList) sqlSession.selectList("mailMapper.searchEmp", keyword);
	}

	public int updateRDate(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("mailMapper.updateRDate", map);
	}

	public int updateFavorites(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("mailMapper.updateFavorites", map);
	}

	public Mail selectMail(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("mailMapper.selectMailByMap", map);
	}

	public int getAllListCount(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("mailMapper.getAllListCount", mNo);
	}

	public ArrayList<Mail> selectAllList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList) sqlSession.selectList("mailMapper.selectAllList", mNo, rowBounds);
	}

	public int selectCountNotRead(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("mailMapper.selectCountNotRead", mNo);
	}

	public int getFavoritesListCount(SqlSessionTemplate sqlSession, String mNo) {
		return sqlSession.selectOne("mailMapper.getFavoritesListCount", mNo);
	}

	public ArrayList<Mail> selectFavoritesList(SqlSessionTemplate sqlSession, PageInfo pi, String mNo) {

		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("mailMapper.selectFavoritesList", mNo, rowBounds);
	}

	public int getSearchListCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("mailMapper.getSearchListCount", map);
	}

	public ArrayList<Mail> searchList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> map) {
		
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() - 1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("mailMapper.searchList", map, rowBounds);
	}

	public ArrayList<Mail> selectCheckList(SqlSessionTemplate sqlSession, String mNo) {
		return (ArrayList)sqlSession.selectList("mailMapper.selectCheckList", mNo);
	}
}
