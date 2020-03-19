package com.kh.portfolio.member.svc;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.portfolio.member.dao.MemberDAO;
import com.kh.portfolio.member.dao.MemberDAOImplJDBC;
import com.kh.portfolio.member.vo.MemberVO;

@Service
public class MemberSVCImpl implements MemberSVC {
	
	private static final Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBC.class);
	
	//서비스에서는 dao사용
	@Inject
	@Qualifier("memberDAOImplXML")   //@Repository("")
	MemberDAO memberDAO;
	
	//회원 등록
	@Override
	public int joinMember(MemberVO memberVO) {
		logger.info("MemberDAOImplXML.joinMember(MemberVO memberVO) 호출!!!!!!!! ");	
		return memberDAO.joinMember(memberVO);
	}
//회원 수정
	@Override
	public int modifyMember(MemberVO memberVO) {
		logger.info("MemberDAOImplXML.modifyMember(MemberVO memberVO) 호출!!!!!!!! ");	
		return memberDAO.modifyMember(memberVO);
	}
	
	//회원 전체 조회
	@Override
	public List<MemberVO> selectAllMember() {
		logger.info("MemberDAOImplXML.selectAllMember(MemberVO memberVO) 호출!!!!!!!! ");	

		return memberDAO.selectAllMember();
	}
	//회원 개별 조회
	@Override
	public MemberVO selectMember(String id) {
		logger.info("MemberDAOImplXML.selectMember(String id) 호출!!!!!!!! ");	

		return memberDAO.selectMember(id);
	}
	//회원 탈퇴
	@Override
	public int outMember(String id, String pw) {
		logger.info("MemberDAOImplXML.outMember(String id, String pw) 호출!!!!!!!! ");	

		return memberDAO.outMember(id, pw);
	}
	//로그인
	@Override
	public MemberVO loginMember(String id, String pw) {
		logger.info("MemberDAOImplXML.loginMember(String id, String pw) 호출!!!!!!!! ");	

		return memberDAO.loginMember(id, pw);
	}
	//아이디 찾기
	@Override
	public String findID(String tel, Date birth) {
		logger.info("MemberDAOImplXML.findID(String tel, Date birth) 호출!!!!!!!! ");	

		return memberDAO.findID(tel, birth);
	}
	//비밀번호 변경
	@Override
	public int changePW(String id, String pw) {
		logger.info("MemberDAOImplXML.changePW(String id, String pw) 호출!!!!!!!! ");	

		return memberDAO.changePW(id, pw);
	}
	//비밀번호 변경 대상 찾기
	@Override
	public int findPW(MemberVO memberVO) {
		logger.info("MemberDAOImplXML.findPW(MemberVO memberVO) 호출!!!!!!!! ");	

		return memberDAO.findPW(memberVO);
	}


}
