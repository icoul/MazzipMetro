package com.go.mazzipmetro.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.BossService;

@Controller
public class BossController {
	
	@Autowired
	private BossService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	
	//사업주가 코인을 충전할시 or 광고 구매시 ajax로 인해  업로드
	@RequestMapping(value="/busiCoinResi.eat", method={RequestMethod.GET})
	public String busiCoinResi() {
		
		return "busiCoinResi";
		
	}
	
	
	//코인충전 팝업창
	@RequestMapping(value="/coinChar.eat", method={RequestMethod.GET})
	public String coinChar() {
		
		return "coinChar";
		
	}
	
	@RequestMapping(value="/busiCoinResiEnd.eat", method={RequestMethod.POST})
	public String busiCoinResiEnd(HttpServletRequest req){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		String str_userPoint = req.getParameter("userPoint");
		
		int userPoint = Integer.parseInt(str_userPoint); 
		
		String userSeq = req.getParameter("userSeq");
		
		map.put("userSeq", userSeq);
		map.put("userPoint", userPoint);
		
		int result = service.coinUpdate(map); 
		
		String msg = "";
		String loc ="javascript:history.back();";
		
		if (result < 0) {
			msg ="코인이 충전되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		else if (result > 0) {
			msg ="충전되셨습니다.";
			loc ="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "busiCoinResiEnd";
	}
	
	//파워배너 결제 
	@RequestMapping(value="/bannBuy.eat", method={RequestMethod.POST})
	public String bannBuy(HttpServletRequest req) {
		
		
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		
		String userSeq = req.getParameter("userSeq");
		String restSeq = req.getParameter("restSeq");
		String contentSeq = req.getParameter("contentSeq");
		
		
		map.put("userSeq", userSeq);
		map.put("restSeq", restSeq);
		map.put("contentSeq", contentSeq);
	
		int result=0;
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
		//임의의 포인트 넣어줬음
		int userPoint =1000000;
		
		//포인트잔액이 부족했을시
		if (userPoint < 1000000) {
			msg ="포인트 잔액이 부족합니다. 코인을 충전하세요.";
			loc ="javascript:history.back();";
		}
		
		else if (userPoint >= 1000000) {
			result = service.bannBuyUpdate(map); 
			result = service.bannInsert(map);
		}
		
		
		if (result < 0) {
			msg ="결제되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		else if (result > 0) {
			msg ="결제 되셨습니다.";
			loc ="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "bannBuy";
		
	}
	
}