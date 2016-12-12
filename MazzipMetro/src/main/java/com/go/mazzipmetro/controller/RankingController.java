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
		
		RankingRestVO rvo = new RankingRestVO();
		List<RankingRestVO> optionList = new ArrayList<RankingRestVO>();
		HashMap<String, Object> optionMap = new HashMap<String, Object>();
		
		/*rvo.setParameter("metroid");
		rvo.setValue("2001");
		optionList.add(rvo);*/
		optionMap.put("optionList", optionList);
		
		List<HashMap<String, String>> mapList = service.getRestRanking(optionMap);
		
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
