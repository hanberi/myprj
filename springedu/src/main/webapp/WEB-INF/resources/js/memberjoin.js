
window.addEventListener("load",init,false);

function init(){
  joinBtn.addEventListener("click",function(e){
    e.preventDefault();
    document.getElementById("joinFrm").submit()
    
 if(checkValid()){
// 유효성 통과하면 메인화면으로 이동
location.href="main.html";
document.getElementById("joinFrm").submit();
}
},false);
}

function execPostCode() {
  new daum.Postcode({
      oncomplete: function(data) {
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
         var extraRoadAddr = ''; // 도로명 조합형 주소 변수

         // 법정동명이 있을 경우 추가한다. (법정리는 제외)
         // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
         if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
             extraRoadAddr += data.bname;
         }
         // 건물명이 있고, 공동주택일 경우 추가한다.
         if(data.buildingName !== '' && data.apartment === 'Y'){
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
         }
         // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
         if(extraRoadAddr !== ''){
             extraRoadAddr = ' (' + extraRoadAddr + ')';
         }
         // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
         if(fullRoadAddr !== ''){
             fullRoadAddr += extraRoadAddr;
         }

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         console.log(data.zonecode);
         console.log(fullRoadAddr);
         
   
      // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('region').value = data.zonecode; //5자리 새우편번호 사용
         document.getElementById('region').value = fullRoadAddr;
         
         /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
         document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
         document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
     }
  }).open();
}



function checkValid(){
  // 사용자 입력값 읽어오기
  var idEle 		= document.getElementById('id');
  var pwEle 		= document.getElementById('pw');
  var pwChkEle 		= document.getElementById('pwChk');
  var telEle 		= document.getElementById('tel');
  var nicknameEle 	= document.getElementById('nickname');
  var regionEle 	= document.getElementById('region');
  var genderEle 	= document.getElementsByName('gender');
  var birthEle 		= document.getElementById('birth');

  var flag = true; /* 회원가입 유효성 체크 유무 */

  // console.log(idEle.value,
  // pwEle.value,
  // pwChkEle.value,
  // telEle.value,
  // regionEle.options[regionEle.selectedIndex].text,
  // // genderEle.value
  // );
  // 1) 이메일 주소 체크
    if(!isEmail(idEle.value)) {
      id_errmsg.innerHTML = "이메일 정보가 잘못되었습니다.";
      flag = flag && false;
    }else{
      id_errmsg.innerHTML = "";
    }
  // 2) 비밀번호 체크
    if(!isPassword(pwEle.value)) {
      pw_errmsg.innerHTML = "비밀번호가 잘못되었습니다.(8~10)자리";
      flag = flag && false;    
    }else{
      pw_errmsg.innerHTML = "";
    }
  // 3) 비밀번호 재확인
    // 3-1)비밀번호 패턴 체크
    if(!isPassword(pwChkEle.value)) {
      pwChk_errmsg.innerHTML = "비밀번호가 잘못되었습니다.(8~10)자리";
      flag = flag && false;
    }else{
      pwChk_errmsg.innerHTML = "";
    }
    // 3-2)비밀번호 일치 체크
    if(pwEle.value != pwChkEle.value ) {
      pwChk_errmsg.innerHTML = "비밀번호가 일치하지 않습니다.";
      flag = flag && false;
    }else {
      pwChk_errmsg.innerHTML = "";
    }
  // 4) 전화번호
    if(!isTel(telEle.value)) {
      tel_errmsg.innerHTML = "전화번호가 잘못되었습니다.ex)010-1234-5678";
      flag = flag && false;
    }else{
      tel_errmsg.innerHTML = "";
    }    
  // 5) 별칭
    if(nicknameEle.value == "" ) {
    	nickname_errmsg.innerHTML = "별칭을 입력해주세요!";
        flag = flag && false;
      }else{
    	nickname_errmsg.innerHTML = "";
      }   
  // 6) 지역
    if(regionEle.selectedIndex == 0){
      region_errmsg.innerHTML = "지역을 선택해주세요!";
      flag = flag && false;
    }else{
      region_errmsg.innerHTML = "";
    }
  // 7) 성별
    var status = false;
    for(var gender of genderEle) {
      if(gender.checked) {
        status = true;
        break;
      }
    }
    if(!status) {
      gender_errmsg.innerHTML = "성별을 선택해주세요!";
      flag = flag && false;
    }else{
      gender_errmsg.innerHTML = "";
    }
    // 8) 생년월일 체크
    if(birthEle.value == "" ) {
      birth_errmsg.innerHTML = "생일을 입력해주세요!";
      flag = flag && false;
    }else{
      birth_errmsg.innerHTML = "";
    }
    return flag;
}
// 이메일 체크 정규식
function isEmail(asValue) {
  var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}

// 핸드폰 번호 체크 정규식
function isTel(asValue) {
  var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}

// 비밀번호 체크 정규식
function isPassword(asValue) {
  var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,10}$/; // 8 ~ 10자 영문, 숫자 조합
  return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}