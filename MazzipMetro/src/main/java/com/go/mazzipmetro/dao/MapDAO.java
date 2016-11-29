package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;

@Repository
public class MapDAO  implements IDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public void insertMetro(HashMap<String, String> map) {
		sqlSession.insert("map.insertMetro", map);
	}
	
	public void insertRestaurant(HashMap<String, String> map) {
		sqlSession.insert("map.insertRestaurant", map);
	}
	
	public String getDongId(String dongName) {
		return sqlSession.selectOne("map.dongId", dongName);
	}

	public String getMetroId(String metroName) {
		return sqlSession.selectOne("map.metroId", metroName);
	}

	public List<HashMap<String, String>> getRestaurantList() {
		return sqlSession.selectList("map.getRestaurantList");
	}

	//지하철역별 등록된 음식점 보여주기
	public List<RestaurantVO> searchByMetro(HashMap<String, String> map) {
		return sqlSession.selectList("map.searchByMetro", map);
	}
	
	//지하철역별 등록된 음식점 보여주기(대분류 태그 얻어오기)
	public String getRestBgTag(String restSeq) {
		return sqlSession.selectOne("map.getRestBgTag", restSeq);
	}
	
	//지하철역별 등록된 음식점 보여주기(분류 태그 얻어오기)
	public List<String> getRestMdTag(String restSeq) {
		return sqlSession.selectList("map.getRestMdTag", restSeq);
	}
	
	//지하철역별 등록된 음식점 보여주기
	public int getTotalCount(HashMap<String, String> map) {
		return sqlSession.selectOne("map.getTotalCount", map);
	}


}
