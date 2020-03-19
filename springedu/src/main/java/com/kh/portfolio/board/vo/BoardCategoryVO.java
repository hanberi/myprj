package com.kh.portfolio.board.vo;

import javax.persistence.Entity;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Positive;

import lombok.Data;

@Entity
@Data
public class BoardCategoryVO {
//	@NotNull(message = "분류를 선택하세요!")
//	@Min(value = 1, message = "분류를 선택하세요!")      //이거두개써도됨
	@Positive(message = "분류를 선택하세요")
	private long cid; // CID NOT NULL NUMBER(10)
	private String cname; // CNAME VARCHAR2(60)
}
