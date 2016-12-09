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
	
	/*
	@After("pc1()")
	public void after(JoinPoint joinPoint) {
		
		System.out.println("after 보조업무 실행!");
		
	}
	
	@Around("pc1()") 
	public void arround(ProceedingJoinPoint joinPoint) throws Throwable {

		// 보조업무 시작
		long start = System.currentTimeMillis();
		System.out.println("시간 기록 시작");

		try {

			// 주업무 시작
			joinPoint.proceed();
			// 주업무 끝

		} finally {

			long finish = System.currentTimeMillis();
			System.out.println("시간 기록 끝");
			System.out.println("주업무 실행시간 : " + (finish - start) + "ms");
			// 보조업무 끝

		}

	}
	
	@AfterReturning(pointcut="pc1()", returning="data")
	public void afterReturning(JoinPoint joinPoint, Object data) {
		
		System.out.println("afterRetruning 보조업무 실행!");
		System.out.printf("joinPoint가 리턴한 데이터 : %s", data);
		
	}*/
	
}
