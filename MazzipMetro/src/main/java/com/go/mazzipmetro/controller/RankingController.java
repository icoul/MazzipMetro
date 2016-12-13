package com.go.mazzipmetro.controller;

import java.util.ArrayList;
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
import com.go.mazzipmetro.vo.RankingRestVO;


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
	@RequestMapping(value="/restRankingEnd.eat", method={RequestMethod.POST})
	public String restRankingEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		String regDate = req.getParameter("regDate");
		String[] bgTag = req.getParameterValues("bgTag");
		String[] mdTag = req.getParameterValues("mdTag");
		
		RankingRestVO rvo = new RankingRestVO(); // 랭킹 조건들을 담을 VO
		ArrayList<RankingRestVO> optionList = new ArrayList<RankingRestVO>(); 
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
			rvo = new RankingRestVO(); 
			rvo.setParameter("dongId");
			rvo.setValue(dongId);
			optionList.add(rvo);
		}
		
		if (regDate == null) {
			regDate = "0";
		}
		
		if (bgTag != null) {
			for (int i = 0; i < bgTag.length; i++) {
				rvo = new RankingRestVO();
				rvo.setParameter("restBgTag");
				rvo.setValue(bgTag[i]);
				optionList.add(rvo);
			}
		}
		
		if (mdTag != null) {
			for (int i = 0; i < mdTag.length; i++) {
				rvo = new RankingRestVO();
				rvo.setParameter("restMdTag");
				rvo.setValue(mdTag[i]);
				optionList.add(rvo);
			}
		}
		
		optionMap.put("optionList", optionList);
		
		List<HashMap<String, String>> mapList = service.getRestRanking(optionMap, regDate);
		
		req.setAttribute("mapList", mapList);
		
		// 페이징 처리
		String pageNum_str = req.getParameter("pageNum");
		System.out.println("pageNum_str = " + pageNum_str);
		if (pageNum_str == null) {
			pageNum_str = "1";
		}
		
		int pageNum = Integer.parseInt(pageNum_str); // 페이지번호
		
		int pageBar = 10; // 한 그룹당 보여줄 페이지 갯수
		int pageGroupNum = (pageNum/10)+1; // 해당 그룹 번호(1 = 1~10페이지까지)
		int totalNum = mapList.size(); // 총 갯수
		
		int startNum = (pageNum-1)/10+1; // 시작번호
		int endNum = startNum + 9; // 끝번호
		
		String html = "";
		
		if (pageGroupNum != 1) {
			html += "<a href='#' onClick = goRestRanking('" + (startNum-1) + "');>[이전 10페이지]</a>&nbsp;|&nbsp;&nbsp;";
		}
		
		for (int i = startNum; i <= endNum; i++) {
			if (i == pageNum) {
				html += "<span style = 'color : red; font-weight : bold;'>"+i+"</span>";
				html += ((i)*10 < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else if (i != pageNum && ((i-1)*10) < totalNum) {
				html += "<a href='#' onClick = goRestRanking('" + i + "');><span style = 'color : black;'>"+i+"</span></a>";
				html += ((i)*10 < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else {
				break;
			}
		}
		
		if ((pageGroupNum*100 - totalNum) < 0) {
			html += "<a href='#' onClick = goRestRanking('" + (endNum+1) + "');>&nbsp;&nbsp;|&nbsp;[다음 10페이지]</a>";
		}
		
		req.setAttribute("html", html);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("pageBar", pageBar);
		
		return "ranking/restRankingEnd";
	}
	
	/*--------------------------------------- 리뷰 랭킹 ------------------------------------------------------*/
	// 역별로 음식점 랭킹
		@RequestMapping(value="/reviewRanking.eat", method={RequestMethod.GET})
		public String reviewRanking(HttpServletRequest req, HttpServletResponse res, HttpSession session){
			
			// 랭킹에 필요한 각 파라미터
			String metroId = req.getParameter("metroId");
			String dongId = req.getParameter("dongId");
			String regDate = req.getParameter("regDate");
			String[] bgTag = req.getParameterValues("bgTag");
			String[] mdTag = req.getParameterValues("mdTag");
			
			RankingRestVO rvo = new RankingRestVO(); // 랭킹 조건들을 담을 VO
			ArrayList<RankingRestVO> optionList = new ArrayList<RankingRestVO>(); 
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
				rvo = new RankingRestVO(); 
				rvo.setParameter("dongId");
				rvo.setValue(dongId);
				optionList.add(rvo);
			}
			
			if (regDate == null) {
				regDate = "0";
			}
			
			if (bgTag != null) {
				for (int i = 0; i < bgTag.length; i++) {
					rvo = new RankingRestVO();
					rvo.setParameter("restBgTag");
					rvo.setValue(bgTag[i]);
					optionList.add(rvo);
				}
			}
			
			if (mdTag != null) {
				for (int i = 0; i < mdTag.length; i++) {
					rvo = new RankingRestVO();
					rvo.setParameter("restMdTag");
					rvo.setValue(mdTag[i]);
					optionList.add(rvo);
				}
			}
			
			optionMap.put("optionList", optionList);
			
			List<HashMap<String, String>> mapList = service.getRestRanking(optionMap, regDate);
			
			req.setAttribute("mapList", mapList);
			
			// 페이징 처리
			String pageNum_str = req.getParameter("pageNum");
			System.out.println("pageNum_str = " + pageNum_str);
			if (pageNum_str == null) {
				pageNum_str = "1";
			}
			
			int pageNum = Integer.parseInt(pageNum_str); // 페이지번호
			
			int pageBar = 10; // 한 그룹당 보여줄 페이지 갯수
			int pageGroupNum = (pageNum/10)+1; // 해당 그룹 번호(1 = 1~10페이지까지)
			int totalNum = mapList.size(); // 총 갯수
			
			int startNum = (pageNum-1)/10+1; // 시작번호
			int endNum = startNum + 9; // 끝번호
			
			String html = "";
			
			if (pageGroupNum != 1) {
				html += "<a href='#' onClick = goRestRanking('" + (startNum-1) + "');>[이전 10페이지]</a>&nbsp;|&nbsp;&nbsp;";
			}
			
			for (int i = startNum; i <= endNum; i++) {
				if (i == pageNum) {
					html += "<span style = 'color : red; font-weight : bold;'>"+i+"</span>";
					html += ((i)*10 < totalNum)?"&nbsp;|&nbsp;":"";
				}
				else if (i != pageNum && ((i-1)*10) < totalNum) {
					html += "<a href='#' onClick = goRestRanking('" + i + "');><span style = 'color : black;'>"+i+"</span></a>";
					html += ((i)*10 < totalNum)?"&nbsp;|&nbsp;":"";
				}
				else {
					break;
				}
			}
			
			if ((pageGroupNum*100 - totalNum) < 0) {
				html += "<a href='#' onClick = goRestRanking('" + (endNum+1) + "');>&nbsp;&nbsp;|&nbsp;[다음 10페이지]</a>";
			}
			
			req.setAttribute("html", html);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("pageBar", pageBar);
			
			return "ranking/reviewRanking";
		}
	
}
