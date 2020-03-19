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

import com.kh.portfolio.board.dao.ImageBoardDAO;
import com.kh.portfolio.board.dao.QandADAO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.BoardFileVO;
import com.kh.portfolio.board.vo.BoardVO;
import com.kh.portfolio.board.vo.ImageBoardVO;
import com.kh.portfolio.board.vo.QandAVO;
import com.kh.portfolio.common.FindCriteria;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@Service
public class ImageBoardSVCImpl implements ImageBoardSVC {
	
	public static final Logger logger 
		= LoggerFactory.getLogger(ImageBoardSVCImpl.class);
	
	@Inject
	ImageBoardDAO imageBoardDAO;
	
	
	//1. 이미지게시판 목록
	@Override
	public List<ImageBoardVO> listImage() {
		return imageBoardDAO.listImage();
	}
	
	
	//2. 이미지게시판 상세보기
	@Transactional
	@Override
	public Map<String,Object> detailImage(int imageNum) {
		//1) 게시글 가져오기
		ImageBoardVO imageBoardVO = imageBoardDAO.detailImage(imageNum);
		//2) 첨부파일 가져오기
		List<BoardFileVO> files = imageBoardDAO.fileViews(imageNum);
		//3) 조회수 +1증가
		imageBoardDAO.updateHit(imageNum);
		
		Map<String,Object> map = new HashMap<>();
		map.put("imageBoard", imageBoardVO);
		if(files != null && files.size() > 0) {
			map.put("files", files);
		}
		return map;
	}

	//게시글작성
		@Transactional
		@Override
		public int write(ImageBoardVO imageBoardVO) {
			//1) 게시글 작성
			int cnt = imageBoardDAO.write(imageBoardVO);

			//2) bnum 가져오기 => mybatis: selectkey 사용
			
			//3) 첨부파일 있는경우
			if(imageBoardVO.getFiles() != null && imageBoardVO.getFiles().size() > 0) {
				fileWrite(imageBoardVO.getFiles(),imageBoardVO.getImageNum());
			}
			
			logger.info("svc성공");
			return cnt;
		}
		//첨부파일 저장
		private void fileWrite(List<MultipartFile> files, int imageNum ) {
			for(MultipartFile file : files) {			
				try {
					logger.info("파일 첨부: " + file.getOriginalFilename());
					BoardFileVO boardFileVO = new BoardFileVO();
					//게시글번호
					boardFileVO.setBnum(imageNum);
					//첨부파일명
					boardFileVO.setFname(file.getOriginalFilename());
					//첨부파일 크기
					boardFileVO.setFsize(file.getSize());
					//첨부파일 타입
					boardFileVO.setFtype(file.getContentType());
					//첨부파일
					boardFileVO.setFdata(file.getBytes());
					//첨부파일 저장
					if( file.getSize() > 0) {
						imageBoardDAO.fileWrite(boardFileVO);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		//첨부파일조회
		@Override
		public BoardFileVO fileView(String fid) {
			return imageBoardDAO.fileView(fid);
		}

}




