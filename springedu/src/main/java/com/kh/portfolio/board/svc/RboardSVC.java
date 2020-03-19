package com.kh.portfolio.board.svc;

import java.util.List;

import com.kh.portfolio.board.vo.RboardVO;
import com.kh.portfolio.board.vo.VoteVO;

public interface RboardSVC {

	//댓글작성
	int write(RboardVO rboardVO);
	
	//댓글목록
	//게시글 댓글목록볼려면 인풋으로 bnum받아야함
	List<RboardVO> list(int bnum, int startRec, int endRec);
	
	//댓글수정
	int modify(RboardVO rboardVO);
	
	//댓글삭제
	int delete(String rnum);
	
	//대댓글작성
	int reply(RboardVO rboardVO);
	
	//댓글 호감,비호감
	//투표여부체크
	int checkVote(VoteVO voteVO);
	
	int mergeVote(VoteVO voteVO);
	
	//댓글 총계
	int replyTotalRec(String bnum);

	
}
