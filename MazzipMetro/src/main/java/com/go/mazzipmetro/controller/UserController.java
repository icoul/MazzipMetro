package com.go.mazzipmetro.controller;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.json.JSONObject;
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
		return "restRegister";
	}
	
	@RequestMapping(value="/restRegisterEnd.eat", method={RequestMethod.GET})
	public String restRegisterEnd(RestaurantVO vo, HttpServletRequest req){
		
		int n = service.restRegister(vo);
		
		req.setAttribute("n", n);
		return "restRegisterEnd";

	}
	
	@RequestMapping(value="/login.eat", method={RequestMethod.POST})
	public String UserLogin(UserVO vo, HttpServletRequest req, HttpServletResponse res){
		
		String userId = req.getParameter("dx_userId");
		String password = req.getParameter("dx_password");
		String rememberId = req.getParameter("dx_rememberId");
		String rememberPwd = req.getParameter("dx_rememberPwd");
		
		HttpSession ses = req.getSession();
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		int result = service.UserLogin(vo);
		String msg = "";
		String loc = "";
		
		if (result == -1) {//아이디가 존재하지 않는 경우
			msg = "존재하지 않는 아이디입니다.";
			loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return"msg";
		} else if (result == 0) {//비밀번호가 틀린 경우
			msg = "비밀번호가 틀렸습니다.";
			loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return"msg";
		} else if (result == 1){// 아이디와 비번이 모두 맞은 경우
			msg = loginUser.getUserName() + "님, 환영합니다.";
			loc = "index.eat";			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "msg";
			
			//로그인할 사용자의 정보를 세션에 저장하도록 한다.
			ses.setAttribute("loginUser", loginUser);
			//로그인한 시간을 세션에 저장하도록 한다.
			Date now = new Date();
			String date = String.format("%tF %tT %tZ", now, now, now);
			ses.setAttribute("loginTime", date);
			
			//사용자 로그인시 아이디저장 체크박스에 체크를 했을 경우와, 체크를 하지 않았을 경우
			// * checked : 쿠키 저장
			// * unchecked : 쿠키 삭제
			
			Cookie cookieId = new Cookie("rememberId", loginUser.getUserId());
			Cookie cookiePwd = new Cookie("rememberPwd", loginUser.getPassword());//비보안
			//로그인 하는 사용자의 아이디값을 "rememberId" 문자열을 키값으로 하는 쿠키객체를 생성한다. 
			//파라미터 타입은 Cookie(String name, String value)이다.
			
			if (rememberId != null) {//아이디저장 체크박스에 체크한 경우. 즉, "on"이다.
				cookieId.setMaxAge(7*24*60*60);
				// 쿠키의 생존기간을 7일(단위는 초이다.)
				//매로그인마다 이시간이 연장된다.
			} else {//아이디저장 체크박스에 체크해제한 경우
				cookieId.setMaxAge(0);//쿠키 지속시간이 0초, 즉 삭제를 의미한다.
			}
			
			if (rememberPwd != null) {
				cookiePwd.setMaxAge(7*24*60*60);
			} else {
				cookiePwd.setMaxAge(0);
			}
			
			cookieId.setPath("/");
			cookiePwd.setPath("/");
			//쿠키가 사용되어질 디렉토리 정보 설정.
			// cookie.setPath("디렉토리");
			// "/" : 해당 도메인의 모든 페이지에서 사용가능하다.
			
			res.addCookie(cookieId);
			res.addCookie(cookiePwd);
			//사용자의 웹브라우져로 쿠키를 전송시킨다.(response 객체에 담는다.)
			//이로서, 우리는 7일간 사용가능한 쿠키를 전송할 수도 있고,
			//0초짜리 쿠키(쿠키삭제)를 사용자 웹브라우져로 전송한다.
			//이 후의 일은 모두 웹브라우져가 알아서 해준다.
			
			msg = loginUser.getUserName() + "님, 환영합니다.";
			loc = "index.do";
			String viewPage = "/WEB-INF/views/msg/msg.jsp";
			
			/*
			 	로그인 하지 않은 상태에서 장바구니 담기를 하면, 로그인메세지를 출력한다.
			 	로그인 후에는 기존에 장바구니에 담고자 했던 제품의 상세페이지로 간다.
			 	
			 	제품의 상세페이지는 CartAddAction에서 세션에 "returnPage"로 저장해 두었다.
			 */
			//session에 저장된 returnPage가 있다면, 그곳으로 이동한다.
			if(ses.getAttribute("returnPage") != null){
				viewPage = (String)ses.getAttribute("returnPage"); 
			}
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);//loc를 req에 담았지만, msg.jsp로 가지 않으면 휘발된다.
			
			this.setRedirect(false);
			this.setViewPage(viewPage);
			
		}// end of if~else
		
		
		

	}
	
}
