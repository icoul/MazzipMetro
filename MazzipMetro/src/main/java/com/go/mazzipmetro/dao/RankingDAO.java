package com.go.mazzipmetro.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class RankingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<HashMap<String, String>> getRestRanking(HashMap<String, Object> optionMap, String regDate) {
		List<HashMap<String, String>> mapList = new ArrayList<HashMap<String, String>>();
		
		if (regDate == null) { // 기간 상관없이 랭킹
			mapList = sqlSession.selectList("ranking.getNotDateRestRanking", optionMap);
		}
		
		else if (regDate.equals("7")) {// 최근 일주일 랭킹
			mapList = sqlSession.selectList("ranking.getOneWeekRestRanking", optionMap);
		}
		
		else if (regDate.equals("30")) {// 최근 한 달 랭킹
			mapList = sqlSession.selectList("ranking.getOneMonthRestRanking", optionMap);
		}
		
		else if (regDate.equals("90")) {// 최근 3달 랭킹
			mapList = sqlSession.selectList("ranking.getThreeMonthRestRanking", optionMap);
		}
		
		else if (regDate.equals("365")) {// 최근 1년 랭킹
			mapList = sqlSession.selectList("ranking.getOneYearRestRanking", optionMap);
		}
		
		return mapList;
	}
}
