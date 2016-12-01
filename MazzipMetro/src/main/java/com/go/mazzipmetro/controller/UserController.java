package com.go.mazzipmetro.controller;


import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import org.json.JSONObject;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.service.UserService;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;


@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/accountSelect.eat", method={RequestMethod.GET})
	public String accountSelect(){
		return "accountSelect";
	}
	
	@RequestMapping(value="/userRegister1.eat", method={RequestMethod.GET})
	public String userRegister1(HttpServletRequest req){
		String type =  req.getParameter("type");
		req.setAttribute("type", type);
		return "userRegister1";
	}
	
	@RequestMapping(value="/userRegister2.eat", method={RequestMethod.POST})
	public String userRegister2(HttpServletRequest req){
		String userSort =  req.getParameter("userSort");
		req.setAttribute("userSort", userSort);
		return "userRegister2";
	}
	
	@RequestMapping(value="/userRegisterEnd.eat", method={RequestMethod.POST})
	public String userRegisterEnd(UserVO vo, MultipartHttpServletRequest req, HttpSession session){
		
		
		if(!vo.getAttach().isEmpty()) {
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources"+ File.separator +"files";
			
			String newFileName = "";
			byte[] bytes = null;
			
			try {
				bytes = vo.getAttach().getBytes();
				newFileName =  fileManager.doFileUpload(bytes, vo.getAttach().getOriginalFilename(), path);
				vo.setUserProfile(vo.getAttach().getOriginalFilename());
		} catch (Exception e) {
			
		}
		
	}

		String userGender = "";
		if(vo.getUserGender().equals("F")) {
			userGender = "여";
		} else if (vo.getUserGender().equals("M")) {
			userGender = "남";
		}
	
		
		vo.setUserBirthDay(vo.getUserYear(), vo.getUserMonth(), vo.getUserDate());
		vo.setUserGender(userGender);
		
		System.out.println(vo.getUserBirthDay());
		System.out.println(vo.getUserGender());
		
		int n = 0;
//		service.userRegister(vo);
		
//		if(vo.getAttach().isEmpty()) {
			 n = service.userRegister(vo);
//		} /*else if(!vo.getAttach().isEmpty()) { // 파일첨부가 있는 경우
//			 n = service.userRegister(vo);
//		}*/
		req.setAttribute("n", n);
		
		System.out.println("====== 확인용 =======");
		System.out.println("n : " + n);
		
		//req.setAttribute("n", n);
		return "userRegisterEnd";
	} // end : userRegisterEnd 회원가입처리
	
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
			req.setAttribute("loc", "myQnaList.eat");
		}
		
		return "user/msg";
	}
	
	@RequestMapping(value = "/myQnaList.eat", method = RequestMethod.GET)
	public String myQnAList(HttpServletRequest req) {
		
		
		return "user/myQnaList";
	}
}
