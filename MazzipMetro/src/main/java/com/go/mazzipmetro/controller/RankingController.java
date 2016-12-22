package com.go.mazzipmetro.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.RankingService;
import com.go.mazzipmetro.vo.RankingVO;
import com.go.mazzipmetro.vo.RestaurantAdVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;


@Controller
public class RankingController {
	
	@Autowired
	private RankingService service; 
	
	@RequestMapping(value="/ranking.eat", method={RequestMethod.GET})
	public String ranking(){
		
		return "ranking/ranking";
	}
	
	// 지하철 검색
	@RequestMapping(value="/metroSearch.eat", method={RequestMethod.GET})
	public String metroSearch(HttpServletRequest req, HttpServletResponse res){
		
		String searchVar = req.getParameter("searchVar");
		
		if (searchVar == null) {
			return "ranking/metroSearch";
		}
		
		List<HashMap<String, String>> metro = service.searchMetroName(searchVar);
		
		req.setAttribute("searchVar", searchVar);
		req.setAttribute("searchMetro", metro);
		
		return "ranking/metroSearch";
	}
	
	// 지하철 검색 자동글완성
	@RequestMapping(value="/metroKeyUp.eat", method={RequestMethod.GET})
	public String metroKeyUp(HttpServletRequest req, HttpServletResponse res){
		
		String metroName = req.getParameter("metroName");
		
		List<HashMap<String, String>> metro = service.searchMetroName(metroName);
		
		req.setAttribute("metro", metro);
		
		return "ranking/metroKeyUp";
	}
	
	// 동 검색
	@RequestMapping(value="/dongSearch.eat", method={RequestMethod.GET})
	public String dongSearch(HttpServletRequest req, HttpServletResponse res){
		
		String searchVar = req.getParameter("searchVar");
		
		if (searchVar == null) {
			return "ranking/dongSearch";
		}
		
		List<HashMap<String, String>> dong = service.searchDongName(searchVar);
		
		req.setAttribute("searchVar", searchVar);
		req.setAttribute("searchDong", dong);
		
		return "ranking/dongSearch";
	}
	
	// 동 검색 자동글완성
	@RequestMapping(value="/dongKeyUp.eat", method={RequestMethod.GET})
	public String dongKeyUp(HttpServletRequest req, HttpServletResponse res){
		
		String dongName = req.getParameter("dongName");
		
		List<HashMap<String, String>> dong = service.searchDongName(dongName);
		
		req.setAttribute("dong", dong);
		
		return "ranking/dongKeyUp";
	}
	
	
	/*--------------------------------------- 음식점 랭킹 ------------------------------------------------------*/
	
	@RequestMapping(value="/restRanking.eat", method={RequestMethod.GET})
	public String restRanking(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/restRanking";
	}
	
	// 역별로 음식점 랭킹
	@RequestMapping(value="/restRankingEnd.eat", method={RequestMethod.GET})
	public String restRankingEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		String regDate = req.getParameter("regDate");
		String[] bgTag = req.getParameterValues("bgTag");
		String[] mdTag = req.getParameterValues("mdTag");
		
		HashMap<String, Object> optionMap = restRankingOptionMethod(metroId, dongId, bgTag, mdTag);
		
		// 페이징 처리
		String pageNum_str = req.getParameter("pageNum");
		
		if (pageNum_str == null) {
			pageNum_str = "1";
		}
		
		int pageNum = Integer.parseInt(pageNum_str); // 페이지번호
		
		int pageBar = 10; // 한 그룹당 보여줄 페이지 갯수
		int pageGroupNum = ((pageNum-1)/10)+1; // 해당 그룹 번호(1 = 1~10페이지까지)
		int startNum = (pageNum-1)/10*10+1; // 시작번호
		int endNum = startNum + 9; // 끝번호
		
		int totalNum = service.getTotalRestNum(optionMap, regDate); // 총 갯수
		
		int rankStartNum = ((pageNum-1)*10)+1;
		int rankEndNum = rankStartNum+9;
		
		optionMap.put("rankStartNum", rankStartNum);
		optionMap.put("rankEndNum", rankEndNum);
		
		List<HashMap<String, String>> mapList = restRankingMethod(regDate, optionMap);
		req.setAttribute("mapList", mapList);
		
		String html = "";
		
		if (pageGroupNum != 1) {
			html += "<a href='#' onClick = goRestRanking('" + (startNum-1) + "');>[이전 10페이지]</a>&nbsp;&nbsp;&nbsp;";
		}
		
