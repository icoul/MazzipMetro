package com.go.mazzipmetro.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.BossService;
import com.go.mazzipmetro.service.UserService;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class BossController {
	
	@Autowired
	private BossService service;
	@Autowired
	private UserService userService;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	
	//사업주가 코인을 충전할시 or 광고 구매시
	@RequestMapping(value="/bossCoinResi.eat", method={RequestMethod.GET})
	public String busiCoinResi(HttpServletRequest req) {
		HttpSession ses = req.getSession();
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		List<HashMap<String, String>> list = service.getRestSeq(loginUser.getUserSeq());
		
		req.setAttribute("list", list);
		
		return "boss/bossCoinResi";
		
	}
	
	
	//코인충전 팝업창
	@RequestMapping(value="/bossCoinChar.eat", method={RequestMethod.GET})
	public String coinChar() {
		
		return "boss/bossCoinChar";
		
	}
	
	//코인충전 완료시
	@RequestMapping(value="/bossCoinResiEnd.eat", method={RequestMethod.POST})
	public String bossCoinResiEnd(HttpServletRequest req, HttpSession ses){
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
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
			loginUser = (UserVO)ses.getAttribute("loginUser");
			loginUser = userService.getLoginUser(loginUser.getUserEmail());
			ses.setAttribute("loginUser", loginUser);
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "/boss/bossCoinResiEnd";
	}
	
	//파워배너 결제 
	@RequestMapping(value="/bossBannBuy.eat", method={RequestMethod.POST})
	public String bossBannBuy(HttpServletRequest req, HttpSession ses) throws Throwable{
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		HashMap<String, String> map = new HashMap<String, String>();
		String userSeq = req.getParameter("userSeq");
		String restSeq = req.getParameter("restSeq");
		String str_userPoint = req.getParameter("userPoint");

		
		map.put("userSeq", userSeq);
		map.put("restSeq", restSeq);
		map.put("userPoint", str_userPoint);
	
		
		
		int result=0;
		int userPoint = Integer.parseInt(str_userPoint); 
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
				
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
			loc ="javascript:location.href='bossCoinResi.eat';";
			
			ses = req.getSession();
			loginUser = (UserVO)ses.getAttribute("loginUser");
			loginUser = userService.getLoginUser(loginUser.getUserEmail());
			ses.setAttribute("loginUser", loginUser);
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		req.setAttribute("restSeq", restSeq);
		
		
		return "boss/bossContentBuy";
		
	}//end of bossBannBuy(HttpServletRequest req) throws Throwable-------------------
	
	
	
	//파워링크 결제
	@RequestMapping(value="/bossLinknBuy.eat", method={RequestMethod.POST})
	public String bossLinknBuy(HttpServletRequest req, HttpSession ses) throws Throwable{
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		
		String userSeq = req.getParameter("userSeq");
		String restSeq = req.getParameter("linkRestSeq");
		String str_userPoint = req.getParameter("userPoint");
		//System.out.println("확인용" + restSeq);
		
		map.put("userSeq", userSeq);
		map.put("restSeq", restSeq);
	
		int result=0;
		int userPoint = Integer.parseInt(str_userPoint); 
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
		//임의의 포인트 넣어줬음
		//int userPoint = 500000;
				
		//포인트잔액이 부족했을시
		if (userPoint < 500000) {
			msg ="포인트 잔액이 부족합니다. 코인을 충전하세요.";
			loc ="javascript:history.back();";
		}
		
		else if (userPoint >= 500000) {
			result = service.linkBuyUpdate(map); 
			result = service.linkInsert(map);
		}
		
		
		if (result < 0) {
			msg ="결제되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		else if (result > 0) {
			msg ="결제 되셨습니다.";
			loc ="javascript:location.href='bossCoinResi.eat';";
			ses = req.getSession();
			loginUser = (UserVO)ses.getAttribute("loginUser");
			loginUser = userService.getLoginUser(loginUser.getUserEmail());
			ses.setAttribute("loginUser", loginUser);
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "boss/bossContentBuy";
		
	}
	
	
	//추천광고 결제
	@RequestMapping(value="/bossRecomBuy.eat", method={RequestMethod.POST})
	public String bossRecomBuy(HttpServletRequest req, HttpSession ses) throws Throwable{
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		
		String userSeq = req.getParameter("userSeq");
		String restSeq = req.getParameter("recomRestSeq");
		String str_userPoint = req.getParameter("userPoint");
		//** 나중에 session 에서 vo를 가져와서 get(userPoint)해서 가져와야함.
		System.out.println("확인용"+restSeq);
		
		
		map.put("userSeq", userSeq);
		map.put("restSeq", restSeq);
	
		int result=0;
		int userPoint = Integer.parseInt(str_userPoint); 
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
				
		//포인트잔액이 부족했을시
		if (userPoint < 300000) {
			msg ="포인트 잔액이 부족합니다. 코인을 충전하세요.";
			loc ="javascript:history.back();";
		}
		
		else if (userPoint >= 300000) {
			result = service.recomBuyUpdate(map); 
			result = service.recomInsert(map);
		}
		
		
		if (result < 0) {
			msg ="결제되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		else if (result > 0) {
			msg ="결제 되셨습니다.";
			loc ="javascript:location.href='bossCoinResi.eat';";
			ses = req.getSession();
			loginUser = (UserVO)ses.getAttribute("loginUser");
			loginUser = userService.getLoginUser(loginUser.getUserEmail());
			ses.setAttribute("loginUser", loginUser);
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "boss/bossContentBuy";
		
	}
	
	
}