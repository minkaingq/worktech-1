package com.groupware.worktech.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.board.model.vo.BoardFile;
import com.groupware.worktech.board.model.vo.Category;
import com.groupware.worktech.board.model.vo.Reply;
import com.groupware.worktech.common.PageInfo;

@Repository("bDAO")
public class BoardDAO {

	public int getListCount(SqlSessionTemplate sqlSession, String bType) {
		return sqlSession.selectOne("boardMapper.getListCount", bType);
	}

	public ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectNoticeList", null, rowBounds);
	}

	public int insertNotice(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertNotice", b);
	}

	public int insertNoticeFile(SqlSessionTemplate sqlSession, BoardFile boardFile) {
		return sqlSession.insert("boardMapper.insertNoticeFile", boardFile);
	}

	public Board selectNotice(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("boardMapper.selectNotice", bNo);
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("boardMapper.addReadCount", bNo);
	}
	
	public BoardFile selectFile(SqlSessionTemplate sqlSession, int fNo) {
		return sqlSession.selectOne("boardMapper.selectFile", fNo);
	}

	public int deleteNoticeFile(SqlSessionTemplate sqlSession, int fNo) {
		return sqlSession.delete("boardMapper.deleteNoticeFile", fNo);
	}
	
	public int updateNotice(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateNotice", b);
	}
	
	public int updateNoticeFile(SqlSessionTemplate sqlSession, BoardFile boardFile) {
		return sqlSession.insert("boardMapper.updateNoticeFile", boardFile);
	}
	
	public int deleteNotice(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("boardMapper.deleteNotice", bNo);
	}
	
	public int getNoticeSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> search) {
		return sqlSession.selectOne("boardMapper.getNoticeSearchListCount", search);
	}

	public ArrayList<Board> selectNoticeSearchList(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> search) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectNoticeSearchList", search, rowBounds);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int insertCommonBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertCommonBoard", b);
	}

	


	

	

	



	

	public ArrayList<Board> selectCommonList(SqlSessionTemplate sqlSession, PageInfo pi, Integer category) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommonList", category, rowBounds);
	}

	public int getCategoryListCount(SqlSessionTemplate sqlSession, Integer category) {
		return sqlSession.selectOne("boardMapper.getCategoryListCount", category);
	}

	public Board selectCommonBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("boardMapper.selectCommonBoard", bNo);
	}

	public int updateCommonBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateCommonBoard", b);
	}

	public int getCommonSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> searchMap) {
		return sqlSession.selectOne("boardMapper.getCommonSearchListCount", searchMap);
	}

	public ArrayList<Board> selectCommonSearchList(SqlSessionTemplate sqlSession, HashMap<String, Object> searchListMap) {
		PageInfo pi = (PageInfo)searchListMap.get("pi");
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommonSearchList", searchListMap, rowBounds);
	}

	public int insertCommonReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("boardMapper.insertCommonReply", r);
	}

	public ArrayList<Reply> selectCommonReplyList(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommonReplyList", bNo);
	}

	public int deleteCommonReply(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("boardMapper.deleteCommonReply", rNo);
	}

	public ArrayList<Board> selectCommonTopList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommonTopList");
	}
	
	public ArrayList<Board> selectNoticeRecentList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectNoticeRecentList");
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int getZListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getZListCount");
	}

	public ArrayList<Board> selectZList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectZList", null, rowBounds);
	}

	public int zoomInsert(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.zoomInsert", b);
	}

	public Board selectZoom(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("boardMapper.zoomDetail", bNo);
	}

	public int zoomDelete(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("boardMapper.zoomDelete", bNo);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// �씡紐� 寃뚯떆�뙋

	

	public ArrayList<Board> selectAnonyList(PageInfo pi, SqlSessionTemplate sqlSession) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("boardMapper.selectAnonyList", pi, rowBounds);
	}

	public int insertAnony(SqlSessionTemplate sqlSession, Board b) {
		
		return sqlSession.insert("boardMapper.insertAnony", b);
	}

	public Board selectAnonyBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("boardMapper.selectAnonyBoard", bNo);
	}

	public int updateAnonyBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateAnonyBoard", b);
	}

	public int deleteAnony(int bNo, SqlSessionTemplate sqlSession) {
		return sqlSession.update("boardMapper.deleteAnony", bNo);
	}

	public int insertAnonyReply(Reply r, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("boardMapper.insertAnonyReply", r);
	}

	public int getAnonySearchListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> searchCountMap) {
		return sqlSession.selectOne("boardMapper.getAnonySearchListCount", searchCountMap);
	}

	public ArrayList<Board> selectAnonySearchList(SqlSessionTemplate sqlSession,
			HashMap<String, Object> searchListMap) {
		PageInfo pi = (PageInfo)searchListMap.get("pi");
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectAnonySearchList", searchListMap, rowBounds);	
	}

	public ArrayList<Category> selectAllCategory(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectAllCategory");
	}
	
	
	

	
	
	
}
