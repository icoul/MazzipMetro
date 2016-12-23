package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.dao.RankingDAO;
import com.go.mazzipmetro.vo.RestaurantAdVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class RankingService {

	@Autowired
	private RankingDAO dao;
	
	// 지하철 데이터를 받아오는 메서드
	public List<HashMap<String, String>> getMetro() {
		List<HashMap<String, String>> metro = dao.getMetro();
		return metro;
	}
	
	// 동 데이터를 받아오는 메서드
	public List<HashMap<String, String>> getDong() {
		List<HashMap<String, String>> dong = dao.getDong();
		return dong;
	}
	
	// 지하철 검색시 자동글완성을 해주는 메서드
	public List<HashMap<String, String>> searchMetroName(String metroName) {
		
		List<HashMap<String, String>> metro = dao.searchMetroName(metroName);
		
		return metro;
	}
	
	// 동 검색시 자동글완성을 해주는 메서드
	public List<HashMap<String, String>> searchDongName(String dongName) {
		
		List<HashMap<String, String>> dong = dao.searchDongName(dongName);
		
		return dong;
	}
	
	// 총 업장 갯수를 구하는 메서드
	public int getTotalRestNum(HashMap<String, Object> optionMap, String regDate) {
		int totalNum = dao.getTotalRestNum(optionMap, regDate); // 총 갯수
		return totalNum;
	}
	
	// 총 리뷰 갯수를 구하는 메서드
	public int getTotalReviewNum(HashMap<String, Object> optionMap, String regDate) {
		int totalNum = dao.getTotalReviewNum(optionMap, regDate); // 총 갯수
		return totalNum;
	}
	
	// 업장 랭킹을 검색하여 받아오는 메서드
	public List<HashMap<String, String>> getRestRanking(HashMap<String, Object> optionMap, String regDate) {

		List<HashMap<String, String>> mapList = dao.getRestRanking(optionMap, regDate);
		
		return mapList;
	}

	// 사용자 랭킹을 검색하여 받아오는 메서드
	public List<HashMap<String, String>> getReviewRanking(HashMap<String, Object> optionMap, String regDate) {
		List<HashMap<String, String>> mapList = dao.getReviewRanking(optionMap, regDate);
		
		return mapList;
	}

	//인덱스 페이지 탑랭크 리뷰어가 추천한 맛집 이 곳의 맛집번호를 가져오는 메서드
	public HashMap<String, String> getTop5ScoreRest(String userSeq) {
		HashMap<String, String> seqList = dao.getTop5ScoreRest(userSeq);
		
		return seqList;
	}

	public RestaurantVO getRestInfo(HashMap<String, String> seqList) {
		RestaurantVO restvo = dao.getRestInfo(seqList);
		return restvo;
	}

	public ReviewVO getReviewInfo(HashMap<String, String> seqList) {
		ReviewVO reviewvo = dao.getReviewInfo(seqList);
		return reviewvo;
	}

	public UserVO getUserInfo(HashMap<String, String> seqList) {
		UserVO uservo = dao.getUserInfo(seqList);
		return uservo;
	}

	public List<String> getRestAdInfo(HashMap<String, String> seqList) {
		List<String> adImage = dao.getRestAdInfo(seqList);
		return adImage;
	}

	

	
	
}
