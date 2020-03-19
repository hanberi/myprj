package com.kh.portfolio.board.svc;

import java.util.List;
import java.util.Map;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.QandAVO;
import com.kh.portfolio.common.PageCriteria;

public interface QandASVC {
	//카테고리 읽어오기
	List<BoardCategoryVO> getCategory();
	
	//게시글작성
	int qandAWrite(QandAVO qandAVO);

	//게시글수정
	int modify(QandAVO qandAVO);

	//게시글삭제
	int delete(String bnum);
	
	//첨부파일1건 삭제
	int fileDelete(String fid);
	
	//게시글보기
	int qandAview(String bnum);

	//게시글목록
	//1)전체
	List<QandAVO> qlist();
	//2)검색어 없는 게시글페이징
	List<QandAVO> qlist( int startRec, int endRec);	
	//3)검색어 있는 게시글검색(요청페이지, 검색유형, 검색어)
	List<QandAVO> qlist( String reqPage, String searchType,String keyword);
	
	//페이지 제어
	PageCriteria getPageCriteria(String reqPage, String searchType,String keyword);
		
	//게시글답글작성
	int reply(QandAVO qandAVO);
	//첨부파일조회
	BoardFileVO fileView(String fid);	
}
















