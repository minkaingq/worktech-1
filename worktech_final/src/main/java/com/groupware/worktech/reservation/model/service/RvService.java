package com.groupware.worktech.reservation.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.admin.model.vo.RvProduct;
import com.groupware.worktech.reservation.model.dao.RvDAO;
import com.groupware.worktech.reservation.model.vo.Reservation;

@Service("rvService")
public class RvService {

	@Autowired
	private RvDAO rvDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Reservation> getRvMeetingRoomList() {
		return rvDAO.getRvMeetingRoomList(sqlSession);
	}
	
	public int insertReservation(Reservation r) {
		return rvDAO.insertReservation(sqlSession, r);
	}

	public Reservation selectReservation(int rvNo) {
		return rvDAO.selectReservation(sqlSession, rvNo);
	}

	public int deleteReservation(int rvNo) {
		return rvDAO.deleteReservation(sqlSession, rvNo);
	}

	public ArrayList<RvProduct> selectOrvList() {
		return rvDAO.selectOrvList(sqlSession);
	}

	public RvProduct selectFormOrvList(int pdNo) {
		return rvDAO.selectFormOrvList(sqlSession, pdNo);
	}

	public int insertOtherReservation(Reservation r) {
		return rvDAO.insertOtherReservation(sqlSession, r);
	}

	public ArrayList<Reservation> getOrvList() {
		return rvDAO.getOrvList(sqlSession);
	}

	public int getCountUpdate(Reservation rvp) {
		return rvDAO.getCountUpdate(sqlSession, rvp);
	}

	public ArrayList<Reservation> selectMyOrvList(String rvMember) {
		return rvDAO.selectMyOrvList(sqlSession, rvMember);
	}

	public Reservation myOrvDetail(int rvNo) {
		return rvDAO.myOrvDetail(sqlSession, rvNo);
	}

	public int myOrvListDelete(Reservation r) {
		return rvDAO.myOrvListDelete(sqlSession, r);
	}

	public int getCountDelete(Reservation rvp) {
		return rvDAO.getCountDelete(sqlSession, rvp);
	}

	public int updateMyOtherReservation() {
		return rvDAO.updateMyOtherReservation(sqlSession);
	}

	public RvProduct getRvpInfo(int rvpNo) {
		return rvDAO.getRvpInfo(sqlSession, rvpNo);
	}

	
}
