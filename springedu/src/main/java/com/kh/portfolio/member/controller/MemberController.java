package com.kh.portfolio.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.common.Code;
import com.kh.portfolio.member.dao.MemberDAOImplJDBC;
import com.kh.portfolio.member.svc.MemberSVC;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/member") //url매핑해주기위해 요청경로
public class MemberController {
	
	private static final Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBC.class);
	
	@Inject
	MemberSVC memberSVC;
	
	 @ModelAttribute public void initData(Model model) { //지역 class CODE 만들어야함.!
	 List<Code> gender = new ArrayList<>(); 
		/*
		 * region.add(new Code("서울","서울"));//(서버쪽으로넘어올값,라벨) region.add(new
		 * Code("경기","경기")); region.add(new Code("인천","인천")); region.add(new
		 * Code("대전","대전")); region.add(new Code("경남","경남")); region.add(new
		 * Code("경북","경북")); region.add(new Code("충북","충북")); region.add(new
		 * Code("충남","충남")); region.add(new Code("전남","전남")); region.add(new
		 * Code("전북","전북")); model.addAttribute("region", region);
		 */
	 
	 //모든 뷰에서 공통적으로 참고가능 //성별 List <Code>
	 gender = new ArrayList<>(); gender.add(new Code("남","남자")); gender.add(new
	 Code("여","여자")); model.addAttribute("gender", gender); }
	 
	
	//string은 뷰이름 반환
	//회원가입양식
	@RequestMapping("/joinForm")
	public String memberJoinForm(Model model) {
		model.addAttribute("mvo",new MemberVO());
		return "member/joinForm";
	}
	//회원등록
	@RequestMapping("/join")
	public String memberJoin(
			@Valid @ModelAttribute("mvo") MemberVO memberVO,
			BindingResult result,
			Model model) {
		logger.info(memberVO.toString());
		
	// 1)유효성 오류체크 중 오류가 발견되면 회원가입페이지로 이동
	if(result.hasErrors()) { //에러가있는지 검사한다.
		return "member/joinForm";
	}
		
	// 2)회원 중복체크
	if(memberSVC.selectMember(memberVO.getId()) != null) {
		model.addAttribute("svr_msg", "중복된 아이디입니다.");
		return "member/joinForm";
	}
		
	// 3)회원가입처리
	int cnt = memberSVC.joinMember(memberVO);
	if(cnt == 1) {
		return "member/loginForm";			
	}else {
		return "redirect:/";
		}
	}
	
	//회원수정 양식
	@GetMapping("/modifyForm/{id:.+}")
	public String modifyForm(@PathVariable String id, Model model) {
		
		//1) 현재 로긴한 회원정보 읽어오기
		MemberVO memberVO = memberSVC.selectMember(id);
		logger.info("memberVO:" + memberVO);
		//비밀번호 제거
		memberVO.setPw(null);
		model.addAttribute("mvo", memberVO);		
		
		return "member/modifyForm";
	}
	
	//회원수정
	@PostMapping("/modify")
	public String modify(
			@Valid @ModelAttribute("mvo") MemberVO memberVO,
			BindingResult result,
			HttpSession session,
			Model model
			) {
		logger.info("/modify호출됨!");
		//유효성 체크
		if(result.hasErrors()) {
			logger.info(result.getAllErrors().toString());
			//비밀번호 제거
			memberVO.setPw(null);
			return "member/modifyForm";
		}		
		//회원정보수정
		int cnt = memberSVC.modifyMember(memberVO);
		logger.info("수정처리결과 :" + cnt);

		//세션정보 수정
		session.removeAttribute("member");	
		session.setAttribute("member", memberVO);	
		return "redirect:/member/modifyForm/"+memberVO.getId();
	}
	
