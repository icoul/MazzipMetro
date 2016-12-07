package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.TagVO;

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
	
	// vo로 가져오기
	public List<RestaurantVO> getRestaurantVOList(HashMap<String, String[]> map) {
		return sqlSession.selectList("map.getRestaurantVOList", map);
	}

	// 지하철역별 등록된 음식점 보여주기
	public List<RestaurantVO> searchByMetro(HashMap<String, String> map) {
		return sqlSession.selectList("map.searchByMetro", map);
	}
	
	
	// metroMap tooltip 정보 가져오기
	public List<RestaurantVO> getBest5RestInMetroMap(String metroId) {
		return sqlSession.selectList("map.getBest5RestInMetroMap", metroId);
	}

	// 지하철역별 등록된 음식점 보여주기(대분류 태그 얻어오기)
	/*public List<String> getRestBgTag(String restSeq) {
		return sqlSession.selectList("map.getRestBgTag", restSeq);
	}*/
	
	// 지하철역별 등록된 음식점 보여주기(분류 태그 얻어오기)
	/*public List<String> getRestMdTag(String restSeq) {
		return sqlSession.selectList("map.getRestMdTag", restSeq);
	}*/
	
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

	//지하철 역명 가져오기(업장 직접 등록시 사용)
	public List<HashMap<String,String>> getMetroNameList(String metroNum) {
		return sqlSession.selectList("map.getMetroNameList", metroNum);
	}

	// 업장 추가이미지(restaurantAdVO)가져오기
	public String[] getAdImg(String restSeq) {
		//List<Object>를 String[]로 캐스팅하기
		List<String> adImgList = sqlSession.selectList("map.getAdImg", restSeq);
		
		System.out.println(">>>>>> adImgList.size() = "+adImgList.size() ); 
		String[] adImgArr = adImgList.toArray(new String[adImgList.size()]);
		
		return adImgArr;
	}

	// 사용자가 정복한 맛집(리뷰를 쓴 맛집) 리스트 보여주기
	public List<RestaurantVO> getUserRestConquest(HashMap<String, String> map) {
		return sqlSession.selectList("map.getUserRestConquest", map);
	}


	// 업장 restSeq 가져오기(태그가 있는 행만 가져오기) : tag 테이블 삭제
	/*public List<String> temp_getRestSeqForTags() {
		return sqlSession.selectList("restaurant.temp_getRestSeqForTags");
	}*/

}
