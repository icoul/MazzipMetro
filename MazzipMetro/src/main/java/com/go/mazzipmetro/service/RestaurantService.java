package com.go.mazzipmetro.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.RestaurantDAO;
import com.go.mazzipmetro.vo.MenuVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;

@Service
public class RestaurantService implements IService{

	@Autowired
	private RestaurantDAO dao;
	
	// 하나의 업장 정보 가져오기
	public HashMap<String,String> getRestaurant(String restseq) {
		HashMap<String,String> restvo = dao.getRestaurant(restseq);
		return restvo;
	}
	
	// 업장이름 리스트 가져오기
	public List<RestaurantVO> getRestName(String name){
		
		List<RestaurantVO> nameList = dao.getRestName(name);
		
		return nameList;
	} // end of getRestName(String name)
	
	// 새 업장 등록
	public int setRestRegister(RestaurantVO vo){
		
		int result = dao.setRestRegister(vo);
		
		return result;
	}// end of setRestRegister(RestaurantVO vo)
	
	// 기존 업장 업데이트
	public int setRestUpdate(RestaurantVO vo){
		
		int result = dao.setRestUpdate(vo);
		
		return result;
	}// end of setRestUpdate(RestaurantVO vo)

	// 업장을 새로 등록했기 때문에 Seq번호를 새로 가져오기 위함.
	public String getNewRestSeq(String userSeq) {
		String newSeq = dao.getNewRestSeq(userSeq);
		
		return newSeq;
	}// end of getNewRestSeq(RestaurantVO vo)
	
	// 업장 세부정보 등록(소개글, 이미지, 태그)
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int setRestaurantInfo(HashMap<String, String> map, ArrayList<String> imageList, MenuVO mvo, int menuNum) {
		
		int result = dao.setRestaurantInfo(map, imageList, mvo, menuNum);
		
		return result;
	}// end of setRestaurantInfo(HashMap<String, Object> map) 

	
	// 매장 정보 수정을 위한 해당 회원이 등록한 매장 정보 모두 불러오기
	public List<RestaurantVO> getRestList(String userSeq) {
		
		List<RestaurantVO> restList = dao.getRestList(userSeq);
		
		return restList;
	}

	// 매장 정보 수정을 위한 1개의 매장정보 가져오기
	public RestaurantVO getOneRestInfo(String restSeq) {

		RestaurantVO vo = dao.getOneRestInfo(restSeq);
		
		return vo;
	}

	// 매장 삭제 매서드
	public int delRest(HashMap<String, String> map) {

		int result = dao.delRest(map);
		
		return result;
	}
	
	// 매장 수정 매서드
	public int editRest(RestaurantVO rvo) {

		int result = dao.editRest(rvo);
		
		return result;
	}

	// 지하철 ID, 역명 전체 리스트 가져오기
	public List<String> getMetroId() {
		List<String> metroId = dao.getMetroId();
		return metroId;
	}

	// 리뷰 가져오기 
	public List<HashMap<String, String>> getReviewList(HashMap<String, String> map) {
		
		List<HashMap<String, String>> list = dao.getReviewList(map);
		
		return list;
	}

	//총 리뷰수 가져오기
	public int getTotalReview(String restSeq) {
		
		int result = dao.getTotalReview(restSeq);
		
		return result;
	}
	
	//메뉴 목록 가져오기
	public List<HashMap<String, String>> getMenuList(String restSeq) {

		List<HashMap<String, String>> menuList = dao.getMenuList(restSeq);
		
		return menuList;
	}
	
	//메뉴 수정하기
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int editRestMenu(MenuVO mvo){
		int result = dao.editRestMenu(mvo);
		
		return result;
	}

	public List<RestaurantVO> restListStatistics(String userSeq) {
		List<RestaurantVO> restList = dao.restListStatistics(userSeq);
		return restList;
	}

	public List<HashMap<String, String>> restStati_Gender(String restSeq) {
		List<HashMap<String, String>> ageList = dao.restStati_Gender(restSeq);
		return ageList;
	}

	public List<String> getLikers(String userSeq) {
		List<String> likers = dao.getLikers(userSeq);
		return likers;
	}



	
}
