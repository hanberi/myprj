package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.QandAVO;

public interface QandADAO {
	//카테고리 읽어오기
	List<BoardCategoryVO> getCategory();
	
	//게시글작성
	int qandAWrite(QandAVO qandAVO);
	//게시글수정
	int modify(QandAVO qandAVO);

	//게시글삭제
	int delete(String bnum);
	//첨부파일 1건 삭제
	int fileDelete(String fid);
	//게시글 첨부파일 전체 삭제
	int filesDelete(String bnum);
	
	//게시글보기
	int qandAview(String bnum);
	//조회수 +1 증가
	int updateHit(String bnum);
	
	//게시글목록
	//1)전체
	List<QandAVO> qlist();
	//2)검색어 없는 게시글페이징
	List<QandAVO> qlist( int startRec, int endRec);	
	//3)검색어 있는 게시글검색(전체,제목,내용,작성자ID,별칭)
	List<QandAVO> qlist( int startRec, int endRec, String searchType,String keyword);
	//총 레코드수
	int totalRecordCount(String searchType,String keyword);	

	//게시글답글작성
	int reply(QandAVO qandAVO);
	//첨부파일 조회
	BoardFileVO fileView(String fid);	
	
}
