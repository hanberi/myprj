package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.ImageBoardVO;

public interface ImageBoardDAO {

	//1. 게시글목록
	List<ImageBoardVO> listImage();
	
	//게시글보기
	ImageBoardVO detailImage(int imageNum);
	List<BoardFileVO> fileViews(int imageNum);
	//조회수 +1 증가
	int updateHit(int imageNum);
		
	//3. 상품추가
	int write(ImageBoardVO imageBoardVO);
	int fileWrite(BoardFileVO boardFileVO);

	//첨부파일 조회
	BoardFileVO fileView(String fid);
}



