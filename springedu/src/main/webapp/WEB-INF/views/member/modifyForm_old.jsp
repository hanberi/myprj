<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>회 원 정 보 수정</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/memberModify.css' />">
<script src="<c:url value='/resources/js/memberModify.js' />"></script>
</head>
<body>
	<%@ include file="../header.jsp"%>

	<form id="joinFrm" action="<c:url value='/member/modify' />"
		method="post">
		<div class="container11">
			<div class="content">
				<div>
					<h2 class="join-title">회원정보수정</h2>
				</div>
				<div>
					<label for="id">아이디</label>
				</div>
				<div>
					<input type="text" name="id" id="id" value="${memberVO.id }"
						readonly="readonly">
				</div>
				<div>
					<span class="errmsg" id="id_errmsg"></span>
				</div>
				<div>
					<label for="pw">비밀번호</label>
				</div>
				<div>
					<input type="password" name="pw" id="pw">
				</div>
				<div>
					<span class="errmsg" id="pw_errmsg"></span>
				</div>
				<div>
					<label for="tel">전화번호</label>
				</div>
				<div>
					<input type="tel" name="tel" id="tel" value="${memberVO.tel }">
				</div>
				<div>
					<span class="errmsg" id="tel_errmsg"></span>
				</div>
				<div>
					<label for="nickname">별칭</label>
				</div>
				<div>
					<input type="text" name="nickname" id="nickname"
						value="${memberVO.nickname }">
				</div>
				<div>
					<span class="errmsg" id="nickname_errmsg"></span>
				</div>
				<div>
					<label for="region">지역</label>
				</div>
				<div>
					<select name="region" id="region">
						<option value="">== 선 택 ==</option>
						<option value="서울"
							${memberVO.region == "서울" ? 'selected="selected"' : '' }>서울</option>
						<option value="경기"
							${memberVO.region == "경기" ? 'selected="selected"' : '' }>경기</option>
						<option value="대구"
							${memberVO.region == "대구" ? 'selected="selected"' : '' }>대구</option>
						<option value="부산"
							${memberVO.region == "부산" ? 'selected="selected"' : '' }>부산</option>
						<option value="울산"
							${memberVO.region == "울산" ? 'selected="selected"' : '' }>울산</option>
					</select>
				</div>
				<div>
					<span class="errmsg" id="region_errmsg"></span>
				</div>
				<div>
					<label for="men">성별</label>
				</div>
				<div>
					<input type="radio" name="gender" id="men" value="남"
						${memberVO.gender == "남" ? 'checked="checked"' : ''}><label
						for="men">남</label> <input type="radio" name="gender" id="women"
						value="여" ${memberVO.gender == "여" ? 'checked="checked"' : ''}><label
						for="women">여</label>
				</div>
				<div>
					<span class="errmsg" id="gender_errmsg"></span>
				</div>
				<div>
					<label for="tel">생년월일</label>
				</div>
				<div>
					<input type="date" name="birth" id="birth"
						value="${memberVO.birth }">
				</div>
				<div>
					<span class="errmsg" id="birth_errmsg"></span>
				</div>
				<div>
					<button type="submit" id="modifyBtn">수 정 하 기</button>
				</div>
			</div>
		</div>
	</form>

	<%@ include file="../footer.jsp"%>
</body>
</html>