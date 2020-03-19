package com.kh.portfolio.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

//@Data
//class Person{
//	String name;
//	int age;
//}

@Controller
public class TestController2 {

	private static final Logger logger = LoggerFactory.getLogger(TestController2.class);

	@GetMapping("/test/t1") // ?name=hong&age=11
	public String t1(HttpServletRequest request) {
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		logger.info("이름: " + name);
		logger.info("나이: " + age);

		return "test";
	}

	// 요청파라미터를 매개변수선언시 자동형변환됨
	@GetMapping("/test/t2")
	public String t2(@RequestParam String name, @RequestParam int age) {

		logger.info("이름: " + name);
		logger.info("나이: " + age);

		return "test";
	}

	@GetMapping("/test/t3")
	public String t3(@RequestParam("name") String rename, @RequestParam("age") int reage) {

		logger.info("이름: " + rename);
		logger.info("나이: " + reage);

		return "test";
	}

	@GetMapping("/test/t4")
	public String t4(@RequestParam Map<String, String> map) {

		logger.info("이름: " + map.get("name"));
		logger.info("나이: " + map.get("age"));

		return "test";
	}

	// 파라미터 여러가지 한꺼번에 받는 방식
	// 잔딜할 파라미터가 많을때
	@GetMapping("/test/t5")
	public String t5(Person person) {
		logger.info(person.toString());
		return "test";
	}

//잔딜할 파라미터가 많을때//뷰에도..
	@GetMapping("test/t6")
	public String t6(Person person, Model model) {

		logger.info(person.toString());
		Map<String, Object> map = model.asMap();
		for (String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		return "test";
	}

	@GetMapping("test/t7")
	public String t7(@ModelAttribute("per") Person person, Model model) { // ModelAttribute는 클라이언트에 Person 객체를 전달할때 per로
																																				// 바꿔줌

		logger.info(person.toString());
		Map<String, Object> map = model.asMap();
		for (String key : map.keySet()) {
			logger.info(key + ":" + map.get(key).toString());
		}
		return "test";
	}

//입력 양식(test2); 이름, 나이
	@GetMapping("/test/t9")
	public String t9() {
		return "test2";
	}

	// 입력처리 url / test/t10 post
	@PostMapping("/test/t10") // @ModelAttrtibute("per") 은 person 객체의 이름을 per로 바꾸는것
	public String t10(@ModelAttribute("per") Person person, Model model) {// Model model 뷰에 얹어질 데이터 //Person person 파라미터에서
																																				// 이름하고 나이를 각각 받지 않고 person으로 한번에 받을려고
		logger.info(person.toString());

		Map<String, Object> map = model.asMap(); // map으로 쓰겠다고 asMap()써서 변환

		for (String key : map.keySet()) { // keySet은 key값을 가져오고 enterySet은 key와 value 값을 둘다 가져옴
//			logger.info(key + ":" + map.get(key).toString()); //get(key)는 key에 들어있는 value값을 가져온다. get(name)이면 name의 value 값을 가져옴 
		}
		model.addAttribute("person", person);

		return "test3";
	}

//	@PostMapping("/test/t10")
//	public String t10(Person person, Model model) {//Model model 뷰에 얹어질 데이터 //Person person 파라미터에서 이름하고 나이를 각각 받지 않고 person으로 한번에 받을려고 
//		logger.info(person.toString());
//		
//		Map<String,Object> map = model.asMap(); //map으로 쓰겠다고 asMap()써서 변환
//		
//		for(String key : map.keySet()) {     // keySet은 key값을 가져오고 enterySet은 key와 value 값을 둘다 가져옴
//			logger.info(key + ":" + map.get(key).toString()); //get(key)는 key에 들어있는 value값을 가져온다. get(name)이면 name의 value 값을 가져옴 
//		}
//		model.addAttribute("person", person);
//		
//		return "test3";
//	}
//	

//입력처리 url / test/t10 post
	@PostMapping("/test/t11")
	public String t11(@Valid @ModelAttribute("per") Person person, BindingResult result, Model model) {
		logger.info(person.toString());

		if (result.hasErrors()) {
			return "test4";
		}
		Map<String, Object> map = model.asMap(); // map으로 쓰겠다고 asMap()써서 변환

		for (String key : map.keySet()) { // keySet은 key값을 가져오고 enterySet은 key와 value 값을 둘다 가져옴
		}

		return "test3";
	}

	// Rest 서비스할때 client 에서 ajax호출할때 url요청 표현방식
	// url경로상의 파라미터 매개값전달 //@PathVariable로 받아옴
	@GetMapping("/test/t12/{name}/{age}")
	public String t12( // string 뷰이름 문자열 전달하겟다
			@PathVariable("name") String name, @PathVariable("age") String age, Model model) {
		model.addAttribute("name", name);
		model.addAttribute("age", age);
		logger.info("이름: " + "name");
		logger.info("나이: " + "age");

		return "test";
	}

	@GetMapping("/test/t13/{name}/{age}")
	public ModelAndView t13( // string 뷰이름 문자열 전달하겟다
			@PathVariable("name") String name, @PathVariable("age") String age) {
		ModelAndView mav = new ModelAndView(); // 모델객체만들어야함
		mav.setViewName("test");
		mav.addObject("name", name);
		mav.addObject("age", age);
		logger.info("이름: " + "name");
		logger.info("나이: " + "age");

		return mav;// 만들어놓은 모델 객체를 리턴
	}
}
