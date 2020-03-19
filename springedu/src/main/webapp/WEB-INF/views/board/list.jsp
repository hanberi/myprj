<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시판</title>
<%-- <!-- Bootstrap CSS 가져다 쓸수있음 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/css/bootstrap.css"> --%>
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
		location.href=getContextPath()+"/board/writeForm/"+returnPage;
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
	text-indent: 1em;
}
td {
	/* text-align: center; */
	padding: 7px 0 7px 0;
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
	margin-top: 20px;
	display: inline-block;
		font-family: NanumGothic, "Nanum Gothic", 나눔고딕, Dotum;
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
	padding-TOP: 3px;
	background-color: #F0F0F0;
	border: none;
	font-size: 12px;
	border: 1px solid gray;
} 

tr th{
	font-family: Arial;
  font-size: 10px;
  font-weight: normal;
  letter-spacing: 1pt;
}

.img_wrap {
  width: 300px;
  margin-top: 50px;
}
.img_wrap img {
    max-width: 100%;
}



/* 부트스트랩 */
.page-item:first-child .page-link {
  margin-left: 0;
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem;
}

.page-item:last-child .page-link {
  border-top-right-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
}

.page-item.active .page-link {
  z-index: 3;
  color: #fff;

}

.page-item.disabled .page-link {
  color: #6c757d;
  pointer-events: none;
  cursor: auto;
  background-color: #fff;
  border-color: #dee2e6;
}
.page-link {
  position: relative;
  display: block;
  padding: 0.5rem 0.75rem;
  margin-left: -1px;
  line-height: 1.25;
  background-color: #fff;
  border: 1px solid #dee2e6;
}

.page-link:hover {
  z-index: 2;
  color: #0056b3;
  text-decoration: none;
  background-color: #e9ecef;
  border-color: #dee2e6;
}

.page-link:focus {
  z-index: 3;
  outline: 0;
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.page-item:first-child .page-link {
  margin-left: 0;
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem;
}

.page-item:last-child .page-link {
  border-top-right-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
}

.page-item.active .page-link {
  z-index: 3;
  color: #fff;
  background-color: #007bff;
  border-color: #007bff;
}

.page-item.disabled .page-link {
  color: #6c757d;
  pointer-events: none;
  cursor: auto;
  background-color: #fff;
  border-color: #dee2e6;
}

.pagination-lg .page-link {
  padding: 0.75rem 1.5rem;
  font-size: 1.25rem;
  line-height: 1.5;
}

.pagination-lg .page-item:first-child .page-link {
  border-top-left-radius: 0.3rem;
  border-bottom-left-radius: 0.3rem;
}

.pagination-lg .page-item:last-child .page-link {
  border-top-right-radius: 0.3rem;
  border-bottom-right-radius: 0.3rem;
}

.pagination-sm .page-link {
  padding: 0.25rem 0.5rem;
  font-size: 0.875rem;
  line-height: 1.5;
}

.pagination-sm .page-item:first-child .page-link {
  border-top-left-radius: 0.2rem;
  border-bottom-left-radius: 0.2rem;
}

.pagination-sm .page-item:last-child .page-link {
  border-top-right-radius: 0.2rem;
  border-bottom-right-radius: 0.2rem;
}
.pagination {
  display: -ms-flexbox;
  display: flex;
  padding-left: 0;
  list-style: none;
  border-radius: 0.25rem;
}
.justify-content-center {
  -ms-flex-pack: center !important;
  justify-content: center !important;
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
				Q & A 
				</h5>
				<table>
					<colgroup>
						<col class="bnum" style="width:10%;">
						<!-- 번호  -->
						<col style="width:10%;">
						<!-- 분류 -->
						<col style="width:50%;">
						<!-- 제목 -->
						<col style="width:11%;">
						<!-- 닉네임 -->
						<col style="width:12%;">
						<!-- 작성일 -->
						<col style="width:7%;">
						<!-- 조회수 -->
					</colgroup>

					<thead>
						<tr>
							<th class="NO">NO</th>
							<th class="CATEGORY">CATEGORY</th>
							<th>SUBJECT</th>
							<th class="NICKNAME">WRITER</th>
							<th>DATE</th>
							<th class="HIT">HIT</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rec" items="${list }">
							<fmt:formatDate value="${rec.bcdate }" pattern="yyyy-MM-dd"
								var="cdate" />
							<tr>
								<td class="td" id="no">${rec.bnum }</td>
								<td class="td" id="CATEGORY">${rec.boardCategoryVO.cname }</td>
								
								<td class="td_title">
								<c:forEach begin="1" end="${rec.bindent }">&nbsp;&nbsp;</c:forEach>
										<c:if test="${rec.bindent > 0 }">
								<i class="fas fa-long-arrow-alt-right"></i>
								</c:if>
								<a href="${pageContext.request.contextPath }/board/view/${pc.rc.reqPage}/${rec.bnum}">			
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
		<div id="search">
					<form>
						<select name="searchType" id="searchType">
							<option value="TC"
							<c:out value="${pc.fc.searchType == 'TC' ? 'selected':'' }" />>제목+내용</option>
							<option value="T"
							<c:out value="${pc.fc.searchType == 'T' ? 'selected':'' }" />>제목</option>
							<option value="C"
							<c:out value="${pc.fc.searchType == 'C' ? 'selected':'' }" />>내용</option>
							<option value="N"
							<c:out value="${pc.fc.searchType == 'N' ? 'selected':'' }" />>작성자</option>
							<option value="I"
							<c:out value="${pc.fc.searchType == 'I' ? 'selected':'' }" />>아이디</option>
						</select>
						<input id="keyword" type="search" name="keyword" value="${pc.fc.keyword}" />
						<button id="searchBtn"><i class="fas fa-check"></i></button>
					</form>
				</div>
				<div class="write">
					<button id="writeBtn" data-returnPage="${pc.rc.reqPage }">WRITE</button>
					
				</div>
				
				
				<div>
					<ol >
					<ul class="pagination justify-content-center">
					<!-- 처음페이지/이전페이지 이동 -->
					<c:if test="${pc.prev }">
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/board/list/1"><i class="fas fa-angle-double-left"></i></a></li>
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/board/list/${pc.startPage-1}"><i class="fas fa-angle-left"></i></a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${pc.startPage }" end="${pc.endPage }"> 
						<!-- 현재페이지와 요청페이지가 다르면  -->
						<c:if test="${pc.rc.reqPage != pageNum }">
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/board/list/${pageNum }/${pc.fc.searchType}/${pc.fc.keyword}" >${pageNum }</a></li>
						</c:if>
						<!-- 현재페이지와 요청페이지가 같으면  -->
						<c:if test="${pc.rc.reqPage == pageNum }">
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/board/list/${pageNum }" >${pageNum }</a></li>
						</c:if>
					</c:forEach>
						
						<!-- 다음페이지/최종페이지 이동 -->
					<c:if test="${pc.next }">
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/board/list/${pc.endPage+1}"><i class="fas fa-angle-right"></i></a></li>
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/board/list/${pc.finalEndPage}"><i class="fas fa-angle-double-right"></i></a></li>
					</c:if>
					</ul>
					</ol>
					
				</div>
				
				
				
		</div>
	</div>
	<!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>
</html>