		for (int i = startNum; i <= endNum; i++) {
			if (i == pageNum) {
				html += "<span style = 'color : red; font-weight : bold;'>"+i+"</span>";
				html += (i*pageBar < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else if (i != pageNum && ((i-1)*pageBar) < totalNum) {
				html += "<a href='#' onClick = goRestRanking('" + i + "');><span style = 'color : black;'>"+i+"</span></a>";
				html += (i*pageBar < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else {
				break;
			}
		}
		
		if ((pageGroupNum*100 - totalNum) < 0) {
			html += "<a href='#' onClick = goRestRanking('" + (endNum+1) + "');>&nbsp;&nbsp;[다음 10페이지]</a>";
		}
		
		req.setAttribute("html", html);
		
		return "ranking/restRankingEnd";
	}
	
	/*--------------------------------------- 리뷰 기반 사용자 랭킹 ------------------------------------------------------*/
	
	@RequestMapping(value="/reviewRanking.eat", method={RequestMethod.GET})
	public String reviewRanking(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/reviewRanking";
	}
	
	@RequestMapping(value="/reviewRankingEnd.eat", method={RequestMethod.GET})
	public String reviewRankingEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		String regDate = req.getParameter("regDate");
		String[] bgTag = req.getParameterValues("bgTag");
		String[] mdTag = req.getParameterValues("mdTag");
		
		HashMap<String, Object> optionMap = reviewRankingOptionMethod(metroId, dongId, bgTag, mdTag);
		
		// 페이징 처리
		String pageNum_str = req.getParameter("pageNum");

		if (pageNum_str == null) {
			pageNum_str = "1";
		}
		
		int pageNum = Integer.parseInt(pageNum_str); // 페이지번호
		
		int pageBar = 10; // 한 그룹당 보여줄 페이지 갯수
		int pageGroupNum = ((pageNum-1)/10)+1; // 해당 그룹 번호(1 = 1~10페이지까지)
		int startNum = (pageNum-1)/10*10+1; // 시작번호
		int endNum = startNum + 9; // 끝번호
		
		int totalNum = service.getTotalReviewNum(optionMap, regDate); // 총 갯수
		
		int rankStartNum = ((pageNum-1)*10)+1;
		int rankEndNum = rankStartNum+9;
		
		optionMap.put("rankStartNum", rankStartNum);
		optionMap.put("rankEndNum", rankEndNum);
		
		List<HashMap<String, String>> mapList = reviewRankingMethod(regDate, optionMap);
		req.setAttribute("mapList", mapList);
		
		String html = "";
		
		if (pageGroupNum != 1) {
			html += "<a href='#' onClick = goReviewRanking('" + (startNum-1) + "');>[이전 10페이지]</a>&nbsp;|&nbsp;&nbsp;";
		}
		
		for (int i = startNum; i <= endNum; i++) {
			if (i == pageNum) {
				html += "<span style = 'color : red; font-weight : bold;'>"+i+"</span>";
				html += (i*10 < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else if (i != pageNum && ((i-1)*pageBar) < totalNum) {
				html += "<a href='#' onClick = goReviewRanking('" + i + "');><span style = 'color : black;'>"+i+"</span></a>";
				html += (i*10 < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else {
				break;
			}
		}
		
		if ((pageGroupNum*100 - totalNum) < 0) {
			html += "<a href='#' onClick = goReviewRanking('" + (endNum+1) + "');>&nbsp;&nbsp;|&nbsp;[다음 10페이지]</a>";
		}
		
		req.setAttribute("html", html);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("pageBar", pageBar);
		
		return "ranking/reviewRankingEnd";
	}
	
	
	// 인덱스 페이지에 업장 랭킹 탑 5를 보여주는 메서드
	@RequestMapping(value="/indexTop5RankView.eat", method={RequestMethod.GET})
	public String indexTop5RankView(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String metroId = "";
		String dongId = "";
		String regDate = null;
		String[] bgTag = null;
		String[] mdTag = null;
		
		HashMap<String, Object> optionMap = restRankingOptionMethod(metroId, dongId, bgTag, mdTag);
		
		optionMap.put("rankStartNum", 1);
		optionMap.put("rankEndNum", 5);
		
		List<HashMap<String, String>> mapList = restRankingMethod(regDate, optionMap);
		
		req.setAttribute("mapList", mapList);
		
		return "ranking/indexTop5RankView";
	}
	
	// 메트로맵에 리뷰어가 선택한 맛집을 보여주는 메서드
	@RequestMapping(value="/metroMapRestRanking.eat", method={RequestMethod.GET})
	public String metroMapRestRanking(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		String regDate = req.getParameter("regDate");
		String[] bgTag = req.getParameterValues("bgTag");
		String[] mdTag = req.getParameterValues("mdTag");
		
		HashMap<String, Object> optionMap = restRankingOptionMethod(metroId, dongId, bgTag, mdTag);
		
		// 페이징 처리
		String pageNum_str = req.getParameter("pageNum");
		
		if (pageNum_str == null) {
			pageNum_str = "1";
		}
		
		int pageNum = Integer.parseInt(pageNum_str); // 페이지번호
		
		int pageBar = 10; // 한 그룹당 보여줄 페이지 갯수
		int pageGroupNum = ((pageNum-1)/10)+1; // 해당 그룹 번호(1 = 1~10페이지까지)
		int startNum = (pageNum-1)/10*10+1; // 시작번호
		int endNum = startNum + 9; // 끝번호
		
		int totalNum = service.getTotalRestNum(optionMap, regDate); // 총 갯수
		
		int rankStartNum = ((pageNum-1)*5)+1;
		int rankEndNum = rankStartNum+4;
		
		optionMap.put("rankStartNum", rankStartNum);
		optionMap.put("rankEndNum", rankEndNum);
		
		List<HashMap<String, String>> mapList = restRankingMethod(regDate, optionMap);
		req.setAttribute("mapList", mapList);
		
		String html = "";
		
		if (pageGroupNum != 1) {
			html += "<a href='#' onClick = goRestRanking('" + (startNum-1) + "');>[이전 10페이지]</a>&nbsp;&nbsp;&nbsp;";
		}
		
		for (int i = startNum; i <= endNum; i++) {
			if (i == pageNum) {
				html += "<span style = 'color : red; font-weight : bold;'>"+i+"</span>";
				html += (i*pageBar < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else if (i != pageNum && ((i-1)*pageBar) < totalNum) {
				html += "<a href='#' onClick = goRestRanking('" + i + "');><span style = 'color : black;'>"+i+"</span></a>";
				html += (i*pageBar < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else {
				break;
			}
		}
		
		if ((pageGroupNum*100 - totalNum) < 0) {
			html += "<a href='#' onClick = goRestRanking('" + (endNum+1) + "');>&nbsp;&nbsp;[다음 10페이지]</a>";
		}
		
		req.setAttribute("html", html);
		
		return "ranking/metroMapRestRanking";
	}
	
	//인덱스 페이지 탑랭크 리뷰어가 추천한 맛집 이 곳
	@RequestMapping(value="/topReviewerRecommend.eat", method={RequestMethod.GET})
	public String topReviewerRecommend(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String regDate = "0";
		
		String metroId = "";
		String dongId = "";
		String[] bgTag = null;
		String[] mdTag = null;
		
		HashMap<String, Object> optionMap = restRankingOptionMethod(metroId, dongId, bgTag, mdTag);
		
		optionMap.put("rankStartNum", 1);
		optionMap.put("rankEndNum", 5);
		
		List<HashMap<String, String>> mapList = reviewRankingMethod(regDate, optionMap);
		
		Collections.shuffle(mapList);
		
		String userSeq = mapList.get(0).get("userSeq");
		HashMap<String, String> seqList = service.getTop5ScoreRest(userSeq);
		
		seqList.put("userSeq", userSeq);
		
		RestaurantVO restvo = service.getRestInfo(seqList);
		ReviewVO reviewvo = service.getReviewInfo(seqList);
		UserVO uservo = service.getUserInfo(seqList);
		List<String> adImage = service.getRestAdInfo(seqList);
		
		req.setAttribute("restvo", restvo);
		req.setAttribute("reviewvo", reviewvo);
		req.setAttribute("uservo", uservo);
		req.setAttribute("adImage", adImage);
		
		return "ranking/topReviewerRecommend";
	}
	
	
	// 랭킹 메소드 (앞으로 이런저런 곳에 쓰려면 다양한 패턴으로 ajax에 받아올 필요가 있음
	//			그런데 Controller에서 하는 일은 페이징 처리 외에 항상 같기 때문에 매번 복붙하는 건 비효율적
	//          그래서 랭킹 관련 기능은 따로 빼서 메소드로 만들기로 함)
	
	// 음식점 랭킹을 가져오기 위한 옵션들을 담는 HashMap 제작 메서드
	public HashMap<String, Object> restRankingOptionMethod
						(String metroId, String dongId, String[] bgTag, String[] mdTag){
		RankingVO rvo = new RankingVO(); // 랭킹 조건들을 담을 VO
		ArrayList<RankingVO> optionList = new ArrayList<RankingVO>(); 
		// VO를 담을 리스트. 조건의 갯수가 유저의 결정에 따라 달라지므로 유동적으로 대응 가능하도록 리스트를 사용.
		// 또한 Mybatis의 forEach는 리스트와 해쉬맵 밖에 못 받는다.
		
		HashMap<String, Object> optionMap = new HashMap<String, Object>();
		// 리스트를 담아줄 해쉬맵. 이걸 안 하면 forEach가 못 읽는다.
		
		if (!metroId.equals("")) {
			rvo.setParameter("metroid");
			rvo.setValue(metroId);
			optionList.add(rvo);
		}
		
		if (!dongId.equals("")) {
			rvo = new RankingVO(); 
			rvo.setParameter("dongId");
			rvo.setValue(dongId);
			optionList.add(rvo);
		}
		
		if (bgTag != null) {
			for (int i = 0; i < bgTag.length; i++) {
				rvo = new RankingVO();
				rvo.setParameter("restBgTag");
				rvo.setValue(bgTag[i]);
				optionList.add(rvo);
			}
		}
		
		if (mdTag != null) {
			for (int i = 0; i < mdTag.length; i++) {
				rvo = new RankingVO();
				rvo.setParameter("restMdTag");
				rvo.setValue(mdTag[i]);
				optionList.add(rvo);
			}
		}
		
		optionMap.put("optionList", optionList);
		
		return optionMap;
		
	}
	
	// 음식점 랭킹 메소드
	public List<HashMap<String, String>> restRankingMethod(String regDate, HashMap<String, Object> optionMap){
		
		if (regDate == null) {
			regDate = "0";
		}
		
		List<HashMap<String, String>> mapList = service.getRestRanking(optionMap, regDate);
		
		return mapList;
	}
	
	
	// 리뷰 랭킹을 가져오기 위한 옵션들을 담는 HashMap 제작 메서드
	public HashMap<String, Object> reviewRankingOptionMethod
						(String metroId, String dongId, String[] bgTag, String[] mdTag){
		RankingVO rvo = new RankingVO(); // 랭킹 조건들을 담을 VO
		ArrayList<RankingVO> optionList = new ArrayList<RankingVO>(); 
		// VO를 담을 리스트. 조건의 갯수가 유저의 결정에 따라 달라지므로 유동적으로 대응 가능하도록 리스트를 사용.
		// 또한 Mybatis의 forEach는 리스트와 해쉬맵 밖에 못 받는다.
		
		HashMap<String, Object> optionMap = new HashMap<String, Object>();
		// 리스트를 담아줄 해쉬맵. 이걸 안 하면 forEach가 못 읽는다.
		
		if (!metroId.equals("")) {
			rvo.setParameter("M.metroId");
			rvo.setValue(metroId);
			optionList.add(rvo);
		}
		
		if (!dongId.equals("")) {
			rvo = new RankingVO(); 
			rvo.setParameter("D.dongId");
			rvo.setValue(dongId);
			optionList.add(rvo);
		}
		
		if (bgTag != null) {
			for (int i = 0; i < bgTag.length; i++) {
				rvo = new RankingVO();
				rvo.setParameter("restBgTag");
				rvo.setValue(bgTag[i]);
				optionList.add(rvo);
			}
		}
		
		if (mdTag != null) {
			for (int i = 0; i < mdTag.length; i++) {
				rvo = new RankingVO();
				rvo.setParameter("restMdTag");
				rvo.setValue(mdTag[i]);
				optionList.add(rvo);
			}
		}
		
		optionMap.put("optionList", optionList);
		
		return optionMap;
		
	}
	
	// 리뷰 사용자 관련 랭킹 메소드
	public List<HashMap<String, String>> reviewRankingMethod(String regDate, HashMap<String, Object> optionMap){
		
		if (regDate == null) {
			regDate = "0";
		}
		
		List<HashMap<String, String>> mapList = service.getReviewRanking(optionMap, regDate);
		
		return mapList;
	}
}
