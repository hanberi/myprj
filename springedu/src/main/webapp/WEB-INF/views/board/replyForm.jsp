<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시판</title>
<script src="<c:url value='/resources/js/common.js' />"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<c:url value ="/resources/css/star.css"/>">
<link href="https://fonts.googleapis.com/css?family=Muli&display=swap"
	rel="stylesheet">
<style>
body {
	font-size: 13px;
}

h1 {
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #acacacb6;
}

th, td {
	border: 1px solid #acacacb6;
	height: 28px;
}

th {
	width: 110px;
	background-color: #F0F0F0;
}

td {
	padding: 5px 4px 5px 4px;
}

select, textarea {
	width: 100%;
	box-sizing: border-box;
	height: 22px;
	outline: none;
}

select {
	font-size: 11px;
}

.text {
	width: 100%;
	box-sizing: border-box;
}

.button {
	display: flex;
	justify-content: flex-end;
}

input[type="file"] {
	padding: 2px 2px 2px 4px;
	border: 1px solid #d9d9d9;
	font-size: 12px;
}

textarea {
	height: 300px;
}

button {
	margin-left: 5px;
}

h1 {
	font-family: 'Muli', sans-serif;
}

.btn {
	font-family: 'Muli', sans-serif;
	font-size: 12px;
	width: 46px;
	height: 28px;
	display: inline-block;
	border: 1px #999 solid;
	background: #fff;
	line-height: 26px;
	color: #000;
	text-align: center;
	letter-spacing: 0.05em;
	
}

.btn:hover {
	background-color: #eeeeee;
	color: black;
	transition: all .3s;
}

.row btns{
	position:absolute;
	
}

.lead11 {
	max-width: 100%;
}
/* 오류 메세지 */
.errmsg {
	color: red;
	font-size: 11px;
	/* font-weight: bold; */
}
</style>
<script src="<c:url value='/resources/js/common.js' />"></script>
  <script>
		window.addEventListener("load",init, false);
		function init(){
			//등록버튼 클릭시
			writeBtn.addEventListener("click",function(e){
				e.preventDefault();
				//유효성체크

				//게시글 작성전송
				document.getElementById("boardVO").submit();
				
			},false);
			//취소버튼 클릭시
			cancleBtn.addEventListener("click",function(e){
				e.preventDefault();
				document.getElementById("boardVO").reset();
			},false);
			//목록버튼 클릭시
			listBtn.addEventListener("click",function(e){
				e.preventDefault();
 				let returnPage = e.target.getAttribute('data-returnPage');
				location.href=getContextPath()+"/board/list/"+returnPage;
			},false);			
		}
    </script>
    </head>
<body>
	<div>
		<%@ include file="../header.jsp"%>
	</div>

	<!-- body -->


		<div class="lead11">
			<div class="lead12">
				<h1>Notice</h1>
	<form:form action="${pageContext.request.contextPath }/board/reply/${returnPage }"
		enctype="multipart/form-data" method="post" modelAttribute="boardVO">
		<!-- modelAttribute = id -->
		<form:hidden path="boardCategoryVO.cid" value="${boardVO.boardCategoryVO.cid }" />
		<form:hidden path="bgroup" value="${boardVO.bgroup }"  />
		<form:hidden path="bindent" value="${boardVO.bindent }" />
		<form:hidden path="bstep" value="${boardVO.bstep }" />
				<table>
					<tbody>
						<tr>
							<th><form:label path="boardCategoryVO.cid">CATEGORY</form:label></th>
							<td><form:select path="boardCategoryVO.cid" disabled="true">
									<option class="select" value="0">====== SELECT ======</option>
									<form:options path="boardCategoryVO.cid"
										items="${boardCategoryVO}" itemValue="cid" itemLabel="cname" />
								</form:select> <form:errors class="errmsg" path="boardCategoryVO.cid" /></td>

						</tr>
						<tr>
							<th><form:label path="btitle">SUBJECT</form:label></th>
							<td><form:input class="text" type="text" path="btitle"></form:input>
								<form:errors class="errmsg" path="btitle" /></td>

						</tr>
						<tr>
							<th><label path="bid">NICKNAME</label></th>
							<td><input class="text" type="text"
								value="${member.nickname }(${member.id})" readonly="true"></input></td>

						</tr>

						<tr>
							<th><form:label path="bcontent">CONTENT</form:label></th>
							<td><form:textarea name="" id="" cols="30" rows="10"
									path="bcontent"></form:textarea> <form:errors class="errmsg"
									path="bcontent" /></td>

						</tr>
						<tr>
							<th><form:label path="files">FILE</form:label></th>
							<td><form:input type="file" multiple="multiple" path="files" />파일업로드</td>
							<form:errors class="errmsg" path="files" />
						</tr>
						<tr>
							<td colspan="4"><div class="button">
									
								</div></td>
						</tr>
					</tbody>
				</table>
			<div class="row btns">
			<button type="submit" class="btn" id="writeBtn" >등록</button>
			<button class="btn" id="cancleBtn">취소</button>
			<button class="btn" id="listBtn" data-returnPage="${returnPage }">목록</button>
			</div>
	</form:form>
			</div>
		</div>
	<!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>
</html>