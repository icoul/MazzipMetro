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

	public List<HashMap<String,String>> myQnaList(HashMap<String, String> map) {
		List<HashMap<String,String>> myQnaList =  sqlSession.selectList("myQnaList", map);
		return myQnaList;
	}

	public int getTotalMyQnaCount(HashMap<String, String> map) {
		int myQnaTotalCount = sqlSession.selectOne("getTotalMyQnaCount",map);
		return myQnaTotalCount;
	}
}
