package com.groupware.worktech.commut.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.commut.model.vo.Commut;
import com.groupware.worktech.commut.model.vo.QRCode;

@Repository("coDAO")
public class CommutDAO {

	public int insertQRCode(QRCode qr, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("commutMapper.insertQRCode", qr);
	}

	public QRCode selectQRCode(QRCode qr, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("commutMapper.selectQRCode", qr);
	}

	public QRCode selectQStatus(String getmNo, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("commutMapper.selectQstatus", getmNo);
	}
	
	public int insertGoWork(Commut c, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("commutMapper.insertGoWork", c);
	}

	public int updateLeaveWork(Commut c, SqlSessionTemplate sqlSession) {
		return sqlSession.update("commutMapper.updateLeaveWork", c);
	}

	public Commut selectGowork(String mNo, SqlSessionTemplate sqlSession) {
		 return sqlSession.selectOne("commutMapper.selectGowork", mNo);
	}

}
