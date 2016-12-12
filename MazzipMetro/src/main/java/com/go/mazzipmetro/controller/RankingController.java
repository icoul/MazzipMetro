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
	
	/*--------------------------------------- 음식점 랭킹 ------------------------------------------------------*/
	// 역별로 음식점 랭킹
	@RequestMapping(value="/restRanking.eat", method={RequestMethod.GET})
	public String rankingRestMetro(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		// 랭킹에 필요한 각 파라미터
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		String regDate = req.getParameter("regDate");
		String[] bgTag = req.getParameterValues("bgTag");
		String[] mdTag = req.getParameterValues("mdTag");
		
		RankingRestVO rvo = new RankingRestVO(); // 랭킹 조건들을 담을 VO
		List<RankingRestVO> optionList = new ArrayList<RankingRestVO>(); 
		// VO를 담을 리스트. 조건의 갯수가 유저의 결정에 따라 달라지므로 유동적으로 대응 가능하도록 리스트를 사용.
		// 또한 Mybatis의 forEach는 리스트와 해쉬맵 밖에 못 받는다.
		
		HashMap<String, Object> optionMap = new HashMap<String, Object>();
		// 리스트를 담아줄 해쉬맵. 이걸 안 하면 forEach가 못 읽는다.
		
		if (metroId != null) {
			rvo.setParameter("metroid");
			rvo.setValue(metroId);
			optionList.add(rvo);
		}
		
		if (dongId != null) {
			rvo.setParameter("dongId");
			rvo.setValue(dongId);
			optionList.add(rvo);
		}
		
		if (bgTag != null) {
			for (int i = 0; i < bgTag.length; i++) {
				rvo.setParameter("restBgTag");
				rvo.setValue(bgTag[i]);
				optionList.add(rvo);
			}
		}
		
		if (mdTag != null) {
			for (int i = 0; i < mdTag.length; i++) {
				rvo.setParameter("restMdTag");
				rvo.setValue(mdTag[i]);
				optionList.add(rvo);
			}
		}
		
		optionMap.put("optionList", optionList);
		
		List<HashMap<String, String>> mapList = service.getRestRanking(optionMap, regDate);
		
		req.setAttribute("mapList", mapList);
		
		return "ranking/restRanking";
	}
	
	/*--------------------------------------- 리뷰 랭킹 ------------------------------------------------------*/
	// 역별로 리뷰 랭킹
	@RequestMapping(value="/rankingReviewMetro.eat", method={RequestMethod.GET})
	public String rankingReviewMetro(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewMetro";
	}
		
	// 기간별로 리뷰 랭킹
	@RequestMapping(value="/rankingReviewPeriod.eat", method={RequestMethod.GET})
	public String rankingReviewPeriod(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewPeriod";
	}
	
	// 태그별로 리뷰 랭킹
	@RequestMapping(value="/rankingReviewTag.eat", method={RequestMethod.GET})
	public String rankingReviewTag(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewTag";
	}
	
	// 역+태그별로 리뷰 랭킹
	@RequestMapping(value="/rankingReviewMetroTag.eat", method={RequestMethod.GET})
	public String rankingReviewMetroTag(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewMetroTag";
	}
	
	// 기간+태그별로 리뷰 랭킹
	@RequestMapping(value="/rankingReviewPeriodTag.eat", method={RequestMethod.GET})
	public String rankingReviewPeriodTag(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewPeriodTag";
	}
	
	// 역+기간별로 리뷰 랭킹
	@RequestMapping(value="/rankingReviewMetroPeriod.eat", method={RequestMethod.GET})
	public String rankingReviewMetroPeriod(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewMetroPeriod";
	}
	
	// 종합 리뷰 랭킹
	@RequestMapping(value="/rankingReviewAll.eat", method={RequestMethod.GET})
	public String rankingReviewAll(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingReviewAll";
	}
	
}
