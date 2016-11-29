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
	
	
	// 사업주가 코인을 충전할시 or 광고 구매시 ajax로 인해  업로드
	@RequestMapping(value="/busiCoinResi.eat", method={RequestMethod.GET})
	public String busiCoinResi() {
		
		return "busiCoinResi";
		
	}
	
	/*@RequestMapping(value="/busiCoinResiEnd.eat", method={RequestMethod.GET})
	public String busiCoinResiEnd(HttpServletRequest req, HttpServletResponse res) {
		String userPoint = req.getParameter("userPoint");
		String userSeq = req.getParameter("userSeq");
		
		if(userSeq == null) {
			userSeq = "1";
		}
		
		int result = service.coinUpdate(userPoint); 
		
		int result = 1;
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
		if (result < 0) {
			msg ="코인이 충전되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		if (result > 0) {
			msg ="충전되셨습니다.";
			loc ="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
		
	}*/
	//코인충전 팝업창
	@RequestMapping(value="/coinChar.eat", method={RequestMethod.GET})
	public String coinChar() {
		
		return "coinChar";
		
	}
	
	@RequestMapping(value="/busiCoinResiEnd.eat", method={RequestMethod.GET})
	public String busiCoinResiEnd(HttpServletRequest req){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		String str_userPoint = req.getParameter("userPoint");
		
		int userPoint = Integer.parseInt(str_userPoint); 
		
		String userSeq = req.getParameter("userSeq");
		
		map.put("userSeq", userSeq);
		map.put("userPoint", userPoint);
		
		/*if(userSeq == null) {
			userSeq = "7";
		}
		*/
		
		int result = service.coinUpdate(map); 
		
		//int result = 1;
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
		if (result < 0) {
			msg ="코인이 충전되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		if (result > 0) {
			msg ="충전되셨습니다.";
			loc ="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "busiCoinResiEnd";
	}
	
	
}