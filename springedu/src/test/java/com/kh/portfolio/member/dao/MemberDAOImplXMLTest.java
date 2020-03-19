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
public class MemberDAOImplXMLTest {
	private final static Logger logger
		= LoggerFactory.getLogger(MemberDAOImplXMLTest.class);
	
	@Inject
	@Qualifier("memberDAOImplXML") //dao 구현클래스 두개라서 이름 정하는것
	MemberDAO memberDAO;
	
	@Test
	@DisplayName("회원등록")
//	@Disabled
	void joinMember() {
		MemberVO memberVO = new MemberVO();
		
	
		memberVO.setId("test@naver.com");
		memberVO.setPw("admin1234");
		memberVO.setTel("010-1234-1234");
		memberVO.setNickname("강동원");
		memberVO.setRegion("울산");
		memberVO.setBirth(java.sql.Date.valueOf("1999-12-12"));
		int cnt = memberDAO.joinMember(memberVO);
		assertEquals(1, cnt);
	}
	//회원수정
	@Test
	@DisplayName("회원수정")
	@Disabled
	void modifyMember() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test1@naver.com");
		memberVO.setTel("010-1234-1212");
		memberVO.setNickname("이한별");
		memberVO.setRegion("서울");
		memberVO.setBirth(new java.sql.Date(1980,01,01));
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
		MemberVO memberVO = memberDAO.selectMember("test1@naver.com");
	
		assertEquals("test1@naver.com", memberVO.getId());
		logger.info(memberVO.toString());
		
	}
	
	//회원탈퇴
	@Test
	@DisplayName("회원탈퇴")
	@Disabled
	void outMember() {
		int cnt = memberDAO.outMember("test1@naver.com", "admin1234");
		assertEquals(1, cnt);
		
	}
	//로그인
	@Test
	@DisplayName("로그인")
	@Disabled
	void loginMember() {
		MemberVO memberVO = memberDAO.loginMember("test8@naver.com","admin1234");
		assertEquals("test8@naver.com", memberVO.getId());
		logger.info(memberVO.toString());
		
	}
	//아이디찾기
	@Test
	@DisplayName("아이디찾기")
	@Disabled
	void findID() {
		String id = memberDAO.findID("010-1234-1343", java.sql.Date.valueOf("1998-03-01"));
		assertEquals("test2@naver.com", id);
	}
	//비밀번호변경
	@Test
	@DisplayName("비밀번호변경")
	@Disabled
	void changePW() {
		int cnt = memberDAO.changePW("test7@naver.com", "admin1234");
		assertEquals(1, cnt);
		
	}
//비밀번호변경대상찾기
	@Test
	@DisplayName("비밀번호 변경 대상 찾기")
	@Disabled
	void findPW() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("admin1212@google.com");
		memberVO.setTel("010-7897-7897");
		memberVO.setBirth(java.sql.Date.valueOf("2020-12-31"));
			
	  int cnt = memberDAO.findPW(memberVO);
	  assertEquals(1, cnt);
	}
	
}















