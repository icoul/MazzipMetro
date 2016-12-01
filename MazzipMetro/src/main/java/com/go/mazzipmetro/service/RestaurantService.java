package com.go.mazzipmetro.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.RestaurantDAO;
import com.go.mazzipmetro.vo.MenuVO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Service
public class RestaurantService implements IService{

	@Autowired
	private RestaurantDAO dao;
	
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
	public int setRestaurantInfo(HashMap<String, String> map, ArrayList<String> imageList, String[] mdCat, MenuVO mvo, int menuNum) {
		
		int result = dao.setRestaurantInfo(map, imageList, mdCat, mvo, menuNum);
		
		return result;
	}// end of setRestaurantInfo(HashMap<String, Object> map) 
}
