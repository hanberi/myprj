<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시판</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<script src="<c:url value='/resources/js/common.js' />"></script>
<link rel="stylesheet" href="<c:url value ="/resources/css/list.css"/>">
<link href="https://fonts.googleapis.com/css?family=Muli&display=swap"
	rel="stylesheet">
<script>
window.addEventListener("load",init,false);

function init(){
	//글쓰기 버튼 클릭시
	writeBtn.addEventListener("click",function(e){
		e.preventDefault();
		let returnPage = e.target.getAttribute('data-returnPage');
		location.href=getContextPath()+"/bb/QandAWriteForm/";
	},false);

	//검색버튼 클릭시
	searchBtn.addEventListener("click",function(e){
		e.preventDefault();
		//console.log("검색!!");
		// 검색어 입력값이 없으면
		if(keyword.value.trim().length == 0) {
			alert('검색어를 입력하세요!');
			keyword.value="";
			keyword.focus();
			return false;
		}

		let stype = searchType.value; 			//검색유형
		let kword = keyword.value.trim();		//검색어

		location.href = getContextPath() + "/board/list/1/" + stype + "/" + kword;
	},false);
}
</script>
<style>
table {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #acacacb6;
	font-size: 12px;
}

th, td {
	border: 1px solid #acacacb6;
	height: 35px;
}

th {
	/* width: 150px; */
	text-align: center; 
	background-color:#FFFFFF;
	padding: 10px 0 10px 0;
}
.td{
	text-align: center; 
}
.td_title{
	text-indent: 2em;
}
td {
	/* text-align: center; */
	padding: 7px 0 7px 0;
}
tr th{
	font-family: Arial;
  font-size: 10px;
  font-weight: normal;
  letter-spacing: 1pt;
}

h5 {
	text-align: center;
	padding-bottom: 15px;
	font-family: 'Muli', sans-serif;
}

.write {
	float: right;
	margin-top: 10px;
}
.on{
	font-size:13px;
	color: balck;
	font-weight: 999;
}
.off{
	font-size:13px;
	color: gray;
}

.paging ol {
	text-align: center;
	margin-left: 30px;
}

.paging li {
	display: inline-block;
	margin: 30px 3px; 0 -1 px;

}

.paging a{
	padding: 0 5px 0 5px;
} 

#writeBtn {
	font-family: 'Muli', sans-serif;
	font-size: 12px;
	width: 80px;
	height: 31px;
	display: inline-block;
	border: 1px #999 solid;
	background-color:WHITE;
	line-height: 28px;
	color: #000;
	text-align: center;
	letter-spacing: 0.05em;
	font-weight: bold;
	margin-top: 10px;
}

#writeBtn:hover {
	background-color: BLACK;
	color: white;
	transition: all .3s;
}

.lead11 {
	max-width: 100%;
}
 #search{
	text-align: center;
}
#searchType{
	padding-bottom: 7px;
	font-size: 12px;
}
#keyword{
	padding-bottom: 5px;
}
#searchBtn{
	padding-bottom: 6px;
	background-color: #F0F0F0;
	border: none;
	font-size: 12px;
	border: 1px solid gray;
} 

</style>
<body>
	<!-- header -->
	<div>
		<%@ include file="../header.jsp"%>
	</div>
	<!-- body -->
	<div class="lead11">
		<div class="lead12">
			<h5>
				NOTICE
				</h5>
				<table>
					<colgroup>
						<col style="width:10%;">
						<!-- 번호  -->
						<col style="width:50%;">
						<!-- 제목 -->
						<col style="width:10%;">
						<!-- 닉네임 -->
						<col style="width:10%;">
						<!-- 작성일 -->
						<col style="width:10%;">
						<!-- 조회수 -->
					</colgroup>

					<thead>
						<tr>
							<th class="NO">NO</th>
							<th>SUBJECT</th>
							<th class="NICKNAME">NICKNAME</th>
							<th>DATE</th>
							<th class="HIT">HIT</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rec" items="${qlist }">
							<fmt:formatDate value="${rec.bcdate }" pattern="yyyy-MM-dd"
								var="cdate" />
							<tr>
								<td class="td" id="no">${rec.bnum }</td>
								<td class="td_title">
								<c:forEach begin="1" end="${rec.bindent }">&nbsp;&nbsp;</c:forEach>
										<c:if test="${rec.bindent > 0 }">
								<i class="fas fa-long-arrow-alt-right"></i>
								</c:if>
								<a href="${pageContext.request.contextPath }/bb/QandAview/${pc.rc.reqPage}/${rec.bnum}">			
									${rec.btitle }
									</a>
									</td>
									
								<td class="td">${rec.bnickname }</td>
								<td class="td">${cdate }</td>
								<td class="td" id="HIT">${rec.bhit }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		
				<div class="write">
					<button id="writeBtn" data-returnPage="${pc.rc.reqPage }">WRITE</button>
				</div>
		</div>
	</div>
	<!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>
</html>