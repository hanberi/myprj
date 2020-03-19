<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시판</title>
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-1/css/all.min.css" />
<script src="<c:url value='/resources/js/common.js' />"></script>
<link rel="stylesheet" href="<c:url value ="/resources/css/star.css"/>">
<script>
window.addEventListener("load",init, false);
function init(){
	changeMode(false);
	let modifyBtn = document.getElementById('modifyBtn');
	let deleteBtn = document.getElementById('deleteBtn');
  //답글
	replyBtn.addEventListener("click",function(e){
		e.preventDefault();
		console.log("답글");
			let returnPage = e.target.getAttribute('data-returnPage');
			let bnum = e.target.getAttribute('data-bnum');
			location.href = getContextPath()+"/board/replyForm/"+returnPage+"/"+bnum;
	},false);

  //수정
  if(modifyBtn != null){
	modifyBtn.addEventListener("click",function(e){
		e.preventDefault();
		//console.log("수정");
		changeMode(true);
	},false);
  }
  //삭제
  if(deleteBtn !=null){
	deleteBtn.addEventListener("click",function(e){
		e.preventDefault();
		//console.log("삭제"+e.target.getAttribute('data-del_bnum'));

			if (confirm("삭제하시겠습니까?")){
			let returnPage = e.target.getAttribute('data-returnPage');
			let bnum = e.target.getAttribute('data-bnum');
			location.href = getContextPath()+"/board/delete/"+returnPage+"/"+bnum;
		} 
	},false);
  }

  //취소(수정모드->읽기모드)
	cancelBtn.addEventListener("click",function(e){
		e.preventDefault();
		console.log("취소");
		changeMode(false);
	},false);
  //저장	
	saveBtn.addEventListener("click",function(e){
		e.preventDefault();
		console.log("저장");
		//유효성체크

		//
		document.getElementById('boardVO').submit();
		
	},false);      

  //목록
	listBtn.addEventListener("click",function(e){
		e.preventDefault();
		console.log("목록");
		let returnPage = e.target.getAttribute('data-returnPage');
		location.href=getContextPath()+"/bb/QandAlist/";
	},false);   

	//첨부파일 1건 삭제 : Ajax로 구현함.
	let fileList = document.getElementById('fileList');
	if(fileList != null ) {
		fileList.addEventListener("click",function(e){
			console.log(e.target); //이벤트가 발생된 요소
			console.log(e.currentTarget);//이벤트가 등록된 요소
			console.log(e.target.tagName);
			//선택된 요소가 첨부파일 삭제 아이콘일때만 삭제처리 수행
			if(e.target.tagName != 'I') return false;
			if(!confirm('삭제하시겠습니까?')) return false;
			//실제 이벤트가 발생한요소의 data-del_file속성값 읽어오기
			let fid = e.target.getAttribute('data-del_file');

		  //AJAX 사용
		  //1) XMLHttpRequest객체 생성	
		  var xhttp = new XMLHttpRequest();
		  
		  //2) 서버응답처리
		  xhttp.addEventListener("readystatechange",ajaxCall,false);
		  function ajaxCall(){
			  if (this.readyState == 4 && this.status == 200) {
				  console.log(this.responseText);
				  if(this.responseText == "success"){
				  	console.log('성공!!');
				  	//삭제대상 요소 찾기
					  	let delTag = e.target.parentElement.parentElement.parentElement;
					  	//부모요소에서 삭제대상 요소 제거
				  	fileList.removeChild(delTag); 
				  }else{
				  	console.log('실패!!');
				  }
			  }
		  }
		 	  			  
		  //post방식
		  xhttp.open("DELETE","http://localhost:9080/portfolio/board/file/"+fid,true);
		  xhttp.send();
		},false);  
	}
}

