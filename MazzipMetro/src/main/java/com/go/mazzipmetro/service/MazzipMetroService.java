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

	//오늘뭐먹지?(foodCart)에 담기 요청
	public int addWantToGo(HashMap<String, String> map) {
		return dao.addWantToGo(map);
	}

	//가고싶다 테이블에 담겨있는지 검사
	public int checkWantToGo(HashMap<String, String> map) {
		return dao.checkWantToGo(map);
	}

	// 사용자 가고싶다 list 요청
	public List<RestaurantVO> getUserWantToGo(String userSeq) {
		return dao.getUserWantToGo(userSeq);
	}

	// 가고싶다 삭제 요청
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int delWantToGo(String userSeq, String[] wantToGoChkArr) {
		int result = 0;
		
		HashMap<String, String> map = new HashMap<>();
		map.put("userSeq", userSeq);
		
		for (String restSeq : wantToGoChkArr) {
			map.put("restSeq", restSeq);
			result += dao.delWantToGo(map);
		}
		
		if (result == wantToGoChkArr.length) {
			result = 1;
		} else {
			result = 0;
		}
		
		return result;
	}

	// 사용자의 가고싶다 에 담은 개수 확인
	public int checkNumWantToGo(HashMap<String, String> map) {
		return dao.checkNumWantToGo(map);
	}

	// 맛집메트로 추천을 사용자가 선택한다.
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int mazzipMetroPick(HashMap<String, String> map) {
		int result = 0;
		// 사용자가 맛집추천을 받은 적이 있는지 체크해서 이전 맛집 추천은 가고싶다 삭제 상태로 update한다.
		// 사용자의 맛집추천(wantToGoStatus  = 2 는 하나의 행에서만 가질 수 있다.)
		// 없을 수도 있으므로, 결과값에 상관없이 다음 진행한다.
		dao.deletePreviouseMazzipMetroPick(map);
		result = dao.mazzipMetroPick(map);
		
		return result;
	}

	// 동현_테마 선택 페이지 ajax 요청
	public List<RestaurantVO> getThemeSearch(HashMap<String, Object> map) {
		return dao.getThemeSearch(map);
	}

	// 테마별  총 음식점 수를 구하기
	public int getThemeSearch_totalCnt(HashMap<String, Object> map) {
		return dao.getThemeSearch_totalCnt(map);
	}
}
