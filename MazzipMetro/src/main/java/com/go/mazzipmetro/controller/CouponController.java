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

import com.go.mazzipmetro.service.CouponService;
import com.go.mazzipmetro.vo.CouponVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class CouponController {

	@Autowired
	private CouponService service;
	
	@RequestMapping(value="/couponList.eat", method={RequestMethod.GET})
	public String couponList(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		String userSeq = loginUser.getUserSeq();
		String userSort = loginUser.getUserSort();
		
		List<HashMap<String,String>> couponList = new ArrayList<HashMap<String,String>>();
		
		if (userSort.equals("0") || userSort.equals("2")) {
			couponList = service.getUserCoupon(userSeq);
		}
		
		if (userSort.equals("1")) {
			couponList = service.getBossCoupon(userSeq);
			
			List<RestaurantVO> restList = service.getRestaurant(userSeq);
			req.setAttribute("restList", restList);
		}
		
		req.setAttribute("loginUser", loginUser);
		req.setAttribute("userSort", userSort);
		req.setAttribute("couponList", couponList);
		System.out.println("Ddd = " + couponList.size());
		
		// 페이징 처리
		String pageNum_str = req.getParameter("pageNum");
		
		if (pageNum_str == null) {
			pageNum_str = "1";
		}
		
		int pageNum = Integer.parseInt(pageNum_str); // 페이지번호
		
		int pageBar = 5; // 한 그룹당 보여줄 페이지 갯수
		int pageGroupNum = (pageNum/10)+1; // 해당 그룹 번호(1 = 1~10페이지까지)
		int totalNum = couponList.size(); // 총 갯수
		
		int startNum = (pageNum-1)/10+1; // 시작번호
		int endNum = startNum + 9; // 끝번호
		
		String html = "";
		
		if (pageGroupNum != 1) {
			html += "<a href='#' onClick = goNextPage('" + (startNum-1) + "');>[이전 10페이지]</a>&nbsp;|&nbsp;&nbsp;";
		}
		
		for (int i = startNum; i <= endNum; i++) {
			if (i == pageNum) {
				html += "<span style = 'color : red; font-weight : bold;'>"+i+"</span>";
				html += (i*pageBar < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else if (i != pageNum && ((i-1)*pageBar) < totalNum) {
				html += "<a href='#' onClick = goNextPage('" + i + "');><span style = 'color : black;'>"+i+"</span></a>";
				html += (i*pageBar < totalNum)?"&nbsp;|&nbsp;":"";
			}
			else {
				break;
			}
		}
		
		if ((pageGroupNum*100 - totalNum) < 0) {
			html += "<a href='#' onClick = goNextPage('" + (endNum+1) + "');>&nbsp;&nbsp;|&nbsp;[다음 10페이지]</a>";
		}
		
		req.setAttribute("html", html);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("pageBar", pageBar);
		
		return "coupon/couponList";
	}
	
	@RequestMapping(value="/couponBuy.eat", method={RequestMethod.POST})
	public String couponBuy(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		String userSeq = loginUser.getUserSeq();
		
		String userPoint = req.getParameter("userPoint");
		String couponNum = req.getParameter("couponNum");
		String myRest = req.getParameter("myRest");
		
		String[] myRestArr = myRest.split(",");
		String restSeq = myRestArr[0];
		String metroId = myRestArr[1];
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("userSeq", userSeq);
		map.put("userPoint", userPoint);
		map.put("couponNum", couponNum);
		map.put("restSeq", restSeq);
		map.put("metroId", metroId);
		
		int result = service.couponBuy(map);
		int check = Integer.parseInt(couponNum) + 1;
		
		String msg = "쿠폰 발행에 실패했습니다.";
		String loc = "couponList.eat";
		
		if (result == check) {
			msg = "쿠폰 발행에 성공했습니다.";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	}
	
	
	// 사업자가 쿠폰을 확인하는 메서드
	@RequestMapping(value="/couponConfirm.eat", method={RequestMethod.POST})
	public String couponConfirm(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		String couponSeq = req.getParameter("couponSeqConfirm");
		
		int result = service.couponConfirm(couponSeq);
		
		String msg = "올바른 쿠폰이 아닙니다.";
		String loc = "couponList.eat";
		
		if (result == 1) {
			msg = "쿠폰을 정상적으로 사용했습니다.";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	}
	
}
