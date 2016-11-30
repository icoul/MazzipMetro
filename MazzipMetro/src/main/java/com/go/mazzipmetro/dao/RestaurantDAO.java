package com.go.mazzipmetro.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;

@Repository
public class RestaurantDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 업장이름 리스트 가져오기
	public List<RestaurantVO> getRestName(String name){
		
		List<RestaurantVO> nameList = sqlSession.selectList("restaurant.getRestName", name);
		
		return nameList;
	}// end of getRestName(String name)
	
	// 새 업장 등록
	public int setRestRegister(RestaurantVO vo){
		
		int result = sqlSession.insert("restaurant.setRestRegister", vo);
		
		return result;
	}// end of setRestRegister(RestaurantVO vo)
	
	// 기존 업장 업데이트
	public int setRestUpdate(RestaurantVO vo){
		
		int result = sqlSession.update("restaurant.setRestUpdate", vo);
		
		return result;
	}// end of setRestUpdate(RestaurantVO vo)

	// 업장을 새로 등록했기 때문에 Seq번호를 새로 가져오기 위함.
	public String getNewRestSeq(String userSeq) {
		String newSeq = sqlSession.selectOne("restaurant.getNewRestSeq", userSeq);
		
		return newSeq;
	}// end of getNewRestSeq(RestaurantVO vo)
}
