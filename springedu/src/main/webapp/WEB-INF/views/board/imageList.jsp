<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>img_board</title>
<script src="<c:url value='/resources/js/common.js' />"></script>
<link rel="stylesheet" href="<c:url value ="/resources/css/star.css"/>">

<style type="text/css">
	
.home1 {
		min-width: 1500px;
		max-width: 1600px;
		margin: 10px auto 0px;
		padding: 27px 0 0 0;
		width: 100%;
	}
	
	.home2 {
		text-align: center;
		min-width: 100%;
	} 
    .img_board{
         display: inline-block;
         /* outline: 1px solid; */
         padding: 30px 20px 30px 20px;
     }
     .img_board ul{
         text-align: center;
     }
     .img_board_content{
    	  font-family: Arial;
		  font-size: 13px;
		  font-weight: normal;
		  letter-spacing: 1pt;
		  line-height: 24px;
     }
	 .img_board_content img{
	 	border-radius: 	1em;
	 }
	 #imageTitle{
	 	font-size: 15px;
	 	overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 300px; 
	 }
</style>
<script type="text/javascript">
$(document).ready(function(){
	//등록 유효성검사
	$("#")
}
</script>
<body>
<!-- header -->
	<div>
		<%@ include file="../header.jsp"%>
	</div>
<!-- body -->
<div class="home1">
	<div class="home2">
		<a href="${pageContext.request.contextPath }/board/image/imageWrite"><input type="button" value="글쓰기" ></a>
		<h5>introduce my home</h5>
	
		<c:forEach var="row" items="${list }">
			<div class="img_board">
			    <div>
			    
			        <div class="img_board_content">
					<a href="${pageContext.request.contextPath }/board/image/detail/${row.imageNum}">
		    			<img src="${pageContext.request.contextPath }/images/${row.imageUrl}" width="300px" height="300px"></a>
					</div>
					
			        <div class="img_board_content" id="imageTitle">
			        	<b>${row.imageTitle }</b>
			        </div>
			        
			        <div class="img_board_content">
			       		 ${row.imageId }
			        </div>
			        
			        <div class="img_board_content">
			        	조회수 : ${row.imageHit }
			        </div>
			        
			    </div>
			</div>
		</c:forEach>
	</div>
</div>

<!-- footer -->
<div>
	<%@ include file="../footer.jsp"%>
</div>

</body>
</html>