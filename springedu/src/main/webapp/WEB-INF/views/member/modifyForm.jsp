<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

	<form:form id="joinFrm"
		action="${pageContext.request.contextPath }/member/modify"
		modelAttribute="mvo" method="post">
		<div class="container11">
			<div class="container12">
				<div class="content">
					<div>
						<h2 class="join-title">회원정보수정</h2>
					</div>
					<div>
						<form:label path="id">아이디</form:label>
					</div>
					<div>
						<form:input type="text" path="id" readonly="true" />
					</div>
					<div>
						<form:errors path="id" cssClass="errmsg" id="id_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="pw">비밀번호</form:label>
					</div>
					<div>
						<form:input type="password" path="pw" />
					</div>
					<div>
						<form:errors path="pw" cssClass="errmsg" id="pw_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="tel">전화번호</form:label>
					</div>
					<div>
						<form:input type="tel" path="tel" />
					</div>
					<div>
						<form:errors path="tel" cssClass="errmsg" id="tel_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="nickname">별칭</form:label>
					</div>
					<div>
						<form:input type="text" path="nickname" />
					</div>
					<div>
						<form:errors path="nickname" cssClass="errmsg"
							id="nickname_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="region">지역</form:label>
					</div>
				<div>
						<form:input type="text" path="region" />
					</div>
					<div>
						<form:errors path="region" cssClass="errmsg" id="region_errmsg"></form:errors>
					</div>
				
					<div>
						<form:label path="gender">성별</form:label>
					</div>
					<div>
						<form:radiobuttons path="gender" items="${gender }" itemValue="code" itemLabel="label" />
					</div>
					<div>
						<form:errors path="gender" cssClass="errmsg" id="gender_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="tel">생년월일</form:label>
					</div>
					<div>
						<form:input type="date" path="birth" />
					</div>
					<div>
						<form:errors path="birth" cssClass="errmsg" id="birth_errmsg"></form:errors>
					</div>
					<div style="color: #f00; font-weight: bold; font-size: 0.8 .rem">${svr_msg }</div>
					<span>
					<button type="submit" id="modifyBtn">수 정 하 기</button>
					</span>
					<span>
					<a href="${pageContext.request.contextPath }/member/outForm"><div id="outBtn">회 원 탈 퇴</div></a>
					</span>
				</div>
			</div>
		</div>
	</form:form>

	<%@ include file="../footer.jsp"%>
</body>
</html>