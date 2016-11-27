package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	public List<HashMap<String, Double>> getRestaurantList() {
		return sqlSession.selectList("map.getRestaurantList");
	}
}
