package com.kh.portfolio.board.svc;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.portfolio.board.dao.QandADAO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.QandAVO;
import com.kh.portfolio.common.FindCriteria;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@Service
public class QandASVCImpl implements QandASVC {
	
	public static final Logger logger 
		= LoggerFactory.getLogger(QandASVCImpl.class);
	
	@Inject
	QandADAO qandADAO;
	
	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory() {
		return qandADAO.getCategory();
	}
	//게시글작성
	@Transactional
	@Override
	public int qandAWrite(QandAVO qandAVO) {
		//1) 게시글 작성
		int cnt = qandADAO.qandAWrite(qandAVO);

		//2) bnum 가져오기 => mybatis: selectkey 사용
		
		//3) 첨부파일 있는경우
		
		return cnt;
	}
	
	//게시글수정
	@Transactional
	@Override
	public int modify(QandAVO qandAVO) {
		//1) 게시글 수정
		int cnt = qandADAO.modify(qandAVO);
		//2) 첨부파일 추가
		
		return cnt;
	}
	//게시글삭제
	@Transactional
	@Override
	public int delete(String bnum) {
		int cnt = 0;
		qandADAO.filesDelete(bnum);
		cnt = qandADAO.delete(bnum);
		return cnt;
	}

	//첨부파일1건 삭제
	@Override
	public int fileDelete(String fid) {
		return qandADAO.fileDelete(fid);
	}
	
	//게시글보기
	@Transactional
	@Override
	public int qandAview(String bnum) {
		//1) 게시글 가져오기
		qandADAO.qandAview(bnum);
		
		//3) 조회수 +1증가
		qandADAO.updateHit(bnum);
	
		return qandADAO.qandAview(bnum);
	}
	//게시글목록
	//1)전체
	@Override
	public List<QandAVO> qlist() {
		return qandADAO.qlist();
	}
	//2)검색어 없는 게시글페이징
	@Override
	public List<QandAVO> qlist(int startRec, int endRec) {
		// TODO Auto-generated method stub
		return null;
	}
	//3)검색어 있는 게시글검색(요청페이지,검색유형,검색어)
	@Override
	public List<QandAVO> qlist(String reqPage, String searchType, String keyword) {	
		 
		int l_reqPage = 0;
		
		//요청 페이지 정보가 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {//문자열공백제거/size() = 0,List 안에 아무것도 없는 상태
			l_reqPage =  1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
		
		RecordCriteria recordCriteria = new RecordCriteria(l_reqPage);
		
		return qandADAO.qlist(
				recordCriteria.getStartRec(), 
				recordCriteria.getEndRec(), 
				searchType, keyword);
	}
	
	//페이지 제어
	@Override
	public PageCriteria getPageCriteria(String reqPage, String searchType, String keyword) {
		
		PageCriteria 		pc = null;					//한페이지에 보여줄 페이징 계산하는 클래스
		FindCriteria 		fc = null;					//PageCriteira + 검색타입, 검색어		
		
		int totalRec = 0;										//전체레코드 수
		
		int l_reqPage = 0;
		
		//요청 페이지 정보가 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage =  1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
			
		totalRec = qandADAO.totalRecordCount(searchType,keyword);
		
		fc = new FindCriteria(l_reqPage, searchType, keyword);
		pc = new PageCriteria(fc, totalRec);
		logger.info("totalRec:"+totalRec, searchType, keyword);
		logger.info("fc:"+fc.toString());
		logger.info("rc:"+((RecordCriteria)fc).toString());
		logger.info("pc:"+pc.toString());
		return pc;
	}
	
	//게시글답글작성
	@Transactional
	@Override
	public int reply(QandAVO qandAVO) {
		//1) 게시글 답글 작성
		int cnt = qandADAO.reply(qandAVO);

		//2) bnum 가져오기 => mybatis: selectkey 사용
		
		//3) 첨부파일 있는경우
		logger.info("첨부갯수:"+qandAVO.getFiles().size());
		
		return cnt;
	}

	//첨부파일조회
	@Override
	public BoardFileVO fileView(String fid) {
		return qandADAO.fileView(fid);
	}
	


}




