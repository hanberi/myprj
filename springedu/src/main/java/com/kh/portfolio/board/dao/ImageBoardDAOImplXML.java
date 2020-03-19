package com.kh.portfolio.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.ImageBoardVO;

@Repository
public class ImageBoardDAOImplXML implements ImageBoardDAO {
	
	private static final Logger logger 
	= LoggerFactory.getLogger(ImageBoardDAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	//상품목록
	@Override
	public List<ImageBoardVO> listImage() {	
		return sqlSession.selectList("mappers.ImageBoardDAO-mapper.imageList");
	}
	
	//게시글작성
	@Override
	public int write(ImageBoardVO imageBoardVO) {
		return sqlSession.insert("mappers.ImageBoardDAO-mapper.write", imageBoardVO);
	}
	
	//첨부파일 저장
	@Override
	public int fileWrite(BoardFileVO boardFileVO) {
		return sqlSession.insert("mappers.ImageBoardDAO-mapper.fileWrite", boardFileVO);
	}
	
	//게시물 보기
	@Override
	public ImageBoardVO detailImage(int imageNum) {
		return sqlSession.selectOne("mappers.ImageBoardDAO-mapper.detailImage", imageNum);
	}

	//
	@Override
	public List<BoardFileVO> fileViews(int imageNum) {
		return sqlSession.selectList("mappers.ImageBoardDAO-mapper.fileViews", imageNum);
	}
	

	@Override
	public int updateHit(int imageNum) {
		return sqlSession.update("mappers.ImageBoardDAO-mapper.updateHit", imageNum);
	}
	
	//첨부파일조회
	@Override
	public BoardFileVO fileView(String fid) {
		return sqlSession.selectOne("mappers.ImageBoardDAO-mapper.fileView", Long.valueOf(fid));
	}

}