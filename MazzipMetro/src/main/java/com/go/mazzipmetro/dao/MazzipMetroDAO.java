package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.FaqVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;

@Repository
public class MazzipMetroDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<HashMap<String, String>> dbTest() {
		return sqlSession.selectList("mazzipMetro.dbTest");
	}

	public List<String> alignTest() {

		List<String> list = sqlSession.selectList("mazzipMetro.alignTest");
		
		return list;
	}
	
	
	
	// 검색어가 어느 종류의 위치정보인지 알아오기
	public int getLocationInfo(HashMap<String, String> map) {
		return sqlSession.selectOne("mazzipMetro.getLocationInfo", map);
	}

	// 사용자 search 
	public List<RestaurantVO> getRestSearchResult(HashMap<String, String> map) {
		return sqlSession.selectList("mazzipMetro.getRestSearchResult", map);
	}

	// 사용자 search
	public List<ReviewVO> getReviewSearchResult(HashMap<String, String> map) {
		return sqlSession.selectList("mazzipMetro.getReviewSearchResult", map);
	}

	// 사용자 search : 통합 업장
	public List<RestaurantVO> getRestIntergratedSearch(HashMap<String, String> map) {
		return sqlSession.selectList("mazzipMetro.getRestIntergratedSearch", map);
	}
	
	// 사용자 search : 통합 리뷰
	public List<ReviewVO> getReviewIntergratedSearch(HashMap<String, String> map) {
		return sqlSession.selectList("mazzipMetro.getReviewIntergratedSearch", map);
	}

	// 리뷰이미지가져오기
	public List<HashMap<String, String>> getReviewImageListByReviewSeq(HashMap<String, List<String>> map) {
		return sqlSession.selectList("review.getReviewImageListByReviewSeq_search", map);
	}

	// 페이징 작업 (총 게시물 수, 총 페이지수)
	// 먼저 총 음식점 수를 구하기
	public int getRestSearchResult_totalCnt(HashMap<String, String> map) {
		return sqlSession.selectOne("mazzipMetro.getRestSearchResult_totalCnt", map);
	}

	public int getRestIntergratedSearch_totalCnt(HashMap<String, String> map) {
		return sqlSession.selectOne("mazzipMetro.getRestIntergratedSearch_totalCnt", map);
	}

	public int getReviewSearchResult_totalCnt(HashMap<String, String> map) {
		return sqlSession.selectOne("mazzipMetro.getReviewSearchResult_totalCnt", map);
	}

	public int getReviewIntergratedSearch_totalCnt(HashMap<String, String> map) {
		return sqlSession.selectOne("mazzipMetro.getReviewIntergratedSearch_totalCnt", map);
	}
	
	////////////////////////////////////////////////////////은석18 //////////////////////////////////////////////////////////////
	//1
	public int qnaRegister(HashMap<String, String> hashMap) {
		int n = sqlSession.insert("qnaRegister", hashMap);
		return n;
	}
	//2
	public List<HashMap<String,String>> qnaList(HashMap<String, String> map) {
		List<HashMap<String,String>> qnaList =  sqlSession.selectList("qnaList", map);
		return qnaList;
	}
	//3
	public int getTotalQnaCount(HashMap<String, String> map) {
		int qnaTotalCount = sqlSession.selectOne("getTotalQnaCount",map);
		return qnaTotalCount;
	}
	//4
	public int getQnaProgressCount(HashMap<String, String> hashMap) {
		int qnaCount = sqlSession.selectOne("getQnaProgressCount", hashMap);
		return qnaCount;
	}
	//5
	public int getToday(HashMap<String,String> hashMap) {
		int today = sqlSession.selectOne("getToday", hashMap);
		return today;
	}
	//6
	public int adminAnswerRegister(HashMap<String,String> hashMap) {
		int result = sqlSession.insert("adminAnswerRegister", hashMap);
		return result;
	}
	//7
	public String getAnswerDate(HashMap<String, String> hashMap) {
		String answerDate = sqlSession.selectOne("getAnswerDate",hashMap);
		return answerDate;
	}
	//8
	public int updateUserQna(HashMap<String, String> hashMap) {
		int result = sqlSession.update("updateUserQna",hashMap);
		return result;
	}
	//9
	public HashMap<String, String> getAdminAnswer(String qnaSeq) {
		 HashMap<String, String> andminAnswer = sqlSession.selectOne("getAdminAnswer", qnaSeq);
		return andminAnswer;
	}
	//10
	public HashMap<String, String> getUserQuestion(String qnaSeq) {
		HashMap<String, String> userQuestion = sqlSession.selectOne("getUserQuestion", qnaSeq);
		return userQuestion;
	}
	//11
	public int deleteAnswer(String qnaSeq) {
		int n = sqlSession.update("deleteAnswer",qnaSeq);
		return n;
	}
	//12
	public int deleteQuestion(String qnaSeq) {
		int n = sqlSession.update("deleteQuestion",qnaSeq);
		return n;
	}
	//13
	public int countAnswer(String qnaSeq) {
		int count = sqlSession.selectOne("countAnswer",qnaSeq);
		return count;
	}
	//14
	public int editAdminAnswer(HashMap<String, String> hashMap) {
		int n = sqlSession.update("editAdminAnswer",hashMap);
		return n;
	}
	//15
	public int editUserQuestion(HashMap<String, String> hashMap) {
		int n = sqlSession.update("editUserQuestion",hashMap);
		return n;
	}
	//16
	public List<FaqVO> getFaqList() {
		List<FaqVO> faqList = sqlSession.selectList("getFaqList");
		return faqList;
	}
	//17
	public FaqVO selectOneFaq(String faqSeq) {
		FaqVO faqvo = sqlSession.selectOne("selectOneFaq", faqSeq);
		return faqvo;
	}
	//18
	public List<FaqVO> getFaqListByType(String faqType) {
		List<FaqVO> faqList = sqlSession.selectList("getFaqListByType", faqType);
		return faqList;
	}
	////////////////////////////////////////////////////////은석18 //////////////////////////////////////////////////////////////
}
