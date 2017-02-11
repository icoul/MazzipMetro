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
public class CouponAspect {
	
	@Pointcut("execution(* com.go.mazzipmetro.controller.CouponController.coupon*(..))")
	public void coupon(){
		
	}
	
	@Before("coupon()")
	public void restBefore(JoinPoint joinPoint ){
		
		HttpServletRequest req = (HttpServletRequest)joinPoint.getArgs()[0];
		HttpServletResponse res = (HttpServletResponse)joinPoint.getArgs()[1];
		
		HttpSession session = req.getSession();

		try{
			String msg = "";
			String loc = "";
					
			if (session.getAttribute("loginUser") == null || session.getAttribute("loginUser").equals("")) {
				msg = "로그인 후 이용해주세요";
				loc = "index.eat";
				
				req.setAttribute("msg", msg);
				req.setAttribute("loc", loc);
				
				RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/msg.jsp");
				dispatcher.forward(req, res);
				
				return;
			}
			
		}catch(ServletException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		} 
	}
}
