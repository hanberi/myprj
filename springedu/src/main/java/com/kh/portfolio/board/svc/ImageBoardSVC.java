package com.kh.portfolio.board.svc;

import java.util.List;
import java.util.Map;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.ImageBoardVO;
import com.kh.portfolio.common.PageCriteria;

public interface ImageBoardSVC {

	//1. 상품목록
	public List<ImageBoardVO> listImage();
	
	//2. 상품상세
	Map<String,Object> detailImage(int imageNum);
	
	//게시글작성
	int write(ImageBoardVO imageBoardVO);
	
	//첨부파일조회
	BoardFileVO fileView(String fid);	
	
}















