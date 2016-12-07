package com.go.mazzipmetro.dao;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BossDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//사업주가 코인을 충전할시
	public int coinUpdate(HashMap<String, Object> map) {
		int n = sqlSession.update("boss.coinUpdate", map);
		return n;
	}//end of int coinUpdate(HashMap<String, Object> map) ---------
	
	//파워배너 결제 
	public int bannBuyUpdate(HashMap<String, String> map) {
		int n = sqlSession.update("boss.bannBuyUpdate", map);
		return n;
	}//end of int bannBuyUpdate(HashMap<String, Object> map)----------
	
	//결제시 파워배너 등록
	public int bannInsert(HashMap<String, String> map) {
		int n = sqlSession.insert("boss.bannInsert", map);
		return n;
	}// end of  int bannInsert(HashMap<String, String> map) ---------
	
	//파워링크 결제 
	public int linkBuyUpdate(HashMap<String, String> map) {
		int n = sqlSession.update("boss.linkBuyUpdate", map);
		return n;
	}//end of int linkBuyUpdate(HashMap<String, String> map)-----
	
	//결제시 파워링크 등록
	public int linkInsert(HashMap<String, String> map) {
		int n = sqlSession.insert("boss.linkInsert", map);
		return n;
	}//end of int linkInsert(HashMap<String, String> map)-------
	
	//추천광고 결제 
	public int recomBuyUpdate(HashMap<String, String> map) {
		int n = sqlSession.update("boss.recomBuyUpdate", map);
		return n;
	}
	//결제시 추천광고 등록
	public int recomInsert(HashMap<String, String> map) {
		int n = sqlSession.insert("boss.recomInsert", map);
		return n;
	}
	//RestSeq 구하기
	public List<HashMap<String, String>> getRestSeq(String userSeq) {
		List<HashMap<String, String>> list = sqlSession.selectList("boss.getRestSeq", userSeq);
		return list;
	}
}

