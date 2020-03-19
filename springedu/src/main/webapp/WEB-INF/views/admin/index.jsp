<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    <!doctype html>
    <html lang="ko">
    <head>
    	<meta charset="UTF-8" />
    	<title>관리자페이지</title>
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value ="/resources/css/star.css"/>">
    
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
                <a href="<c:url value="/admin/index" />"><img src="<c:url value='/resources/img/22.png' />"></a>
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
        <!-- body -->
	<div>
		<%@ include file="../body.jsp"%>
	</div>
        <!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>
</html>