//읽기 모드 , 수정모드
function changeMode(flag){						
		let rmodes = document.getElementsByClassName("rmode");
		let umodes = document.getElementsByClassName("umode");
	//수정모드	
	if(flag){
		//제목변경 => 게시글 보기
		document.getElementById("title").textContent = 'Notice Modify';
		//분류,필드 제목,내용 필드		
		document.getElementById("btitle").removeAttribute("readOnly");			
		document.getElementById("bcontent").removeAttribute("readOnly");			
		//수정모드버튼 활성화
		Array.from(rmodes).forEach(e=>{e.style.display="none";});
		Array.from(umodes).forEach(e=>{e.style.display="block";});
	//읽기모드	
	}else{
		//제목변경 => 게시글 보기
		document.getElementById("title").textContent = 'Notice';
		//분류,필드 제목,내용 필드					
		document.getElementById("btitle").setAttribute("readOnly",true);
		document.getElementById("bcontent").setAttribute("readOnly",true);	
		//읽기모드버튼 활성화				
		Array.from(rmodes).forEach(e=>{e.style.display="block";});
		Array.from(umodes).forEach(e=>{e.style.display="none";});
	}
}
  </script>

<style>
#btitle, #bcontent {
	border: none;
}

body {
	font-size: 13px;
}

h1 {
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	height: 28px;
}

th {
	width: 110px;
	background-color: #c7ecee;
	border-right: 1px solid #b2bec3;
	border-bottom: 1px solid #b2bec3;
	border-top: 1px solid #b2bec3;
}

td {
	padding: 5px 4px 5px 4px;
	border-bottom: 1px solid #b2bec3;
	border-top: 1px solid #b2bec3;
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
	background: white;
	line-height: 26px;
	color: #000;
	text-align: center;
	letter-spacing: 0.05em;
}

.btn:hover {
	background-color: #f9ca24;
	color: white;
	transition: all .3s;
}

.lead11 {
	max-width: 100%;
}
.btitle{
	font-size: 10px;
}

/* 오류 메세지 */
.errmsg {
	color: red;
	font-size: 11px;
	/* font-weight: bold; */
}
</style>
<body>
	<div>
		<%@ include file="../header.jsp"%>
	</div>

	<!-- body -->
	<div class="lead11">
		<div class="lead12">

			<form:form action="${pageContext.request.contextPath }/bb/QandAview" method="post" modelAttribute="qandAVO" >
				<%-- <form:hidden path="bnum"/> --%>
				<h1 id="title">Notice</h1>
				<table>
						
						<tr>
							<th><form:label path="btitle">TITLE</form:label>
							</th>
							<td colspan="3"><form:input type="text" path="btitle"
									readOnly="true" /></td>
						</tr>

						<tr>
							<th><label path="bid">ID</label></th>
							<td colspan="3">${qandAVO.bnickname }(${qandAVO.bid })</td>
						</tr>

						<tr>
							<th><form:label path="bcontent">CONTENT</form:label></th>
							<td colspan="3"><form:textarea class="col-2" rows="10"
									path="bcontent" readOnly="true"></form:textarea></td>
						</tr>
		

						<!-- 버튼 -->
						<tr>
							<td colspan="6">
								<div class="button">
									<form:button class="btn rmode" id="replyBtn" data-returnPage="${returnPage }" data-bnum="${qandAVO.bnum }">답글</form:button>
									
									<!-- 작성자만 수정, 삭제 가능 시작-->
									<c:if test="${sessionScope.member.id == qandAVO.bid }">
									<form:button class="btn rmode" id="modifyBtn">수정</form:button>
									<form:button class="btn rmode" id="deleteBtn" data-returnPage="${returnPage }" data-bnum="${qandAVO.bnum }">삭제</form:button>
									</c:if>
									<!-- 작성자만 수정, 삭제 가능 끝-->
									
									<form:button class="btn umode" id="cancelBtn">취소</form:button>
									<form:button class="btn umode" id="saveBtn" >저장</form:button>
									<form:button class="btn" id="listBtn" data-returnPage="${returnPage }">목록</form:button>
								</div>
							</td>
						</tr>
						
				</table>
			</form:form>
		</div>
	</div>

	<!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>
</html>