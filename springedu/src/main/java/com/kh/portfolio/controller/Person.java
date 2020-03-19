package com.kh.portfolio.controller;

import javax.persistence.Entity;
import javax.validation.constraints.Max;


import lombok.Data;

@Entity //유효성체크!
@Data
public class Person {
	String	name;
	@Max(value = 30, message = "30미만 입력하세요!" )
	int age;

}

//@size 문자열 길이 유효성체크할때.