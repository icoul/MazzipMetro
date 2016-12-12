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

	public List<HashMap<String, String>> getRestRanking(HashMap<String, Object> optionMap, String regDate) {

		List<HashMap<String, String>> mapList = dao.getRestRanking(optionMap, regDate);
		
		return mapList;
	}
}
