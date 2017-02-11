package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.dao.ContentDAO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Controller
public class ContentService {

	@Autowired
	private ContentDAO dao;

	// 메인배너 컨텐츠에 들어갈 데이터
	public RestaurantVO getMainContents() {

		RestaurantVO rvo = dao.getMainContents();
		return rvo;
	}

	// 메인배너 컨텐츠에 들어갈 업장소개이미지
	public List<String> getMainContentsAdImage(String restSeq) {

		List<String> adImage = dao.getMainContentsAdImage(restSeq);
		return adImage;
	}

	// 측면배너 컨텐츠에 들어갈 데이터
	public List<RestaurantVO> getRightContents() {
		
		List<RestaurantVO> rvoList = dao.getRightContents();
		return rvoList;
	}

	// 검색 파워링크 컨텐츠에 들어갈 데이터
	public List<RestaurantVO> getPowerLinkContents() {
		List<RestaurantVO> rvoList = dao.getPowerLinkContents();
		return rvoList;
	}
	
	// 측면배너 컨텐츠에 들어갈 데이터
	public RestaurantVO getWantGoContents() {
		
		RestaurantVO vo = dao.getWantGoContents();
		return vo;
	}
	
	//동현_업장상세페이지 요청시 사용자의 가고싶다의 담겨있는 경우만, req객체에 담는다.
	public int checkWantToGo(HashMap<String, String> map) {
		return dao.checkWantToGo(map);
	}
	
}


