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

	public List<HashMap<String, String>> getRestaurantList(HashMap<String, String[]> map) {
		//System.out.println(map.get("userSeq")[0]); 
		//System.out.println(map.get("keyword")[0] == null); //false
		return sqlSession.selectList("map.getRestaurantList", map);
	}

	// 지하철역별 등록된 음식점 보여주기
	public List<RestaurantVO> searchByMetro(HashMap<String, String> map) {
		return sqlSession.selectList("map.searchByMetro", map);
	}
	
	// 지하철역별 등록된 음식점 보여주기(대분류 태그 얻어오기)
	public String getRestBgTag(String restSeq) {
		return sqlSession.selectOne("map.getRestBgTag", restSeq);
	}
	
	// 지하철역별 등록된 음식점 보여주기(분류 태그 얻어오기)
	public List<String> getRestMdTag(String restSeq) {
		return sqlSession.selectList("map.getRestMdTag", restSeq);
	}
	
	// 지하철역별 등록된 음식점 보여주기
	public int getTotalCount(HashMap<String, String> map) {
		return sqlSession.selectOne("map.getTotalCount", map);
	}

	public RestaurantVO selectOneRestaurant(String restSeq) {
		return sqlSession.selectOne("restaurant.selectOneRestaurant", restSeq);
	}

	// 자동 글완성
	public List<String> autoComplete(HashMap<String, String> map) {
		return sqlSession.selectList("restaurant.autoComplete", map);
	}

	// 자동글완성(카테고리) : restName
	public List<String> r_catAutoComplete(String keyword) {
		return sqlSession.selectList("restaurant.r_catAutoComplete", keyword);
	}

	// 자동글완성(카테고리) : metroName
	public List<String> m_catAutoComplete(String keyword) {
		return sqlSession.selectList("restaurant.m_catAutoComplete", keyword);
	}

	// 자동글완성(카테고리) : dongName
	public List<String> d_catAutoComplete(String keyword) {
		return sqlSession.selectList("restaurant.d_catAutoComplete", keyword);
	}

	// 자동글완성(카테고리) : guName
	public List<String> g_catAutoComplete(String keyword) {
		return sqlSession.selectList("restaurant.g_catAutoComplete", keyword);
	}
	
	// 지하철 역이름 얻기 (지도페이지로 넘길 때 사용함)
	public String getMetroName(String metroId) {
		return sqlSession.selectOne("map.getMetroName", metroId);
	}

	
	


}
