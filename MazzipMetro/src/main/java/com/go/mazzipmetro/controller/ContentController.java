package com.go.mazzipmetro.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.ContentService;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class ContentController {

	@Autowired
	private ContentService service;
	
	// 메인 페이지의 메인배너 컨텐츠
	@RequestMapping(value="/mainContentsView.eat", method={RequestMethod.GET})
	public String mainContentsView(HttpServletRequest req, HttpServletResponse res){
		
		RestaurantVO rvo = service.getMainContents();
		
		req.setAttribute("rvo", rvo);
		
		return "content/mainContentsView";
	}
	
	// 측면 배너 컨텐츠
	@RequestMapping(value="/rightContentView.eat",method={RequestMethod.GET})
	public String rightContentView(HttpServletRequest req, HttpServletResponse res){
		
		List<RestaurantVO> rvoList = service.getRightContents();
		
		req.setAttribute("rvoList", rvoList);
		
		return "content/rightContentView";
	}
	
	
	// 검색 상단 컨텐츠
	@RequestMapping(value="/powerLinkContent.eat",method={RequestMethod.GET})
	public String powerLinkContent(HttpServletRequest req, HttpServletResponse res){
		
		List<RestaurantVO> rvoList = service.getPowerLinkContents();
		
		req.setAttribute("rvoList", rvoList);
		
		return "content/powerLinkContent";
	}
	
	// 가고싶다 배너 컨텐츠
	@RequestMapping(value="/wantGoContentView.eat",method={RequestMethod.GET})
	public String wantGoContentView(HttpServletRequest req, HttpServletResponse res){
		
		RestaurantVO vo = service.getWantGoContents();
		
		req.setAttribute("vo", vo);
		
		//동현_로그인 했다면, 해당 업장이 사용자의 가고싶다에 담겨있는 음식점인지 check!
		if(req.getSession().getAttribute("loginUser") != null){
			HashMap<String, String> map = new HashMap<>();
			map.put("restSeq", vo.getRestSeq());
			map.put("userSeq", ((UserVO)req.getSession().getAttribute("loginUser")).getUserSeq());

			// 사용자의 가고싶다의 담겨있는 경우만, req객체에 담는다.
			if(service.checkWantToGo(map) > 0) 
				req.setAttribute("userWantToGoHere", 1);
			
		}
		//가고싶다 삭제시 참고용(세션)
		req.getSession().setAttribute("restSeq_wantToGoContentView", vo.getRestSeq());
		
		System.out.println(">>>>>>>>>>>>>>>>"+req.getSession().getAttribute("restSeq_wantToGoContentView")); 
		
		return "content/wantGoContentView";
	}
}
