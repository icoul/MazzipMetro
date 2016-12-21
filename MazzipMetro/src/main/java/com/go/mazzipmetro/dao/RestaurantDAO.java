package com.go.mazzipmetro.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.MenuVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;

@Repository
public class RestaurantDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 하나의 업장 정보 가져오기
	public HashMap<String,String> getRestaurant(String restseq) {
		HashMap<String,String> restvo = sqlSession.selectOne("restaurant.getRestaurant", restseq);
		return restvo;
	}
	
	// 업장이름 리스트 가져오기
	public List<RestaurantVO> getRestName(HashMap<String, Object> optionMap){
		
		List<RestaurantVO> nameList = sqlSession.selectList("restaurant.getRestName", optionMap);
		
		return nameList;
	}// end of getRestName(String name)
	
	// 가져올 업장이름 리스트의 총 갯수
	public int getTotalRestName(String name) {
		int totalNum = sqlSession.selectOne("restaurant.getTotalRestName", name);
		return totalNum;
	}
	
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

	// 업장 세부정보 등록(소개글, 이미지, 태그)
	public int setRestaurantInfo(HashMap<String, String> map, ArrayList<String> imageList, MenuVO mvo, int menuNum) {
		
		int result = 0;
		
		//업장 소개글 추가
		result += sqlSession.update("restaurant.setRestContent", map);
		
		//업장 소개이미지 추가
		for (int i = 0; i < imageList.size(); i++) {
			map.put("AdImg", imageList.get(i));
			result += sqlSession.insert("restaurant.setRestImg", map);
		}
		
		//메뉴 추가
		for (int i = 0; i < menuNum; i++) {
			map.put("restSeq", mvo.getRestSeq()[i]);
			map.put("menuName", mvo.getMenuName()[i]);
			map.put("menuContent", mvo.getMenuContent()[i]);
			map.put("menuImg", mvo.getMenuImg()[i]);
			map.put("menuPrice", mvo.getMenuPrice()[i]);
			
			if ("0".equals(mvo.getMenuSalePrice()[i])) {
				mvo.getMenuSalePrice()[i] = mvo.getMenuPrice()[i];
			}
			map.put("menuSalePrice", mvo.getMenuSalePrice()[i]);
			map.put("menuSort", mvo.getMenuSort()[i]);
			map.put("menuEvent", mvo.getMenuEvent()[i]);

			result += sqlSession.insert("restaurant.setMenu", map);
		}
		
		return result;
	}// end of setRestaurantInfo(HashMap<String, Object> map) 

	// 매장 정보 수정을 위한 해당 회원이 등록한 매장 정보 모두 불러오기
	public List<RestaurantVO> getRestList(String userSeq) {
		
		List<RestaurantVO> restList = sqlSession.selectList("restaurant.getRestrauntEditList", userSeq);
		
		return restList;
	}

	// 매장 정보 수정을 위한 1개의 매장정보 가져오기
	public RestaurantVO getOneRestInfo(String restSeq) {
		
		RestaurantVO vo = sqlSession.selectOne("restaurant.adminRestEditInfo", restSeq);
		
		return vo;
	}
	
	// 페이징 처리 된 리뷰리스트
	public List<HashMap<String, String>> getReviewList(HashMap<String, String> map) {

		List<HashMap<String, String>> list = sqlSession.selectList("review.getReviewPaggingList", map);
		
		return list;
	}

	// 매장 삭제 매서드
	public int delRest(HashMap<String, String> map) {

		int result = sqlSession.update("restaurant.delRest", map);
		
		return result;
	}

	public int editRest(RestaurantVO rvo) {
		
		int result = sqlSession.update("restaurant.adminRestEditEnd", rvo);
		
		return result;
	}

	// 지하철 ID, 역명 전체 리스트 가져오기
	public List<String> getMetroId() {
		List<String> metroId = sqlSession.selectList("restaurant.getMetro");
		return metroId;
	}

	public int getTotalReview(String restSeq) {
		
		int result = sqlSession.selectOne("review.getTotalCount", restSeq);
		
		return result;
	}
	
	//메뉴 목록 가져오기
	public List<HashMap<String, String>> getMenuList(String restSeq) {
		
		List<HashMap<String, String>> menuList = sqlSession.selectList("restaurant.getMenuList", restSeq);
		
		return menuList;
	}
	
	//메뉴 수정하기
	public int editRestMenu(MenuVO mvo) {
		
		String menuSeq = "";
		String menuStatus ="";
		int result = 0;
		
		for (int i = 0; i < mvo.getMenuSeq().length; i++) {
			System.out.println("menuSeq = " + mvo.getMenuSeq()[i]);
			System.out.println("restSeq = " + mvo.getRestSeq()[i]);
			System.out.println("menuName = " + mvo.getMenuName()[i]);
			System.out.println("menuContent = " + mvo.getMenuContent()[i]);
			System.out.println("menuImg = " + mvo.getMenuImg()[i]);
			System.out.println("menuPrice = " + mvo.getMenuPrice()[i]);
			System.out.println("menuSalePrice = " + mvo.getMenuSalePrice()[i]);
			System.out.println("menuSort = " + mvo.getMenuSort()[i]);
			System.out.println("menuEvent = " + mvo.getMenuEvent()[i]);
			
			menuSeq = mvo.getMenuSeq()[i];
			menuStatus = mvo.getMenuStatus()[i];
			
			HashMap<String, String> map = new HashMap<String, String>();

			map.put("menuSeq", mvo.getMenuSeq()[i]);
			map.put("restSeq", mvo.getRestSeq()[i]);
			map.put("menuName", mvo.getMenuName()[i]);
			map.put("menuContent", mvo.getMenuContent()[i]);
			map.put("menuImg", mvo.getMenuImg()[i]);
			map.put("menuPrice", mvo.getMenuPrice()[i]);
			map.put("menuSalePrice", mvo.getMenuSalePrice()[i]);
			map.put("menuSort", mvo.getMenuSort()[i]);
			map.put("menuEvent", mvo.getMenuEvent()[i]);
			
			// 둘 다 0이면 새로 추가한 메뉴이므로 insert해준다.
			if (menuSeq.equals("0") && menuStatus.equals("0")) {
				result += sqlSession.insert("restaurant.menuEditInsert", map);
			}
			
			// 삭제한 기존메뉴이므로 delete해준다.
			if (!menuSeq.equals("0") && menuStatus.equals("1")) {
				result += sqlSession.insert("restaurant.menuEditDelete", map);
			}
			
			// 수정한 기존메뉴이므로 update해준다
			if (!menuSeq.equals("0") && menuStatus.equals("0")) {
				result += sqlSession.insert("restaurant.menuEditUpdate", map);
			}
			
		}
		
		return result;
	}

	public List<RestaurantVO> restListStatistics(String userSeq) {
		List<RestaurantVO> restList = sqlSession.selectList("restaurant.restListStatistics", userSeq);
		return restList;
	}

	public List<HashMap<String, String>> restStati_Gender(String restSeq) {
		List<HashMap<String, String>> genderList = sqlSession.selectList("restaurant.restStati_Gender", restSeq);
		return genderList;
	}
	
	public List<String> getLikers(String userSeq) {
		List<String> likers = sqlSession.selectList("review.getLikers", userSeq);
		return likers;
	}

	public List<HashMap<String, String>> restStati_AgeLine(String restSeq) {
		List<HashMap<String, String>> ageList = sqlSession.selectList("restaurant.restStati_AgeLine", restSeq);
		return ageList;
	}

	public List<HashMap<String, String>> restStati_reviewCount(String restSeq) {
		List<HashMap<String, String>> reviewCount = sqlSession.selectList("restaurant.restStati_reviewCount", restSeq);
		return reviewCount;
	}

	public List<HashMap<String, String>> restStati_ReviewGrade(String restSeq) {
		List<HashMap<String, String>> reviewGrade = sqlSession.selectList("restaurant.restStati_ReviewGrade", restSeq);
		return reviewGrade;
	}

	public List<String> getRestThemeList(String restSeq) {
		List<String> restThemeList = sqlSession.selectList("restaurant.getRestThemeList", restSeq);
		return restThemeList;
	}
	// 조회수 증가 요청
	public int updateRestVisitor(String restSeq) {
		return sqlSession.update("restaurant.updateRestVisitor", restSeq);
	}

	//은석 음식점상세페이지에서 음식점 사진들 
	public List<String> getRestImageList(String restSeq) {
		List<String> restImageList = sqlSession.selectList("restaurant.getRestImageList", restSeq);
		return restImageList;
	}

}
