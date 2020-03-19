<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대댓글</title>
  <style>
  
/*     * { outline: 1px solid red;	} */
    /* 공통 */
		.rereply11 {
			width: 1200px;
			margin: 37px auto 30px;
		}
		
		.rereply12 {
			justify-content: center;
		}
    .lm-1{ margin-left: 10px; } .lm-2{ margin-left: 20px; } .lm-3{ margin-left: 30px; } .lm-4{ margin-left: 40px; } .lm-5{ margin-left: 50px; }
    .lm-6{ margin-left: 60px; } .lm-7{ margin-left: 30px; } .lm-8{ margin-left: 80px; } .lm-9{ margin-left: 90px; } .lm-10{ margin-left: 100px; }
  
    .fw-1{min-width:10px;} .fw-2{min-width:20px;} .fw-3{min-width:30px;} .fw-4{min-width:40px;} .fw-5{/* min-width:27px; */ }
    .fw-6{min-width:60px;} .fw-7{min-width:50px;} .fw-8{min-width:80px;} .fw-9{min-width:90px;} .fw-10{min-width:100px;}
    .fw-15{padding-top:5px;}
    
    .pw-1{width:10%;} .pw-2{width:20%;} .pw-3{width:30%;} .pw-4{width:40%;} .pw-5{width:50%;}
    .pw-6{width:60%;} .pw-7{width:70%;} .pw-8{width:80%;} .pw-9{width:90%;} .pw-10{width:100%;}

    #reply .row, 
    #replyList .row { display:flex; }

		.row body{
		margin-bottom:10px;
		}
    /* 댓글작성 */
    #reply{
      margin-top:0px; width:100%;
    }
    #reply .row{ display:flex; }    
    #reply #rcontent{ width:100%;  }
    #reply #replyBtn2{ width:80px;  border: 1px soild black; }
    
 .fa-eraser{
    	padding-left: 10px;
    }
    /* 댓글 목록 */  
    #replyList{
      margin-top:20px; width:100%;
    }
    #replyList .row { display:flex; }    
    #replyList .row.header .col:nth-child(4){
      display:flex;
      justify-content: flex-end;
    }
    /* 페이징 */
    #paging {
      margin:20px 0 40px 0;
      display:flex;
      justify-content: center;
    }
    #paging a {
    	padding: 2px;
    	margin: 2px;
    	}
    .row textarea{
    	height: 100px;
    	font-family: 'Muli', sans-serif;
    	text-indent: 3px;
    }
    .row pw-10{
    	margin-bottom: 20PX;
    }
    .replyForm{
    	border-bottom: 1px dashed #dfe4ea;
    	margin-top: 10px;
    	padding-bottom: 10px;
    }
    .goodBtn{
    	color: #ffb8b8;
    }
    .badBtn{
    	color: #ced6e0;
    }
    .fw-5{
    	padding-right: 10px;
    }
    .replyModifyBtn, .replyDeleteBtn, .goodBtn, .badBtn, .rereplyBtn, #replyBtn2{
    	cursor: pointer;
    }
    .rcontent{
    	font-size: 12px;
    	padding-bottom: 5px;
    }
    .rereplyBtn{
    	width: 80px;
    }
  </style>  
	<script>
		window.addEventListener("load",init2,false);
		//let l_bnum = 2068;		//게시 원글번호
		let l_bnum = ${boardVO.bnum }
		let l_page = 1;				//요청페이지
		let l_id 				= "${sessionScope.member.id}";									//로그인 아이디
		let l_nickname 	= "${sessionScope.member.nickname}";						//로그인 별칭
		let l_url 			= "${pageContext.request.contextPath}/rboard"; 	//공통 URL

		const GOOD = '1', BAD = '2'; //호감'1', 비호감'2'

		// 대댓글 작성 html코드 시작--------------------------------
		let rereply_str = "";
		rereply_str = '<div class="row">';
		rereply_str = '<textarea name="rcontent" id="rcontent" rows="3"></textarea>';
		rereply_str = '<button id="rereplyBtn">comment</button>';
		rereply_str = '</div>';
		// 대댓글 작성 html코드 끝----------------------------------
		
		function init2(){

			//댓글목록 가져오기
			replyList(l_page);  //replyList가 코드에 id값 들고온거네 

 			//페이지번호 클릭시 이벤트 처리
			paging.addEventListener("click",function(e){ //pagine도 id값 들고온거
				e.preventDefault();
 				if(e.target.tagName == 'A'){	//paging에 A태그 클릭하면 
 	 				console.log("페이지 클릭됨!!"); 
 	 				l_page = e.target.getAttribute("href"); //페이지를 l_page에 저장
					replyList(l_page);
				} 
			},false);

			//댓글작성
			replyBtn2.addEventListener("click",function(){

				console.log("댓글작성버튼 클릭됨!");

				let rcontentTag = document.getElementById("rcontent")  //textarea
				let rcontent = rcontentTag.value;    //댓글내용 rcontent에 저장
				
				let xhttp = new XMLHttpRequest();
				xhttp.addEventListener("readystatechange",function(){
					if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
						if(this.responseText == 'success'){
							replyList(l_page);
							rcontentTag.value = "";
							rcontentTag.focus(); //댓글창에 포커스 오게하기
						}else{
							console.log('댓글작성오류!!');
						}
					}
				});

			 //전송데이터 json포맷으로 만들기
	     let sendData = {};
	     sendData.bnum  = l_bnum;
	     sendData.rid 	= l_id;
	     sendData.rnickname = l_nickname;
	     sendData.rcontent = rcontent;
	     
	     //자바스크립트 obj => json포맷 문자열 변환
	     let result = JSON.stringify(sendData);
	     //console.log(result);
		     				
	     //post방식
	     xhttp.open("POST",l_url,true);
	     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
	     xhttp.send(result);				
				
			},false);
			let replyListTag = document.getElementById("replyList");
			replyListTag.addEventListener("click",function(e){
				//댓글목록에서 'I'태그의 자식 태그에서만 반응하기
				if(e.target.tagName != 'I') return false;
				//이벤트가 일어난 지점에서 data-rnum속성을 포함한 요소를 찾아서 data-rnum값을 추출한다.
				let parentTags = parents(e.target);//parents는 모든 조상요소 , parent는 즉 바로 상위 조상요소
				let rnumTag    = parentTags.find( tag => {	if(tag.hasAttribute("data-rnum")){//hasAttribute(string):현재 노드에 지정된 이름의 특성이 있는지 여부를 확인합니다
														return tag;
													}});
				let data_rnum =	rnumTag.getAttribute("data-rnum");
				
				   
				if(e.target.classList.contains('replyDeleteBtn')){  //classList는 add, remove, contains, toggle 함수를 제거한다.
					//console.log('삭제버튼 클릭됨'+data_rnum);
					if(confirm('삭제하시겠습니까?')){
						doDelete(e.target, data_rnum); //doDelete 함수
					}
				}else if(e.target.classList.contains('replyModifyBtn')){
					console.log('수정버튼 클릭됨'+data_rnum);

				
					//기존에 수정이나 댓글 창 열려있을때 닫는 행위
					doReplyModifyTrigger(replyListTag,'rereplyCancelBtn');
					doReplyModifyTrigger(replyListTag,'replyModifyCancelBtn');
					
					//1) 아이콘 토글
 					e.target.classList.toggle("replyModifyBtn");
					e.target.classList.toggle("fa-pencil-alt");

					e.target.classList.toggle("replyModifyCancelBtn");
					e.target.classList.toggle("fa-window-close");		 			
					//2) 대댓글수정양식을 대댓글 대상 아래 추가하기 
					console.log(rnumTag);
					console.log(rnumTag.nextElementSibling);
										
					let row_1 = elt("textarea",{name:"rrcontent", class:"rrcontent lm-7", rows:"3"}); //요소를 만드는데 texarea 속성이름이 rcontent 클래스가 rrcon.....
					let row_2 = elt("button",{class:"rreplyModifyBtn"},"수정");							//버튼.....그래서 요렇게 하는 행위가 대댓글을 창을 만듬...
					let rreplyModifyForm = elt("div",{class:"row rreplyModify"},row_1,row_2);
					 					
					row_2.addEventListener("click",function(){
						//대댓글 수정 처리하기
						doModify(data_rnum,row_1.value);
					},false);
					replyListTag.insertBefore(rreplyModifyForm,rnumTag.nextElementSibling);
					replyListTag.getElementsByClassName("rrcontent")[0].value
						= rnumTag.getElementsByClassName("rcontent")[0].textContent;					
				}else if(e.target.classList.contains('replyModifyCancelBtn')){
					console.log('수정버튼 취소 클릭됨'+data_rnum);

					//1)
					e.target.classList.toggle("replyModifyBtn");
					e.target.classList.toggle("fa-pencil-alt");

					e.target.classList.toggle("replyModifyCancelBtn");
					e.target.classList.toggle("fa-window-close");							
					//2) 대댓글입력양식을 제거하기 
					replyListTag.removeChild(rnumTag.nextElementSibling);
					
				}else if(e.target.classList.contains('goodBtn')){
					//console.log('호감버튼 클릭됨'+data_rnum);
					doGoodOrBad(e.target, data_rnum, GOOD);
				}else if(e.target.classList.contains('badBtn')){
					//console.log('비호감버튼 클릭됨'+data_rnum);
					doGoodOrBad(e.target, data_rnum, BAD);
				}else if(e.target.classList.contains('rereplyBtn')){
					console.log('댓글버튼 클릭됨'+data_rnum);
					doReplyModifyTrigger(replyListTag,'rereplyCancelBtn');
					doReplyModifyTrigger(replyListTag,'replyModifyCancelBtn');
					 
					//1) 아이콘 토글  //곱표가 화살표로 이미지 바뀜 수정도 마찬가지  클래스값을 읽어서 토글..있으면없애고 없으면 추가 
 					e.target.classList.toggle("rereplyBtn");
					e.target.classList.toggle("fa-reply");
					e.target.classList.toggle("rereplyCancelBtn");
					e.target.classList.toggle("fa-window-close");
							 			
					//2) 대댓글입력양식을 대댓글 대상 아래 추가하기 
					console.log(rnumTag);
					console.log(rnumTag.nextElementSibling);
					//rnumTag.nextElementSibling.innerHTML = rereply_str;					
					let row_1 = elt("textarea",{name:"rrcontent", class:"rrcontent lm-7", rows:"3"}); //elt함수사용
					let row_2 = elt("button",{class:"rreplyBtn"},"등록");							
					let rreplyForm = elt("div",{class:"row rreply"},row_1,row_2);
					 	
					row_2.addEventListener("click",function(){
						//대댓글 등록 처리하기
						doReply(data_rnum,row_1.value);
					},false);
					
					replyListTag.insertBefore(rreplyForm,rnumTag.nextElementSibling);
					replyListTag.getElementsByClassName("rrcontent")[0].placeholder
						= rnumTag.getElementsByClassName("rnickname")[0].textContent+"님께 답글쓰기";

				}else if(e.target.classList.contains('rereplyCancelBtn')){
	
					//1) 아이콘 토글
					console.log('댓글버튼 클릭됨'+data_rnum);
					e.target.classList.toggle("rereplyBtn");
					e.target.classList.toggle("fa-reply");

					e.target.classList.toggle("rereplyCancelBtn");
					e.target.classList.toggle("fa-window-close");					
					//2) 대댓글입력양식을 제거하기 
					replyListTag.removeChild(rnumTag.nextElementSibling);
				}
			},false);
		}
		
		//이벤트 트리거
		function doReplyModifyTrigger(i_pnode,i_findClass){     //해당 로드에 대해서 쭉 읽어들여서 강제 트리거 클릭 댓글창 수정창 여러개잇다하면 다 찾아서 닫아줌
			Array.from(i_pnode.getElementsByClassName(i_findClass))
			 .forEach(item=>{item.click()});
		}
		
		//댓글 수정
		function doModify(i_rnum,i_rcontent){

			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						replyList(l_page);
					}else{
						console.log('대댓글 수정 오류!!');
					}
				}
			});		
			let sendData = {};
			sendData.rnum = i_rnum; 						//수정할 댓글번호
			sendData.rcontent = i_rcontent;			//대댓글내용
			
			let result = JSON.stringify(sendData);
					
		  xhttp.open("PUT",l_url,true);
		  xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
		  xhttp.send(result);			
		}
		//대댓글 등록
		function doReply(i_rnum,i_rcontent){

			let url = l_url+"/reply";
			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						replyList(l_page);
					}else{
						console.log('대댓글 작성 오류!!');
					}
				}
			});		
			let sendData = {};
			sendData.bnum = l_bnum; 						//게시글 원글
			sendData.rid  = l_id;	 							//작성자
			sendData.rnickname = l_nickname;		//별칭
			sendData.rcontent = i_rcontent;			//대댓글내용
			sendData.prnum =	i_rnum;						//부모댓글 
			
			let result = JSON.stringify(sendData);
					
		  xhttp.open("POST",url,true);
		  xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
		  xhttp.send(result);					
		}
		//댓글 삭제
		function doDelete(i_node, i_rnum){
			let url = l_url+"/"+i_rnum;
			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						replyList(l_page);
					}else{
						console.log('삭제오류!!');
					}
				}
			});			

     xhttp.open("DELETE",url,true); 
     xhttp.send();				
		}
		//호감,비호감
		function doGoodOrBad(i_node, i_rnum, i_vote){
			let url = l_url+"/vote";
			let xhttp = new XMLHttpRequest();
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
						console.log(this.responseText);
					if(this.responseText == 'success'){
						replyList(l_page);
					}else{
						console.log('호감,비호감 오류!!');
					}
				}
			});			
		 let sendData = {};
		 sendData.rnum = i_rnum; //댓글번호
		 sendData.bnum = l_bnum; //게시글 원글
		 sendData.rid  = l_id;	 //작성자
		 sendData.vote = i_vote; //호감,비호감	

		 let result = JSON.stringify(sendData);
		 		
     xhttp.open("PUT",url,true);
     xhttp.setRequestHeader("Content-Type","application/json;charset=utf-8"); 
     xhttp.send(result);				
		}

		
		
		/*-----------------------------------------------------------------------*
		
		 * 노드 생성 함수
		 * 주어진 이름(name)과 속성(attributes), 자식 노드를 포함하는 요소를 만들어서 반환하는 함수
		 *-----------------------------------------------------------------------*/
		function elt(name, attributes) { //요소이름과 속성이름을 매개값으로 받아서 생성
			var node = document.createElement(name);//그 노드와 속성정보 받아서 코드 생성
			if( attributes ) {
				for(var attr in attributes) {
					if(attributes.hasOwnProperty(attr)) {
						node.setAttribute(attr,attributes[attr]);
					}
				}
			}
			for(var i=2; i<arguments.length; i++) {
				var child = arguments[i];
				if( typeof child == "string" ) {
					child = document.createTextNode(child);
				}
				node.appendChild(child);
			}
			return node;
		}
				
		/* 특정 노드를 매개값으로 받아서 조상노드를 찾아서 배열에 저장하기 */
		function parents(node) {     
			let current = node,         
			list    = [];     
			while(	current.parentNode != null && 
							current.parentNode != document.documentElement) {
				//존재하는 부모노드를 배열에 추가       
				list.push(current.parentNode);
				//현재노드 갱신     
				current = current.parentNode;    
			}     
			return list;
		}
				
		//댓글목록 가져오기
		function replyList(reqPage){
			let url = l_url+"/"+l_page+"/"+l_bnum;
			
			console.log(url);
			//Ajax Call
			//1)
			let xhttp = new XMLHttpRequest();
			//2)
			xhttp.addEventListener("readystatechange",function(){
				if(this.readyState == 4 && this.status == 200){
					console.log(this.responseText);
					let jsObj = JSON.parse(this.responseText);
					let str = "";
					jsObj.list.forEach( e => {
/* 						console.log("rnum="+e.rnum);
						console.log("rid="+e.rid);
						console.log("rnickname="+e.rnickname); */

						str += '<div class="row pw-10 replyForm" data-rnum="'+e.rnum+'" >';
						if(e.rindent == 0){
							str += '  <div class="row pw-10">';
						}else{
							str += '  <div class="row pw-10 lm-7">';
						}
						str += '    <div class="col fw-7"><img src="<c:url value='/resources/img/iconfinder_2_330395.png'/>" style="width: 40px;"></div>';
						str += '    <div class="col pw-10">';
						str += '      <div class="row header pw-10">';
						str += '        <div class="col fw-15">';
						str += '					<span><b><small class="rnickname">'+e.rnickname+'</small></b></span>';
						str += '					<span><b><small class="rid">('+e.rid+')</small></b></span></div>';
						str += '        <div class="col fw-15"><small><i>'+e.rcdate+'</i></small></div>';
						str += '        <div class="col"><span><i class="fas fa-reply rereplyBtn" title="댓글달기"></i></span></div>';
						str += '        <div class="col pw-10">';
						str += '          <div class="row">';
						str += '            <div class="col"><span><i class="fas fa-pencil-alt replyModifyBtn" title="수정하기"></i></span></div>	';
						str += '            <div class="col"><span><i class="fas fa-eraser replyDeleteBtn" title="삭제하기"></i></span></div>';
						str += '          </div>';
						str += '        </div>';
						str += '      </div>';
						str += '      <div class="row body">';
						if(e.rindent == 0){
							str += '  <div class="col"></div>';
						}else{
							str += '  <div class="col fw-5 rm-1"><small><b>'+e.prnickname+'</b></small>	</div>';
						}						
						str += '        <div class="col rcontent">'+e.rcontent+'</div>';
						str += '      </div>';
						str += '      <div class="row bottom">';
						str += '        <div class="col fw-5"><span><i class="fas fa-heart goodBtn"  title="호감"></i></span>('+e.good+')</div>';
						str += '        <div class="col fw-5"><span><i class="fas fa-heart-broken badBtn" title="비호감"></i></span>('+e.bad+')</div>';
						str += '      </div>';
						str += '    </div>';
						str += '  </div>';
						str += '</div>';					
 
						document.getElementById('replyList').innerHTML = str;

					});//jsObj.list.forEach 
					
					//페이지징
					//이전페이지 여부
					str = "";
					if(jsObj.pc.prev){
						str += '<a href="1">◀</a>';
					  str += '<a href="'+(jsObj.pc.startPage-1)+'">◁</a>';
					}
					//페이지 1~10
					for(let i=jsObj.pc.startPage, end=jsObj.pc.endPage; i<=end; i++){
						//현재 페이지와 요청페이지가 다르면
						if(jsObj.pc.rc.reqPage != i ){
							str += '<a href="'+i+'">'+i+'</a>';
						}else{
							str += '<a href="'+i+'" class="active">'+i+'</a>';
						}
					}

					//다음페이지 여부
					if(jsObj.pc.next){
				    str += '<a href="'+(jsObj.pc.endPage+1)+'">▷</a>';
				    str += '<a href="'+(jsObj.pc.finalEndPage)+'">▶</a>';
					}		
					document.getElementById('paging').innerHTML = str;		
				}
		  },false);
			//3)
			xhttp.open("GET",url,true);
			xhttp.send();
		}
	</script>
</head>
<body>
	<div class="rereply11">
		<div class="rereply12">
			<div id="replyArea">
  <!-- 댓글 달기 -->
  <div id="reply">
    <div class="row">
      <textarea name="rcontent" id="rcontent" rows="3" placeholder="댓글을 입력해주세요."></textarea>
      <button id="replyBtn2">Comment</button>
    </div>
  </div>
  
	  <!-- 댓글 목록-->
	  <div id="replyList"></div>
	  
	  <!--페이징-->
	  <div id="paging"></div>
  </div>
  </div>
  </div>
</body>
</html>