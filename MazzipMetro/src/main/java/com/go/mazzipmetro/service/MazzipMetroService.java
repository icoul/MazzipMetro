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
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;

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
	// 검색어가 어느 종류의 위치정보인지 알아오기
	public String getLocationInfo(String keyword) {
		String result = "";
		String[] srchTypeArr = new String[]{"dongName", "metroName", "guName"};
		int cnt = 0;
		HashMap<String, String> map = new HashMap<>();
		map.put("keyword", keyword);
		for (int i = 0; i < srchTypeArr.length; i++) {
			map.put("srchType", srchTypeArr[i]);
			cnt = dao.getLocationInfo(map);
			if(cnt > 0){
				result = srchTypeArr[i];
				break;
			}
		}
		
		return result;
	}

	// 사용자 search
	public List<RestaurantVO> getRestSearchResult(HashMap<String, String> map) {
		return dao.getRestSearchResult(map);
	}
	
	// 사용자 search
	public List<ReviewVO> getReviewSearchResult(HashMap<String, String> map) {
		return dao.getReviewSearchResult(map);
	}

	// 통합 검색
	public List<RestaurantVO> getRestIntergratedSearch(HashMap<String, String> map) {
		return dao.getRestIntergratedSearch(map);
	}

	public List<ReviewVO> getReviewIntergratedSearch(HashMap<String, String> map) {
		return dao.getReviewIntergratedSearch(map);
	}

	// 리뷰이미지가져오기
	public List<HashMap<String, String>> getReviewImageListByReviewSeq(HashMap<String, List<String>> seqMap) {
		return dao.getReviewImageListByReviewSeq(seqMap);
	}

	// 페이징 작업 (총 게시물 수, 총 페이지수)
	// 먼저 총 음식점 수를 구하기
	public int getRestSearchResult_totalCnt(HashMap<String, String> map) {
		return dao.getRestSearchResult_totalCnt(map);
	}

	public int getRestIntergratedSearch_totalCnt(HashMap<String, String> map) {
		return dao.getRestIntergratedSearch_totalCnt(map);
	}

	public int getReviewSearchResult_totalCnt(HashMap<String, String> map) {
		return dao.getReviewSearchResult_totalCnt(map);
	}

	public int getReviewIntergratedSearch_totalCnt(HashMap<String, String> map) {
		return dao.getReviewIntergratedSearch_totalCnt(map);
	}
}
