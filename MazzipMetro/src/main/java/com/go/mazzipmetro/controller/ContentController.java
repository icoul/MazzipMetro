package com.go.mazzipmetro.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.ContentService;
import com.go.mazzipmetro.vo.RestaurantVO;

@Controller
public class ContentController {

	@Autowired
	private ContentService service;
	
	// 메인 페이지의 메인배너 컨텐츠
	@RequestMapping(value="/mainContentsView.eat", method={RequestMethod.GET})
	public String mainContentsView(HttpServletRequest req, HttpServletResponse res){
		
		RestaurantVO rvo = service.getMainContents();
		List<String> adImage = service.getMainContentsAdImage(rvo.getRestSeq());
		
		req.setAttribute("rvo", rvo);
		req.setAttribute("adImage", adImage);
		
		return "content/mainContentsView";
	}
	
	// 측면 배너 컨텐츠
	@RequestMapping(value="/rightContentView.eat",method={RequestMethod.GET})
	public String rightContentView(HttpServletRequest req, HttpServletResponse res){
		
		List<RestaurantVO> rvoList = service.getRightContents();
		
		req.setAttribute("rvoList", rvoList);
		
		return "content/rightContentView";
	}

	
}