//
//	//회원수정 양식
//	@GetMapping("/modifyForm/{id:.+}") //주소
//	public String modifyForm(
//			@PathVariable String id, //{id:.+}
//			Model model) {
//		
//	//현재 로그인한 회원정보 읽어오기
//	//아이디값 불러올려면 @PathVariable 써야함.
//	//1) 현재 로긴한 회원정보 읽어오기
//			MemberVO memberVO = memberSVC.selectMember(id);
//			logger.info("memberVO:" + memberVO);
//			//비밀번호 제거
//			memberVO.setPw(null);
//			model.addAttribute("mvo", memberVO);		
//		
//		return "member/modifyForm";//파일 위치
//	}
//	//회원수정
//	@PostMapping("/modify")
//		public String modify(
//			@Valid //서버유효성체크 
//			@ModelAttribute("mvo") MemberVO memberVO, 
//			BindingResult result,
//			HttpSession session,
//			Model model
//			) {
//	
//	//유효성 체크
//			if(result.hasErrors()) {//오류있나확인
//				logger.info(result.getAllErrors().toString());
//				//비밀번호 제거
//				memberVO.setPw(null);
//				return "member/modifyForm";//없으면 다음페이지로
//			}		
//	//회원정보 수정
//	//memberVO를 불러오려면  @Valid와 @ModelAttribute 추가!
//		int cnt = memberSVC.modifyMember(memberVO);
//		logger.info("수정결과처리:" + cnt );
//	
//		
//		//세션정보 수정
//		//HttpSession session 써야함
//
//		session.removeAttribute("member");	
//		session.setAttribute("member", memberVO);	
//		return "redirect:/member/modifyForm/"+memberVO.getId();
//	}
	//회원탈퇴양식
	@GetMapping("/outForm")
	public String outForm() {
		
		return "member/outForm";
	}
	//회원탈퇴처리
	@PostMapping("/out")
	public String out(
			@RequestParam("id") String id,
			@RequestParam("pw") String pw,
			HttpSession session,
			Model model
			) {
		int cnt = memberSVC.outMember(id, pw); //아이디랑 비번 불러오고
		if(cnt == 1) { //1명이면
			session.invalidate(); //세션 다 지워버렷
			return "redirect:/"; 
		}
		//outForm에 메세지 넣기
		model.addAttribute("svr_msg", "비밀번호가 일치하지 않습니다!");
		
		return "member/outForm";
	}
	
	//아이디 찾기 양식
	@GetMapping("/findIDForm")
	public String findIDForm() {
		return "member/findIDForm";
	}
	//아이디찾기 post방식
	@PostMapping(value = "/id", produces="application/json")
	@ResponseBody
	public ResponseEntity<Map> findId(
			@RequestBody MemberVO memberVO
			){
		ResponseEntity<Map> res = null;
		String findId = null;
		logger.info("tel:"+memberVO.getTel());
		logger.info("birth:"+memberVO.getBirth());
		
		//java.sql.date 타입으로 변환
		memberVO.setBirth(java.sql.Date.valueOf(memberVO.getBirth().toString()));
		//아이디찾기 service 호출하기위해 위에 string findId 선언
		findId = memberSVC.findID(memberVO.getTel(), memberVO.getBirth());
		Map<String, Object> map = new HashMap();
		if(findId != null) {
			map.put("success", true);
			map.put("id", findId);
			res = new ResponseEntity<Map>(map, HttpStatus.OK); //성공하면 200
		}else {
			map.put("success", false);
			map.put("id", findId);
			map.put("msg", "가입되지않은 아이디입니다.!");
			res = new ResponseEntity<Map>(map, HttpStatus.OK); //실패하면 400
		}
		return res;
	}
	
	//비밀번호 변경화면
	@GetMapping("/findPWForm")
	public String findPWForm() {
		
		return "member/findPWForm"; 
	}	
	//비밀번호변경 대상 찾기
	@PostMapping(value="/findPW", produces = "application/json;charset=utf-8")
	@ResponseBody             //뷰말고 데이터 던져줌
	public ResponseEntity<Map> findPW(
			@RequestBody MemberVO memberVO){
		ResponseEntity<Map> res = null;
		logger.info("비밀번호 변경 대상 찾기 요청:"+memberVO);
		
		//2)비밀번호변경 대상 찾기
		memberVO.setBirth(java.sql.Date.valueOf(memberVO.getBirth().toString()));
		int cnt = memberSVC.findPW(memberVO);
		Map<String,Boolean> map = new HashMap<>();		
		if(cnt==1) {
			map.put("success", true);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}else {
			map.put("success", false);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		return res;
	}
	//비밀번호 변경
	@PostMapping(value = "/changePW", produces = "application/json;charset=utf-8")
	@ResponseBody //데이터만보냄
	public ResponseEntity<Map> changePW(
			@RequestBody MemberVO memberVO
			){
		ResponseEntity<Map> res = null;
		int cnt = memberSVC.changePW(memberVO.getId(), memberVO.getPw());
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		if(cnt == 1) {
			map.put("success", true);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);
		}else {
			map.put("success", false);
			res = new ResponseEntity<Map>(map,HttpStatus.OK);			
		}
		return res;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	//아이디찾기 get방식
//	@GetMapping(value = "/id/{tel}/{birth}",produces="apllication/json;charset=utf-8")
//	@ResponseBody
//	public ResponseEntity<String> findId(
//			@PathVariable("tel") String tel,
//			@PathVariable("birth") String birth
//			){ 
//
//			ResponseEntity<String> res = null;
//			String findId = null;
//			logger.info("tel:"+tel);
//			logger.info("birth:"+birth);
//			
//			findId = memberSVC.findID(tel, java.sql.Date.valueOf(birth));
//			if(findId != null) {
//				res = new ResponseEntity<String>(findId, HttpStatus.OK); //200 
//			}else {
//				res = new ResponseEntity<String>("찾고자하는 아이디가 없습니다.", HttpStatus.BAD_REQUEST); //400
//			}
//		return res;
//	}
//	

	
}




