package com.kh.junit;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.dao.MemberDAOImplJDBCTest;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UpdateJbcTemplateTest2 {
	private final static Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBCTest.class);
	
	@Inject
	JdbcTemplate jt;
	
	@Test
	@Disabled
	void update1() {
		StringBuffer sql = new StringBuffer();
		sql.append("update student set kor =? where name =? ");
		int cnt = jt.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, 70);
				pstmt.setString(2, "홍길순");
				return pstmt;
			}
		});
		assertEquals(1, cnt);		
	}	
	@Test
	@Disabled
	void update2() {
		StringBuffer sql = new StringBuffer();
		sql.append("update student set kor = 70 where name ='홍길동'");
		int cnt = jt.update(sql.toString());
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void update3() {
		StringBuffer sql = new StringBuffer();
		sql.append("update student set kor =? where name =? ");
		
		int cnt = jt.update(sql.toString(), 20, "홍길서");
		assertEquals(1, cnt);
		
	}
	@Test
	@Disabled
	void update4() {
		StringBuffer sql = new StringBuffer();
		sql.append("update student set kor =? where name =? ");
		
		int cnt = jt.update(sql.toString(), new PreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setInt(1, 30);
				ps.setString(2, "홍길동");
				
			}
		});
		assertEquals(1, cnt);
	}
	@Test
	void update5() {
		StringBuffer sql = new StringBuffer();
		sql.append("update student set kor =? where name =? ");
		int cnt = jt.update(sql.toString(), 
							new Object[] {30, "홍길동"},
							new int[] {Types.INTEGER, Types.VARCHAR}
		);
		assertEquals(1, cnt);
	}
}

