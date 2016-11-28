package com.go.mazzipmetro.controller;

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
		
		
		return "msg";
		
	}
	//코인충전 팝업창
	@RequestMapping(value="/coinChar.eat", method={RequestMethod.GET})
	public String coinChar() {
		
		return "coinChar";
		
	}
	
	
}
