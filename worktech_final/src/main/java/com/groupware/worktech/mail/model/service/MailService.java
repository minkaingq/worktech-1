package com.groupware.worktech.mail.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.mail.model.vo.Mail;
import com.groupware.worktech.mail.model.vo.MailFile;

public interface MailService {
	
	int insertMailFile(List<MailFile> mailFileList);

	int insertMail(Mail m);

	int getTempListCount(String mNo);

	ArrayList<Mail> selectTempList(PageInfo pi, String mNo);

	Mail selectTempMail(int id);

	int updateMail(Mail m);

	int deleteMailFile(int mFileNo);

	MailFile selectMailFile(int mFileNo);

	int insertTempMail(Mail m);

	int getsendListCount(String mNo);

	ArrayList<Mail> selectSendList(PageInfo pi, String mNo);


	Member getMId(String mId);

	int getReceiveListCount(String email);

	ArrayList<Mail> selectReceiveList(PageInfo pi, String email);

	int deleteMail(Map<String, Object> map);

	int insertMailSRReceiver(String mId);

	int insertMailSRSender(String mNo);

	int getDeleteListCount(String mNo);

	ArrayList<Mail> selectDeleteList(PageInfo pi, String mNo);

	ArrayList<Member> searchEmp(String keyword);

	int updateRDate(Map<String, Object> map);

	int updateFavorites(Map<String, Object> map);

	Mail selectMail(Map<String, Object> map);

	int getAllListCount(String mNo);

	ArrayList<Mail> selectAllList(PageInfo pi, String mNo);

	int selectCountNotRead(String mNo);

	int getFavoritesListCount(String mNo);

	ArrayList<Mail> selectFavoritesList(PageInfo pi, String mNo);

	int getSearchListCount(Map<String, Object> map);

	ArrayList<Mail> searchList(PageInfo pi, Map<String, Object> map);

	ArrayList<Mail> selectCheckList(String mNo);


}