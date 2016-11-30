package com.go.mazzipmetro.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.UserService;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;


@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	@RequestMapping(value="/accountSelect.eat", method={RequestMethod.GET})
	public String accountSelect(){
		return "accountSelect";
	}
	
	@RequestMapping(value="/userRegister.eat", method={RequestMethod.GET})
	public String userRegister(){
		return "user/userRegister";
	}
	
	@RequestMapping(value="/userRegisterEnd.eat", method={RequestMethod.POST})
	public String userRegisterEnd(UserVO vo, HttpServletRequest req){
		
		int n = service.userRegister(vo);
		
		req.setAttribute("n", n);
		return "user/userRegisterEnd";
	}
	
	@RequestMapping(value="/restRegister.eat", method={RequestMethod.GET})
	public String restRegister(){
		return "user/restRegister";
	}
	
	@RequestMapping(value="/restRegisterEnd.eat", method={RequestMethod.GET})
	public String restRegisterEnd(RestaurantVO vo, HttpServletRequest req){
		
		int n = service.restRegister(vo);
		
		req.setAttribute("n", n);
		return "user/restRegisterEnd";

	}
}
