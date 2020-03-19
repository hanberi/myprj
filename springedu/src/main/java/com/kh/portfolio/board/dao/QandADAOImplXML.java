package com.kh.portfolio.board.dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.QandAVO;

@Repository
public class QandADAOImplXML implements QandADAO {
	
	private static final Logger logger 
	= LoggerFactory.getLogger(QandADAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory() {
		
		return sqlSession.selectList("mappers.QandADAO-mapper.getCategory");
	}
	//게시글작성
	@Override
	public int qandAWrite(QandAVO qandAVO) {
		return sqlSession.insert("mappers.QandADAO-mapper.qandAWrite", qandAVO);
	}
 
	//게시글수정
	@Override
	public int modify(QandAVO qandAVO) {
		return sqlSession.update("mappers.QandADAO-mapper.modify", qandAVO);
	}

	//게시글삭제
	@Override
	public int delete(String bnum) {

		return sqlSession.delete("mappers.QandADAO-mapper.delete", Long.valueOf(bnum));
	}
	//첨부파일 1건 삭제
	@Override
	public int fileDelete(String fid) {
		return sqlSession.delete("mappers.QandADAO-mapper.fileDelete", Long.valueOf(fid));
	}
	//게시글 첨부파일 전체 삭제
	@Override
	public int filesDelete(String bnum) {
		return sqlSession.delete("mappers.QandADAO-mapper.filesDelete", Long.valueOf(bnum));
	}
	
	//게시글보기
	@Override
	public int qandAview(String bnum) {
		return sqlSession.selectOne("mappers.QandADAO-mapper.qandAview", Long.valueOf(bnum));
	}

	
	@Override
	public int updateHit(String bnum) {
		return sqlSession.update("mappers.QandADAO-mapper.updateHit", Long.valueOf(bnum));
	}	
	//게시글목록
	//1)전체
	@Override
	public List<QandAVO> qlist() {
		return sqlSession.selectList("mappers.QandADAO-mapper.qlist");
	}
	//2)검색어 없는 게시글페이징
	@Override
	public List<QandAVO> qlist(int startRec, int endRec) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.QandADAO-mapper.qlist2", map);
	}
	//3)검색어 있는 게시글검색(전체,제목,내용,작성자ID,별칭)
	@Override
	public List<QandAVO> qlist(int startRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("searchType",searchType);
		if(keyword != null) {
			map.put("qlist",Arrays.asList(keyword.split("\\s+")));
		}
		return sqlSession.selectList("mappers.QandADAO-mapper.qlist3", map);
	}
	
	//총 레코드수
	@Override
	public int totalRecordCount(String searchType, String keyword) {
		logger.info("keyword :" + keyword);
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		logger.info("keyword2 :" + map.get("list"));
		return sqlSession.selectOne("mappers.QandADAO-mapper.totalRecordCount",map);
	}
	
	//게시글답글작성
	@Override
	public int reply(QandAVO qandAVO) {
		//1) 이전답글 step업데이트
		updateStep(qandAVO.getBgroup(),qandAVO.getBstep());
		//2) 답글달기
		return sqlSession.insert("mappers.QandADAO-mapper.reply", qandAVO);
	}
	//이전 답글 step 업데이트
	private int updateStep(int bgroup, int bstep) {
		Map<String,Object> map = new HashMap();
		map.put("bgroup", bgroup);
		map.put("bstep",bstep);
		return sqlSession.update("mappers.QandADAO-mapper.updateStep",map);
	}
	
	//첨부파일조회
	@Override
	public BoardFileVO fileView(String fid) {

		return sqlSession.selectOne("mappers.QandADAO-mapper.fileView", Long.valueOf(fid));
	}

}



