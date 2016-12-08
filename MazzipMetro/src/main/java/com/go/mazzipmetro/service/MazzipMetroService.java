package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.MazzipMetroDAO;
import com.go.mazzipmetro.vo.FaqVO;
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

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int deleteQna(String[] qnaSeqArr) {
		int n = 0;
		int m = 0;
		
		for(int i = 0; i < qnaSeqArr.length; ++i){
			int count = dao.countAnswer(qnaSeqArr[i]); //qna에 답변의 갯수를 가져오는 함수
			
			if(count == 1){
				 n += dao.deleteAnswer(qnaSeqArr[i]);
			}
			 m += dao.deleteQuestion(qnaSeqArr[i]);
		}
		
		return (n+m);
	}

	public int countAnswer(String[] qnaSeqArr) {
		int count = 0;
		
		for(int i = 0; i < qnaSeqArr.length; ++i){
			count += dao.countAnswer(qnaSeqArr[i]); //qna에 답변의 갯수를 가져오는 함수
		}
		
		return count;
	}

	public int editAdminAnswer(HashMap<String, String> hashMap) {
		int n = dao.editAdminAnswer(hashMap);
		return n;
	}

	public int editUserQuestion(HashMap<String, String> hashMap) {
		int n = dao.editUserQuestion(hashMap);
		return n;
	}

	public List<FaqVO> getFaqList() {
		List<FaqVO> faqList = dao.getFaqList();
		return faqList;
	}

	public FaqVO selectOneFaq(String faqSeq) {
		FaqVO faqvo = dao.selectOneFaq(faqSeq);
		return faqvo;
	}

	public List<FaqVO> getFaqListByType(String faqType) {
		List<FaqVO> faqList = dao.getFaqListByType(faqType);
		return faqList;
	}

}
