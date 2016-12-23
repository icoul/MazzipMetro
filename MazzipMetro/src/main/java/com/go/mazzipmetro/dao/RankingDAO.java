package com.go.mazzipmetro.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.vo.RestaurantAdVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class RankingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 지하철 데이터를 받아오는 메서드
	public List<HashMap<String, String>> getMetro() {
		List<HashMap<String, String>> metro = sqlSession.selectList("ranking.getMetro");
		return metro;
	}

	// 동 데이터를 받아오는 메서드
	public List<HashMap<String, String>> getDong() {
		List<HashMap<String, String>> dong = sqlSession.selectList("ranking.getDong");
		return dong;
	}

	// 지하철 검색시 자동글완성을 해주는 메서드
	public List<HashMap<String, String>> searchMetroName(String metroName) {
		
		List<HashMap<String, String>> metro = sqlSession.selectList("ranking.searchMetroName", metroName);
		
		return metro;
	}
	
	// 동 검색시 자동글완성을 해주는 메서드
	public List<HashMap<String, String>> searchDongName(String dongName) {
		
		List<HashMap<String, String>> dong = sqlSession.selectList("ranking.searchDongName", dongName);
		
		return dong;
	}
	
	// 업장 총 갯수를 구하는 메서드
	public int getTotalRestNum(HashMap<String, Object> optionMap, String regDate) {
		
		int totalNum = 0; // 총 갯수
		if (regDate.equals("0")) { // 기간 상관없이 랭킹
			totalNum = sqlSession.selectOne("ranking.getNotDateTotalNum", optionMap);
		}
		
		else if (regDate.equals("7")) {// 최근 일주일 랭킹
			totalNum = sqlSession.selectOne("ranking.getOneWeekTotalNum", optionMap);
		}
		
		else if (regDate.equals("30")) {// 최근 한 달 랭킹
			totalNum = sqlSession.selectOne("ranking.getOneMonthTotalNum", optionMap);
		}
		
		else if (regDate.equals("90")) {// 최근 3달 랭킹
			totalNum = sqlSession.selectOne("ranking.getThreeMonthTotalNum", optionMap);
		}
		
		else if (regDate.equals("365")) {// 최근 1년 랭킹
			totalNum = sqlSession.selectOne("ranking.getOneYearTotalNum", optionMap);
		}
		
		return totalNum;
	}
	
	// 리뷰 총 갯수를 구하는 메서드
	public int getTotalReviewNum(HashMap<String, Object> optionMap, String regDate) {
		int totalNum = 0; // 총 갯수
		if (regDate.equals("0")) { // 기간 상관없이 랭킹
			totalNum = sqlSession.selectOne("ranking.getNotDateTotalReviewNum", optionMap);
		}
		
		else if (regDate.equals("7")) {// 최근 일주일 랭킹
			totalNum = sqlSession.selectOne("ranking.getOneWeekTotalReviewNum", optionMap);
		}
		
		else if (regDate.equals("30")) {// 최근 한 달 랭킹
			totalNum = sqlSession.selectOne("ranking.getOneMonthTotalReviewNum", optionMap);
		}
		
		else if (regDate.equals("90")) {// 최근 3달 랭킹
			totalNum = sqlSession.selectOne("ranking.getThreeMonthTotalReviewNum", optionMap);
		}
		
		else if (regDate.equals("365")) {// 최근 1년 랭킹
			totalNum = sqlSession.selectOne("ranking.getOneYearTotalReviewNum", optionMap);
		}
		
		return totalNum;
	}

	public List<HashMap<String, String>> getRestRanking(HashMap<String, Object> optionMap, String regDate) {
		List<HashMap<String, String>> mapList = new ArrayList<HashMap<String, String>>();
		
		if (regDate.equals("0")) { // 기간 상관없이 랭킹
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

	public List<HashMap<String, String>> getReviewRanking(HashMap<String, Object> optionMap, String regDate) {
		List<HashMap<String, String>> mapList = new ArrayList<HashMap<String, String>>();
		
		if (regDate.equals("0")) { // 기간 상관없이 랭킹
			mapList = sqlSession.selectList("ranking.getNotDateReviewRanking", optionMap);
		}
		
		else if (regDate.equals("7")) {// 최근 일주일 랭킹
			mapList = sqlSession.selectList("ranking.getOneWeekReviewRanking", optionMap);
		}
		
		else if (regDate.equals("30")) {// 최근 한 달 랭킹
			mapList = sqlSession.selectList("ranking.getOneMonthReviewRanking", optionMap);
		}
		
		else if (regDate.equals("90")) {// 최근 3달 랭킹
			mapList = sqlSession.selectList("ranking.getThreeMonthReviewRanking", optionMap);
		}
		
		else if (regDate.equals("365")) {// 최근 1년 랭킹
			mapList = sqlSession.selectList("ranking.getOneYearReviewRanking", optionMap);
		}
		
		return mapList;
	}

	//인덱스 페이지 탑랭크 리뷰어가 추천한 맛집 이 곳의 맛집번호를 가져오는 메서드
	public HashMap<String, String> getTop5ScoreRest(String userSeq) {
		HashMap<String, String> seqList = sqlSession.selectOne("ranking.getTop5ScoreRest", userSeq);
		
		/*Collections.shuffle(seqList);
		
		String restSeq = seqList.get(0);
		*/
		
		
		return seqList;
	}

	public RestaurantVO getRestInfo(HashMap<String, String> seqList) {
		RestaurantVO restvo = sqlSession.selectOne("ranking.getRestInfo", seqList);
		return restvo;
	}

	public ReviewVO getReviewInfo(HashMap<String, String> seqList) {
		ReviewVO reviewvo = sqlSession.selectOne("ranking.getReviewInfo", seqList);
		return reviewvo;
	}

	public UserVO getUserInfo(HashMap<String, String> seqList) {
		UserVO uservo = sqlSession.selectOne("ranking.getUserInfo", seqList);
		return uservo;
	}

	public List<String> getRestAdInfo(HashMap<String, String> seqList) {
		List<String> adImage = sqlSession.selectList("ranking.getRestAdInfo", seqList);
		return adImage;
	}
	
}
