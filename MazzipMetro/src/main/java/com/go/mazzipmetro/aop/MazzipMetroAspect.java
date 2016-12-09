package com.go.mazzipmetro.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.go.mazzipmetro.controller.MazzipMetroController;


@Aspect 
@Component 
public class MazzipMetroAspect {

	
	@Pointcut("execution(* com.go.mazzipmetro.controller.MazzipMetroController.aop*(..))")
	public void aop() {
		
	}
	
	@Before("aop()")
	public void before(JoinPoint joinPoint) {
		
		System.out.println("before 보조업무 실행!");

		
		MazzipMetroController mmc = (MazzipMetroController)joinPoint.getTarget();
	
	}
	
	
	
}
