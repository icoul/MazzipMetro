package com.go.mazzipmetro.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.go.mazzipmetro.vo.UserVO;

@Aspect 
@Component 
public class AdminAspect {

	@Pointcut("execution(* com.go.mazzipmetro.controller.*.admin_*(..))")
	public void admin_() {
		
	}
	
	@Before("admin_()")
	public void before(JoinPoint joinPoint) {
		
		System.out.println("admin_before 보조업무 실행!");

		System.out.println("------------------------------" + joinPoint.getSignature());

		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];
		
		HttpSession session = request.getSession();
			
		System.out.println(" >>> 확인용 로그인유저 ID : " + session.getAttribute("loginUser"));
			
		HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[1]; //redirect시키기위해서 로그인안하면 강제로 다른 페이지로 보내기위해
		
		//보조업무 구현
		// - 해당 요청자가 인증받지 못한 상태라면 회원 전용 페이지에 접근할 수 없기에 다른 페이지로 강제 이동시킨다.
		if (session.getAttribute("loginUser") == null || !((UserVO) session.getAttribute("loginUser")).getUserName().equals("관리자")) {
			try {
				 String msg = "관리자가 아닙니다.";
				 String loc = "index.eat";
				 request.setAttribute("msg", msg);
				 request.setAttribute("loc", loc);
				 
				 RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				 dispatcher.forward(request, response);
					 
				// response.sendRedirect("/aop/index.action");
				} catch (ServletException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}// end of if------------------
			
		}
}
