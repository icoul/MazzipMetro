package com.go.mazzipmetro.service;

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
}
