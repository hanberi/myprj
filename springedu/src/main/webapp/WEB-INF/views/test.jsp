<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>테스트페이지</h3>

	<form action="<c:url value='/t9' />" method="get">
		<div name="name">이름 : ${person.name }</div>
		<div>나이 : ${person.age }</div>
	</form>
</body>
</html>