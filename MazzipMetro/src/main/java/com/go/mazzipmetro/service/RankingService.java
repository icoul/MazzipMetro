package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.dao.RankingDAO;

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
	
	// 업장 랭킹을 검색하여 받아오는 메서드
	public List<HashMap<String, String>> getRestRanking(HashMap<String, Object> optionMap, String regDate) {

		List<HashMap<String, String>> mapList = dao.getRestRanking(optionMap, regDate);
		
		return mapList;
	}
	
}
