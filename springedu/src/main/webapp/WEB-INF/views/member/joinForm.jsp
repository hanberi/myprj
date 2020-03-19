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
<title>회원가입</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/memberjoin.css' />">
<script src="<c:url value='/resources/js/memberjoin.js' />"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- <script src="/resources/js/addressapi.js"></script> -->
</head>
<body>
<%@ include file="../header.jsp"%>
	<form:form id="joinFrm"
		action="${pageContext.request.contextPath }/member/join"
		modelAttribute="mvo" method="post">
		<div class="container11">
			<div class="container12">
				<div class="content">
					<div>
						<h2 class="join-title">MEMBER JOIN</h2>
					</div>
					<div>
						<form:label path="id">아이디</form:label>
					
					</div>
					<div>
						<form:input type="text" path="id" placeholder="ID" maxlength="40" />
					</div>
					<div>
						<form:errors path="id"  cssClass="errmsg" id="id_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="pw">비밀번호</form:label>
					</div>
					<div>
						<form:input type="password" path="pw" placeholder="PASSWORD" maxlength="10" />
						</i>
					</div>
					<div>
						<form:errors path="pw" cssClass="errmsg" id="pw_errmsg"></form:errors>
					</div>

					<div>
						<label for="pwChk">비밀번호 재확인</label>
					</div>
					<div>
						<input type="password" id="pwChk" placeholder="PASSWORD CHECK" maxlength="10" ></i>
					</div>
					<div>
						<span class="errmsg" id="pwChk_errmsg"></span>
					</div>

					<div>
						<form:label path="tel">전화번호</form:label>
					</div>
					<div>
						<form:input type="tel" path="tel" placeholder="TEL" maxlength="13"  />
						</i>
					</div>
					<div>
						<form:errors path="tel" cssClass="errmsg" id="tel_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="nickname">별칭</form:label>
					</div>
					<div>
						<form:input type="text" path="nickname" placeholder="NICKNAME" maxlength="10" />
						</i>
					</div>
					<div>
						<form:errors path="nickname" cssClass="errmsg"
							id="nickname_errmsg"></form:errors>
					</div>
				

					<div class="form-group">       
					<div>
						<form:label path="region">지역</form:label>
					</div>            
					    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i>우편번호</button>                               
					<div><form:input class="form-control"  style="width: 40%; display: inline;" placeholder="우편번호" path="region" type="text" readonly="readonly" /></div>
					</div>
					<div class="form-group1">
					    <form:input  class="form-control" style="top: 5px;" placeholder="도로명 주소" path="region" type="text" readonly="readonly" />
					</div>
					<div class="form-group2">
					    <form:input class="form-control"  placeholder="상세주소" path="region" type="text"  />
					</div>
					
					<div>
						<form:label path="gender">성별</form:label>
					</div>
					<div>
						<form:radiobuttons path="gender" items="${gender }"
							itemValue="code" itemLabel="label" />
					</div>
					<div>
						<form:errors path="gender" cssClass="errmsg" id="gender_errmsg"></form:errors>
					</div>
					<div>
						<form:label path="tel">생년월일</form:label>
					</div>
					<div>
						<form:input type="date" path="birth" />
						</i>
					</div>
					<div>
						<form:errors path="birth" cssClass="errmsg" id="birth_errmsg"></form:errors>
					</div>
					<span class="msg"
						style="color: #f00; font-weight: bold; font-size: 0.8em;">${svr_msg }</sapn>
						<div>
							<button type="submit" id="joinBtn">가 입 하 기</button>
						</div>
				</div>
			</div>
		</div>
	</form:form>


	<%@ include file="../footer.jsp"%>
</body>

</html>