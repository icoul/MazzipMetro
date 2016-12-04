package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.MazzipMetroDAO;
import com.go.mazzipmetro.vo.QnaVO;

@Service
public class MazzipMetroService implements IService {

	@Autowired
	MazzipMetroDAO dao;
	
	
	public List<HashMap<String, String>> dbTest() {
		return dao.dbTest();
	}
	
	public List<String> alignTest() {
		
		List<String> list = dao.alignTest();
		
		return list;
	}
	
	public int qnaRegister(HashMap<String, String> hashMap) {
		int n =  dao.qnaRegister(hashMap);
		return n;
	}

	public List<HashMap<String,String>> qnaList(HashMap<String, String> map) {
		List<HashMap<String,String>> qnaList =  dao.qnaList(map);
		return qnaList;
	}

	public int getTotalQnaCount(HashMap<String, String> map) {
		int qnaTotalCount = dao.getTotalQnaCount(map);
		return qnaTotalCount;
	}

	public int getQnaProgressCount(HashMap<String, String> hashMap) {
		int qnaCount = dao.getQnaProgressCount(hashMap);
		return qnaCount;
	}

	public int getToday(HashMap<String,String> hashMap) {
		int today = dao.getToday(hashMap);
		return today;
	}

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int adminAnswerRegister(HashMap<String,String> hashMap) {
		int n = dao.adminAnswerRegister(hashMap);
		
		String answerDate = dao.getAnswerDate(hashMap);
		hashMap.put("answerDate", answerDate);
		
		int m = dao.updateUserQna(hashMap);

		return (n+m);
	}

	public HashMap<String, String> getAdminAnswer(String qnaSeq) {
		HashMap<String, String> andminAnswer = dao.getAdminAnswer(qnaSeq);
		return andminAnswer;
	}

	public HashMap<String, String> getUserQuestion(String qnaSeq) {
		HashMap<String, String> userQuestion = dao.getUserQuestion(qnaSeq);
		return userQuestion;
	}


}
