package com.kh.portfolio.member.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.vo.MemberVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberDAOImplJDBCTest {
	private final static Logger logger
		= LoggerFactory.getLogger(MemberDAOImplJDBCTest.class);
	
	@Inject 
	@Qualifier("memberDAOImplJDBC")
	MemberDAO memberDAO;
	
	@Test
	@DisplayName("회원등록")
	@Disabled
	void memberInsert() {
		MemberVO memberVO = new MemberVO();
		
//		sql.append("INSERT INTO member ( id, pw, tel, nickname, gender, region, birth, cdate) ");
//		sql.append("VALUES (?,?,?,?,?,?,?,systimestamp) ");
		
		memberVO.setId("test5@naver.com");
		memberVO.setPw("admin1234");
		memberVO.setTel("010-1234-1234");
		memberVO.setNickname("이한별");
		memberVO.setRegion("울산");
		memberVO.setBirth(java.sql.Date.valueOf("2000,03,01"));
		int cnt = memberDAO.joinMember(memberVO);
		assertEquals(1, cnt);
	}
	//회원수정
	@Test
	@DisplayName("회원수정")
	@Disabled
	void modifyMember() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test@naver.com");
		memberVO.setTel("010-1234-1212");
		memberVO.setNickname("관리자2");
		memberVO.setRegion("부산");
		memberVO.setBirth(java.sql.Date.valueOf("2000,01,01"));
		int cnt = memberDAO.modifyMember(memberVO);
		assertEquals(1, cnt);
		
	}
	//회원전체조회
	@Test
	@DisplayName("회원전체조회")
	@Disabled
	void selectAllMember(){
		List<MemberVO> list =  memberDAO.selectAllMember();
		assertNotNull(list);
		logger.info(list.toString());
		
		assertNotNull(list);
	}
	//회원개별조회
	@Test
	@DisplayName("회원개별조회")
	@Disabled
	void selectMember() {
		MemberVO memberVO = memberDAO.selectMember("test@naver.com");
	
		assertEquals("test@naver.com", memberVO.getId());
		logger.info(memberVO.toString());
		
	}
	
	//회원탈퇴
	@Test
	@DisplayName("회원탈퇴")
	@Disabled
	void outMember() {
		int cnt = memberDAO.outMember("test@naver.com", "admin0569");
		assertEquals(1, cnt);
		
	}
	//로그인
	@Test
	@DisplayName("로그인")
	@Disabled
	void loginMember() {
		MemberVO memberVO = memberDAO.loginMember("test@naver.com","admin0569");
		assertEquals("test@naver.com", memberVO.getId());
		logger.info(memberVO.toString());
		
	}
	//아이디찾기
	@Test
	@DisplayName("아이디찾기")
	@Disabled
	void findID() {
		String id = memberDAO.findID("010-1234-1212", new java.sql.Date(2000,1,1));
		assertEquals("test@naver.com", id);
	}
	//비밀번호변경
	@Test
	@DisplayName("비밀번호변경")
	@Disabled
	void changePW() {
		int cnt = memberDAO.changePW("test@naver.com", "admin0569");
		assertEquals(1, cnt);
		
	}
	@Test
	@DisplayName("비밀번호 변경 대상 찾기")
	void findPW() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("admin1212@google.com");
		memberVO.setTel("010-7897-7897");
		memberVO.setBirth(java.sql.Date.valueOf("2020-12-31"));
		
  int cnt = memberDAO.findPW(memberVO);
  assertEquals(1, cnt);
	}
	
}















