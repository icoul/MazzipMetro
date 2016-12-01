package com.go.mazzipmetro.controller;

import java.util.HashMap;

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
	

	@RequestMapping(value="/test.eat", method={RequestMethod.GET})
	public String test(){
		return "test";
	}
	
	
	@RequestMapping(value="/accountSelect.eat", method={RequestMethod.GET})
	public String accountSelect(){
		return "accountSelect";
	}
	
	@RequestMapping(value="/userRegister.eat", method={RequestMethod.GET})
	public String userRegister(){
		return "userRegister";
	}
	
	@RequestMapping(value="/userRegisterEnd.eat", method={RequestMethod.POST})
	public String userRegisterEnd(UserVO vo, HttpServletRequest req){
		
		int n = service.userRegister(vo);
		
		req.setAttribute("n", n);
		return "userRegisterEnd";
	}
	
	@RequestMapping(value="/restRegister.eat", method={RequestMethod.GET})
	public String restRegister(){
		return "userRegister";
	}
	
	@RequestMapping(value="/restRegisterEnd.eat", method={RequestMethod.GET})
	public String restRegisterEnd(RestaurantVO vo, HttpServletRequest req){
		
		int n = service.restRegister(vo);
		
		req.setAttribute("n", n);
		return "restRegisterEnd";

	}
	
	//nos
	@RequestMapping(value = "/myQna.eat", method = RequestMethod.GET)
	public String myQnA(HttpServletRequest req) {
		String userSeq = req.getParameter("userSeq");
		
		if(userSeq == null){
			userSeq = "1";
		}
		
		req.setAttribute("userSeq", userSeq);
		return "user/myQna";
	}
	
	@RequestMapping(value = "/myQnaRegister.eat", method = RequestMethod.POST)
	public String myQnaRegister(HttpServletRequest req) {
		String userSeq = req.getParameter("userSeq");
		String qnaQuiry = req.getParameter("qnaQuiry");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaComment = req.getParameter("qnaComment");
		   
		HashMap<String,String> hashMap = new HashMap<String,String>();
		hashMap.put("userSeq", userSeq);
		hashMap.put("qnaQuiry", qnaQuiry);
		hashMap.put("qnaSubject", qnaSubject);
		hashMap.put("qnaComment", qnaComment);
		
		int n =  service.qnaRegister(hashMap);
		
		if(n == 0){
			req.setAttribute("msg", "문의등록이 실패하였습니다.");
			req.setAttribute("loc", "javascript:history.back();");
		}else if(n==1){
			req.setAttribute("msg", "문의등록이 성공하였습니다.");
			req.setAttribute("loc", "myQnaList.eat?userSeq=" + userSeq);
		}
		
		return "user/msg";
	}
	
	@RequestMapping(value = "/myQnaList.eat", method = RequestMethod.GET)
	public String myQnAList(HttpServletRequest req) {
		
		
		return "user/myQnaList";
	}
}
