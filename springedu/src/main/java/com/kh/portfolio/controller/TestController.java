package com.kh.portfolio.controller;

import org.junit.jupiter.api.Test;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/test") //상위에있는걸 상속
public class TestController {
	
	@RequestMapping(
			value = {"","/1","/2","/3"}, // 다 같은 페이지가 나옴.!
			method = {RequestMethod.POST, RequestMethod.GET}) 
	public String t1() {
		return "test";
	}

//  하나의 메소드에서 HTTP 요청 방식 중복선언 불가
//	@GetMapping(value = {"","/1","/2","/3"})
//	@PostMapping(value = {"","/1","/2","/3"})
//	public String t1() {
//		return "test";
//	}
	
	@GetMapping(value = {"","/1","/2","/3"})
	public String t2() {
		return "test";
	}
	
	@PostMapping(value = {"","/1","/2","/3"})
	public String t3() {
		return "test";
	}
	
	@RequestMapping("/abc")
	public String temp() {
			// 1) 상대경로 : 현재요청 url이 기준이 됨
			//(O) return "rediect:../test"; //http://localhost:9080/portfolio/test 
			//(O) return "rediect:./";			//http://localhost:9080/portfolio/test 
			
			// 2) 절대경로 : 컨텍스트 루트가 기준이 됨
			//(O) return "redirect:test"; 			//http://localhost:9080/portfolio/test
			
			// 3) 외부서버 링크
			 return "redirect:http://www.naver.com";
	}
	@RequestMapping("/abc2")
	public String temp2() {
		 	//  1) 상대경로 : 현재요청 url이 기준이됨
			// (O) return  "forward:";   // /portfolio/test 
			// (X) return  "forward:./";	// /portfolio/test/./ 
			
			//  2) 절대경로 : 컨텍스트 루트가 기준이 됨
			return "forward:test";	    // /portfolio/test
			
			// 3) 외부서버 링크
			//(X)return "forward:http://www.naver.com";
	}	
}
