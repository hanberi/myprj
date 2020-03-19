<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>회원목록조회</title>
  <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/resources/css/memberList.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/star.css' />">
</head>
<body>
	<!-- header -->
	<header>
		<div class="container">
			<div class="item_box1">
				<c:if test="${empty member }">
					<ul>
						<li id="box1_1"><a href="<c:url value='/loginForm' />">로그인</a></li>
						<li><a href="<c:url value = '/member/joinForm' />">회원가입</a></li>
						<li><a href="<c:url value = '/member/findIDForm' />">아이디찾기</a></li>
						<li><a href="<c:url value = '/member/findPWForm' />">비밀번호찾기</a></li>

						<div class="browse">
							<input type="text" placeholder="통합검색">
							<button>
								<img src="<c:url value='/resources/img/ㅂㄱ.png' />">
							</button>
						</div>
					</ul>
				</c:if>
				<c:if test="${!empty member }">
					<ul>
						<li id="box1_1"><a href="<c:url value='/logout' />">로그아웃</a></li>
						<li><a
							href="<c:url value = '/member/modifyForm/${sessionScope.member.id }' />">${sessionScope.member.nickname }님 반갑습니다!</a></li>

							<c:if test="${sessionScope.member.admin > 0 }">
						<li><a href="<c:url value = '/admin/memberList' />">회원목록</a></li>
							</c:if>

						<div class="browse">
							<input type="text" placeholder="통합검색">
							<button>
								<img src="<c:url value='/resources/img/ㅂㄱ.png' />">
							</button>
						</div>
					</ul>
				</c:if>


				<div class="logo_Img">
					<a href="<c:url value="/" />"><img
						src="<c:url value='/resources/img/22.png' />"></a>
				</div>
			</div>
	</header>
	<!-- nav -->
	<nav class="menu">
		<ul>
			<li><a href="#">홈</a></li>
			<li><a href="#">사진</a></li>
			<li><a href="${pageContext.request.contextPath }/board/image/list.do">집들이</a></li>
			<li><a href="#">노하우</a>
				<ul class="slide">
					<li><a href="#">가구추천</a></li>
					<li><a href="#">전셋집꾸미기</a></li>
					<li><a href="#">리모델링</a></li>
					<li><a href="#">셀프인테리어</a></li>
				</ul></li>
			<li><a href="${pageContext.request.contextPath }/bb/QandAlist">공지사항</a></li>
			<li><a href="#">고객센터</a>
				<ul class="slide">
					<li><a href="${pageContext.request.contextPath }/board/list">Q & A</a></li>
					<li><a href="#">커뮤니티</a></li>
					<li><a href="#">자주하는 질문</a></li>

				</ul></li>
		</ul>
	</nav>
<table border="1" style="border-collapse: collapse;">
<caption><h3> 회원목록 </h3></caption>
	<colgroup>
		<!-- ID -->
		<col style="width:10%;"/>
		<!-- PW -->
		<col style="width:10%;"/>
		<!-- TEL -->
		<col style="width:10%;"/>
		<!-- NICKNAME -->
		<col style="width:10%;"/>
		<!-- GENDER -->
		<col style="width:10%;"/>
		<!-- REGION -->
		<col style="width:10%;"/>
		<!-- BIRTH -->
		<col style="width:10%;"/>
		<!-- CDATE -->
		<col style="width:10%;"/>
		<!-- UDATE -->
		<col style="width:10%;"/>
	</colgroup>
		<thead>
<tr>
<th>ID</th>
<th>PW</th>
<th>TEL</th>
<th>NICKNAME</th>
<th>GENDER</th>
<th>REGION</th>
<th>BIRTH</th>
<th>CDATE</th>
<th>UDATE</th>
</tr>
	</thead>
<tbody>
<c:forEach var="rec" items="${memberList }">
<tr>
<td>${rec.id }</td>
<td>${rec.pw }</td>
<td>${rec.tel }</td>
<td>${rec.nickname }</td>
<td>${rec.gender }</td>
<td>${rec.region }</td>
<td>${rec.birth }</td>
<td>${rec.cdate }</td>
<td>${rec.udate }</td>
</tr>
</c:forEach>
</tbody>
</table>
        <!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>

</html>