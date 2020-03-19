package com.kh.portfolio.board.controller;


import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.portfolio.board.svc.BoardSVC;
import com.kh.portfolio.board.svc.QandASVC;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.QandAVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/bb")
public class QandAController {

	private static final Logger logger
	= LoggerFactory.getLogger(QandAController.class);
	
	@Inject
	QandASVC qandASVC;
	
	//게시글 작성양식
	@GetMapping("/QandAWriteForm")
	public String QandAWriteForm(
			Model model, HttpServletRequest request) {
		
		model.addAttribute("qandAVO",new QandAVO());
		return "/board/QandAWriteForm";
	}
	
	//게시글 작성
	@PostMapping("/QandAWrite")
	public String QandAWrite(
			@Valid @ModelAttribute("qandAVO") QandAVO qandAVO,
			BindingResult result,
			HttpServletRequest request) {
		logger.info("게시글작성: " + qandAVO.toString());
		
		if(result.hasErrors()) {
			return "/board/QandAWriteForm";
		}
		
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		qandAVO.setBid(memberVO.getId());
		qandAVO.setBnickname(memberVO.getNickname());
		logger.info("게시글작성2: " + qandAVO.toString());		
		qandASVC.qandAWrite(qandAVO);
		return "redirect:/bb/QandAlist";
	}
	
	//목록보기
	@GetMapping("/QandAlist")
	public String listAll(
			@PathVariable(required=false) String reqPage,
			@PathVariable(required=false) String searchType,
			@PathVariable(required=false) String keyword,
			HttpSession session, 
			Model model) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("member");
		//게시글목록
		model.addAttribute("qlist", qandASVC.qlist(reqPage,searchType,keyword));
		//페이지 제어
		model.addAttribute("pc", qandASVC.getPageCriteria(reqPage, searchType, keyword));	
		return "board/QandAlist";
	}
	
	//게시글보기
		@GetMapping("/QandAview/{returnPage}/{bnum}")
		public String qandAview(
				@ModelAttribute("qandAVO") QandAVO qandAVO,
				@ModelAttribute @PathVariable String returnPage,
				@PathVariable String bnum,
				Model model) {
			model.addAttribute("qandAVO", qandAVO);
		
			return "/board/QandAreadForm";
		}
		
}







