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

h5 {
	text-align: center;
	padding-bottom: 15px;
	font-family: 'Muli', sans-serif;
	font-size: 14PX;
}

table {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #acacacb6;
	margin-bottom: 50px;
}

th, td {
	border: 1px solid #acacacb6;
	height: 28px;
}

th {
	width: 110px;
	background-color: #F0F0F0;
}
th label{
		font-family: Arial;
  font-size: 10px;
  font-weight: normal;
  letter-spacing: 1pt;
}

td {
	padding: 10px 4px 10px 4px;
		border: 1px solid #acacacb6;
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
	height: 400px;
}

button {
	margin-left: 5px;
}

.bid{
	font-family: Arial;
  font-size: 12px;
  text-indent: 2px;
}
#writeBtn{
	border: 1px #999 solid;
	background-color:WHITE;
		color: #000;
	 letter-spacing: 1pt;
}
#writeBtn:hover{
	background-color: BLACK;
	color: white;
	transition: all .3s;
		font-weight: bold;
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
	background-color: BLACK;
	color: white;
	transition: all .3s;
		font-weight: bold;
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

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
window.addEventListener("load", init, false);
function init() {
	// 등록버튼 클릭시
	writeBtn.addEventListener("click", function(e) {
		e.preventDefault();
		// 유효성 체크

		// 게시글 작성 전송
		document.getElementById("boardVO").submit();
		if(confirm("게시글을 등록하시겠습니까?")){
			document.getElementById("qandAVO").submit();

			}

	}, false);
	// 취소 버튼 클릭시
	cancleBtn.addEventListener("click", function(e) {
		e.preventDefault();
		document.getElementById("boardVO").reset();
	}, false);
	// 목록버튼 클릭시
	listBtn.addEventListener("click", function(e) {
		e.preventDefault();
		let returnPage = e.target.getAttribute('data-returnPage');
		location.href = getContextPath() + "/board/list/"+returnPage;
	}, false);
}
</script>

<body>
	<div>
		<%@ include file="../header.jsp"%>
	</div>

	<!-- body -->

	<form:form
		action="${pageContext.request.contextPath }/board/write/${returnPage}"
		enctype="multipart/form-data" method="post" modelAttribute="boardVO">
		<!-- modelAttribute = id -->
		<div class="lead11">
			<div class="lead12">
				<h5>Q & A</h5>
				<table>
					<tbody>
						<tr>
							<th><form:label path="boardCategoryVO.cid">CATEGORY</form:label></th>
							<td><form:select path="boardCategoryVO.cid">
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
							<th><form:label path="bid">WRITER</form:label></th>
							<td><form:input class="bid" type="text"
								value="${member.nickname }(${member.id})" readonly="true" path="bid"></form:input></td>

						</tr>

						<tr>
							<th><form:label path="bcontent">CONTENT</form:label></th>
							<td><form:textarea cols="30" rows="10" path="bcontent"></form:textarea>
								<form:errors class="errmsg" path="bcontent" /></td>

						</tr>
						<tr>
							<th><form:label path="files">FILE</form:label></th>
							<td><form:input type="file" multiple="multiple" path="files"/>
							</td>
							<form:errors class="errmsg" path="files" />
						</tr>
						<tr>
							<th><form:label path="files">IMAGES</form:label></th>
							<td id="preview"></td>
							<form:errors class="errmsg" path="files" />
						</tr>
						<tr>
							<td colspan="4"><div class="button">
									<form:button class="btn" id="writeBtn">등록</form:button>
									<form:button class="btn" id="cancleBtn">취소</form:button>
									<form:button class="btn" id="listBtn" data-returnPage="${returnPage }">목록</form:button>
								</div></td>
						</tr>


					</tbody>
				</table>

			</div>
		</div>
	</form:form>

	<!-- footer -->
	<div>
		<%@ include file="../footer.jsp"%>
	</div>
</body>
<script>
    var upload = document.querySelector('#files');
    var preview = document.querySelector('#preview');
 
    upload.addEventListener('change',function (e) {
        var get_file = e.target.files;
 
        var image = document.createElement('img');
 
        /* FileReader 객체 생성 */
        var reader = new FileReader();
 
        /* reader 시작시 함수 구현 */
        reader.onload = (function (aImg) {
            console.log(1);
 
            return function (e) {
                console.log(3);
                /* base64 인코딩 된 스트링 데이터 */
                aImg.src = e.target.result
            }
        })(image)
 
        if(get_file){
            /* 
                get_file[0] 을 읽어서 read 행위가 종료되면 loadend 이벤트가 트리거 되고 
                onload 에 설정했던 return 으로 넘어간다.
                이와 함게 base64 인코딩 된 스트링 데이터가 result 속성에 담겨진다.
            */
            reader.readAsDataURL(get_file[0]);
            console.log(2);
        }
 
        preview.appendChild(image);
    })
</script>
</html>