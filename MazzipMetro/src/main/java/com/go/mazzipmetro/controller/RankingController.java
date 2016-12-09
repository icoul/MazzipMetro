package com.go.mazzipmetro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.RankingService;


@Controller
public class RankingController {
	
	@Autowired
	private RankingService service; 
	
	/*--------------------------------------- 음식점 랭킹 ------------------------------------------------------*/
	// 역별로 음식점 랭킹
	@RequestMapping(value="/rankingRestMetro.eat", method={RequestMethod.GET})
	public String rankingRestMetro(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		String metroId = req.getParameter("metroId");
		
		return "ranking/rankingRestMetro";
	}
		
	// 기간별로 음식점 랭킹
	@RequestMapping(value="/rankingRestPeriod.eat", method={RequestMethod.GET})
	public String rankingRestPeriod(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingRestPeriod";
	}
	
	// 태그별로 음식점 랭킹
	@RequestMapping(value="/rankingRestTag.eat", method={RequestMethod.GET})
	public String rankingRestTag(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingRestTag";
	}
	
	// 역+태그별로 음식점 랭킹
	@RequestMapping(value="/rankingRestMetroTag.eat", method={RequestMethod.GET})
	public String rankingRestMetroTag(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingRestMetroTag";
	}
	
	// 기간+태그별로 음식점 랭킹
	@RequestMapping(value="/rankingRestPeriodTag.eat", method={RequestMethod.GET})
	public String rankingRestPeriodTag(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingRestPeriodTag";
	}
	
	// 역+기간별로 음식점 랭킹
	@RequestMapping(value="/rankingRestMetroPeriod.eat", method={RequestMethod.GET})
	public String rankingRestMetroPeriod(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingRestMetroPeriod";
	}
	
	// 종합 음식점 랭킹
	@RequestMapping(value="/rankingRestAll.eat", method={RequestMethod.GET})
	public String rankingRestAll(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		return "ranking/rankingRestAll";
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
