package com.kh.junit;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

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
public class InsertJdbcTemplateTest {
	private final static Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBCTest.class);
	
	@Inject
	JdbcTemplate jt;
	@Test
	@Disabled
	void insert() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		//PreparedStatementCreator클래스일수도있고 인터페이스일수도 있음
		//update 첫번째
		int cnt = jt.update(new PreparedStatementCreator() {
			
			@Override   //익명클래스
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "id1");
				pstmt.setString(2, "홍길동");
				pstmt.setInt(3, 100);
				pstmt.setInt(4, 80);
				pstmt.setInt(5, 90);
				return pstmt;
			}
		});
		assertEquals(1,cnt);
	}
	@Test
	@Disabled
	void insert2() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values('id2','홍길순',90,90,90) ");
		//update 두번째
		int cnt = jt.update(sql.toString());
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void insert3() {
		//update 4번쨰
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		int cnt = jt.update(sql.toString() , "id3","홍길서",80,80,80);
		assertEquals(1, cnt);
	}
	
	@Test
	@Disabled
	void insert4() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		int cnt = jt.update(sql.toString(), new PreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setString(1, "id4");
				ps.setString(2, "홍길남");
				ps.setInt(3, 20);
				ps.setInt(4, 40);
				ps.setInt(5, 100);
			}
		});
		assertEquals(1, cnt);
		}
	
	@Test
	void insert5() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		//update마지막꺼
		int cnt = jt.update(
							sql.toString(),
							new Object[] {"id6","박길동",30,80,70}, 
							new int[] {Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER}
							);
		assertEquals(1, cnt);
	}

}







