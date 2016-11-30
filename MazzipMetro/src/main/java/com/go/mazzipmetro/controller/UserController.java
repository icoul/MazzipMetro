package com.go.mazzipmetro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.UserService;
import com.go.mazzipmetro.vo.RestaurantVO;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	@RequestMapping(value = "/ceoStatistics.eat", method = { RequestMethod.GET })
	public String ceoStatistics(HttpServletRequest req){
		String userseq = req.getParameter("userseq");
		
		if(userseq == null){
			userseq = "14";
		}
		
		
		
		List<RestaurantVO> restaurantList = service.getRestrauntList(userseq);
		
		
		req.setAttribute("restaurantList", restaurantList);
		return "ceoStatistics";
	}
}
