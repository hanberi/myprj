<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>img_board</title>

<style type="text/css">
.home1 {
		min-width: 100%;
		margin: 10px auto 0px;
		padding: 27px 0 0 0;
		width: 100%;
}
	
.home2 {
	text-align: center;
	min-width: 100%;
}
.online{
	text-align: left;
	font-weight: 900;
	font-size: 13px;
	font-family: "Noto Sans KR", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", sans-serif;
	padding-bottom: 10px;
}
.img_1{
	max-width: 500px;
	display: inline-block;
	font-family: "Malgun Gothic";
	text-align: left;
	
}
.imageTitle{
	font-size: 18px;
	font-weight: 900;
	padding-bottom: 5px;
}
.imageCdate{
	font-size: 13px;
	color: gray;
	font-weight: 900;
}
</style>
<script src="<c:url value='/resources/js/common.js' />"></script>
<link rel="stylesheet" href="<c:url value ="/resources/css/star.css"/>">
   
<body>
<!-- header -->
	<div>
		<%@ include file="../header.jsp"%>
	</div>
<!-- body -->
<form:form action="${pageContext.request.contextPath }/board/image/detail/${returnPage }"
				enctype="multipart/form-data" method="post" modelAttribute="imageBoardVO">
		<%-- 		<form:hidden path="imageNum"/> --%>
				
<div class="home1">
	<div class="home2">
	<h5>introduce my home</h5>
	<div class="img_1">
			<div><img src="${pageContext.request.contextPath }/images/${list.imageUrl}" width="400px" height="400px"></div>
			<div class="online">온라인 집들이</div>
		
			<div class="imageTitle">${list.imageTitle }</div>
			<div class="imageCdate"><fmt:formatDate value="${list.imageCdate }" pattern="yyyy-MM-dd"  /></div>
			
			<!-- 첨부목록 -->
						<tr>
							<c:if test="${!empty files}">
							<th>FILE LIST</th>
							<td id="fileList" colspan="3">
								<c:forEach var="file" items="${files }">
							<img src="${pageContext.request.contextPath}/board/file/${file.fid }"/>
							</c:forEach>
								<c:forEach var="file" items="${files }">
									<p style="display: flex">
									<a class="fileList" href="${pageContext.request.contextPath}/board/file/${file.fid }">${file.fname }</a>
						    		<span style="margin-left:10px" >(${file.fsize/1000 } kb)</span>
						    		<span class="umode" style="margin-left:10px">
						    		
						    			<a href="#none"><i class="fas fa-backspace" data-del_file="${file.fid }"></i></a>
						    		</span>
									</p>
								</c:forEach>
								</td>
								 </c:if>
						</tr>
		</div>
	</div>
</div>	
</form:form>
<!-- footer -->
<div>
	<%@ include file="../footer.jsp"%>
</div>
</body>
</html>