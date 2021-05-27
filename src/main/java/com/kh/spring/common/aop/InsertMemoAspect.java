package com.kh.spring.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component //빈 등록
@Aspect //aspect클래스 등록. pointcut, advice를 가지고 있음.
public class InsertMemoAspect {

	@Pointcut("execution(* com.kh.spring.memo.controller.MemoController.insertMemo(..))")
	public void pointcut() {}

	@Around("pointcut()")
	public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		
		//before
		Signature signature = joinPoint.getSignature();
		String methodName = signature.getName();
		
		StopWatch stopwatch = new StopWatch();
		stopwatch.start();
		
		//주업무 joinPoint실행
		Object returnObj = joinPoint.proceed();
		
		//after
		stopwatch.stop();
		long duration = stopwatch.getTotalTimeMillis();
		log.debug("소요시간 : {} ms",duration);
		
		return returnObj;
	}

}
