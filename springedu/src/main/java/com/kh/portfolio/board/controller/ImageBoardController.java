package com.kh.portfolio.board.controller;



import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.jni.File;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.portfolio.board.svc.ImageBoardSVC;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.ImageBoardVO;
import com.kh.portfolio.member.vo.MemberVO;

@Controller
@RequestMapping("/board/image/*")
public class ImageBoardController {

	private static final Logger logger
		= LoggerFactory.getLogger(ImageBoardController.class);
	
	@Inject
	ImageBoardSVC imageBoardSVC;
	
	//1. 이미지 게시판 전체 목록
	@RequestMapping("/list.do")
	public ModelAndView list(ModelAndView mav) {
		mav.setViewName("board/imageList");
		mav.addObject("list",imageBoardSVC.listImage());
		
		return mav;
	}
	
	//2. 이미지 게시판 상세 보기
	@GetMapping("/detail/{imageNum}")
	public ModelAndView detail(
			@PathVariable("imageNum") int imageNum,
								ModelAndView mav, Model model) {
		mav.setViewName("/board/imageDetail");
		mav.addObject("vo", imageBoardSVC.detailImage(imageNum));
		
		Map<String,Object> map = imageBoardSVC.detailImage(imageNum);
		ImageBoardVO imageBoardVO = (ImageBoardVO)map.get("imageBoard");
		logger.info(imageBoardVO.toString());
		List<BoardFileVO> files = null;
		if(map.get("files") != null) {
			files = (List<BoardFileVO>)map.get("files");
		}
		
		model.addAttribute("list", imageBoardVO);
		model.addAttribute("files", files);
		
		return mav;
	}
	
	// 게시글 작성 양식
	@GetMapping("/imageWrite")
	public String writeImage(Model model) {
		model.addAttribute("imageBoardVO",new ImageBoardVO());
		return "/board/imageWrite";
	}
	// 게시글 작성
	@PostMapping("/imageWrite.do")
	public String insertImage(
			@ModelAttribute("imageBoardVO") ImageBoardVO imageBoardVO,
			@ModelAttribute("boardFileVO") BoardFileVO boardFileVO,
			BindingResult result,
			HttpServletRequest request,	Model model) {
		
		if(result.hasErrors()) {
			return "/board/imageWrite";
		}

		
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("member");
		imageBoardVO.setImageId(memberVO.getId());


		model.addAttribute("imageBoardVO", imageBoardVO);
		model.addAttribute("files", boardFileVO);
		imageBoardSVC.write(imageBoardVO);
		return "redirect:/";
	}
}