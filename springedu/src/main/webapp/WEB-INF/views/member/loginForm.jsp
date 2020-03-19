<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>로 그 인</title>
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/resources/css/login.css' />">
<script src="<c:url value='/resources/js/login.js' />"></script>
</head>
<body>
	<%@ include file="../header.jsp"%>

	<div class="container11">
		<div class="container12">
			<div class="login-wrapper">
				<form id="frm" action="<c:url value='/login?reqURI=${reqURI }' />" method="post">
					<div>
						<h3 class="login-title">MEMBER LOGIN</h3>
					</div>
					<div class="login-content">
						<div>
							<input type="text" name="id" id="id" value="" placeholder="ID">
						</div>
						<div>
							<span id="idMsg"></span>
						</div>
						<div>
							<input type="password" name="pw" id="pw" placeholder="PASSWORD">
						</div>
						<div>
							<span id="pwMsg" class="errmsg"><c:if
									test="${!empty svr_msg}">${svr_msg }</c:if></span>
						</div>
						<div>
							<input type="submit" name="" id="loginBtn" value="로 그 인">
						</div>
					</div>
				</form>
				<div class="find_info">
					<a href="<c:url value='/member/findIDForm' />">아이디 찾기</a> <span>|</span>
					<a href="<c:url value='/member/findPWForm' />">비밀번호 찾기</a> <span>|</span>
					<a href=<c:url value='/member/joinForm' />>회원가입</a>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../footer.jsp"%>
</body>

</html>