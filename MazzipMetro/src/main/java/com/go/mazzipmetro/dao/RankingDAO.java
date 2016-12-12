package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class RankingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<HashMap<String, String>> getRestRanking(HashMap<String, Object> optionMap) {
		
		List<HashMap<String, String>> mapList = sqlSession.selectList("ranking.getRestRanking", optionMap);
		
		return mapList;
	}
}
