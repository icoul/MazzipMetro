package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.QnaVO;

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
	
	public int qnaRegister(HashMap<String, String> hashMap) {
		int n = sqlSession.insert("qnaRegister", hashMap);
		return n;
	}

	public List<HashMap<String,String>> qnaList(HashMap<String, String> map) {
		List<HashMap<String,String>> qnaList =  sqlSession.selectList("qnaList", map);
		return qnaList;
	}

	public int getTotalQnaCount(HashMap<String, String> map) {
		int qnaTotalCount = sqlSession.selectOne("getTotalQnaCount",map);
		return qnaTotalCount;
	}

	public int getQnaProgressCount(HashMap<String, String> hashMap) {
		int qnaCount = sqlSession.selectOne("getQnaProgressCount", hashMap);
		return qnaCount;
	}

	public int getToday(HashMap<String,String> hashMap) {
		int today = sqlSession.selectOne("getToday", hashMap);
		return today;
	}

	public int adminAnswerRegister(HashMap<String,String> hashMap) {
		int result = sqlSession.insert("adminAnswerRegister", hashMap);
		return result;
	}

	public String getAnswerDate(HashMap<String, String> hashMap) {
		String answerDate = sqlSession.selectOne("getAnswerDate",hashMap);
		return answerDate;
	}

	public int updateUserQna(HashMap<String, String> hashMap) {
		int result = sqlSession.update("updateUserQna",hashMap);
		return result;
	}

	public HashMap<String, String> getAdminAnswer(String qnaSeq) {
		 HashMap<String, String> andminAnswer = sqlSession.selectOne("getAdminAnswer", qnaSeq);
		return andminAnswer;
	}

	public HashMap<String, String> getUserQuestion(String qnaSeq) {
		HashMap<String, String> userQuestion = sqlSession.selectOne("getUserQuestion", qnaSeq);
		return userQuestion;
	}
}
