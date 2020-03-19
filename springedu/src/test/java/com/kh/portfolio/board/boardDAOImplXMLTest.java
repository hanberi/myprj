package com.kh.portfolio.board;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.board.dao.BoardDAO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.common.RecordCriteria;

@ExtendWith(SpringExtension.class) //테스트환경에서 테스트하기위해서
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) //빈지정
public class boardDAOImplXMLTest {
	private final static Logger logger
		= LoggerFactory.getLogger(boardDAOImplXMLTest.class);
	
	@Inject
	BoardDAO boardDAO;
	@Inject
	RecordCriteria recordCriteria;
	
	
	//게시글 목록
	@Test
	@DisplayName("게시글 목록")

	void list() {
		List<BoardVO> list = boardDAO.list();
		assertNotNull(list);
		logger.info(list.toString());
		
	}
	
	//게시글 목록 (페이지,검색어 추가)
	@Test
	@Named("게시글목록(페이징)")
	public void list3() {
		
		int reqPage = 1;
		
//		RecordCriteria recordCriteria = new RecordCriteria(reqPage);

		recordCriteria.setReqPage(reqPage);
		logger.info(""+recordCriteria.getStartRec());
		logger.info(""+recordCriteria.getEndRec());
		List<BoardVO> list = boardDAO.list(recordCriteria.getStartRec(), 
									recordCriteria.getEndRec(), 
									"TC", 
									"제목");
		logger.info("검색결과:"+list.size());
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.toString());
		}
	}
}















