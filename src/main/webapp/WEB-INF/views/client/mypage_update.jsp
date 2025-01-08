<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>

.intext{
	width:300px; 
	border-style: solid;
	border-width: 0 0 0 8px; 
	padding: 12px; 
	word-break: break-all;
	border-color: #009970;
	background-color:rgba(211, 211, 211, 0.2);
}

.inbutton {
    width:100px;
    background-color: #00CC00;
    border: none;
    color:#fff;
    padding: 15px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    text-align: center;
    cursor: pointer;
    border-radius:10px 0 10px 0;
}

.in-line{
      width:350px;
      height:40px;
    }
    
    input{
      margin:0;
    }
    
    .ontext{
      width:70%;
      height:100%;
      border:none;
      font-size:1em;
      padding-left: 5px;
      font-style: oblique;
      display:inline;
      outline:none;
      box-sizing: border-box;
      color:black;

    }
    
    .onbutton{
      width: 30%;
      height:100%;
      background-color: lightgray;
      border:none;
      background-color: white;
      font-size:1em;
      color:#042AaC;
      outline:none;
      display:inline;
      margin-left: -10px;
      box-sizing: border-box;
    }
    
    .onbutton:hover{
      background-color: lightgray;
    }

</style>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/client/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item"><a href="/client/mypage_info?cid=${memberVO.cid}">내 정보</a></li>
	    <li class="breadcrumb-item active" aria-current="page">내 정보 수정</li>
	  </ol>
	</nav>

<!-- ======= Hero Section ======= -->
    <section id="services" class="">
      <div class="container">

        <div class="row">
          <div class="col-lg-4">
            <div class="section-title" data-aos="fade-right">
              <h2>내 정보 수정</h2>
              <p style="color: Gray">기본적인 정보를 변경할 수 있습니다.<br>기존 정보가 기억이 안나시면 칸을 다 지우시면 기본정보가 나옵니다. 그대로 입력해주세요.</p>
            </div>
          </div>

        <div class="container">
            <div class="row justify-content-center">
                <form name="form" id="form">
                    <table class="table table-boardered">
                        <tr>
                            <th>아이디</th>
                            <td><input class="intext" type="text" id="inputId" name="cid" value="${client.cid }" readonly="readonly" />
                            	<b style="color: lightgray;">* 아이디는 변경이 불가능합니다.</b>
                            </td>
                        </tr>

                        <tr>
                            <th>비밀번호</th>
                            <td><input class="intext" type="password" name="cpassword" value="${client.cpassword }" readonly="readonly">
								<b style="color: lightgray;">* 비밀번호는 내 정보에서 수정할 수 있습니다.</b>
                            </td>
                            	
                        </tr>

                        <tr>
                            <th>이름</th>
                            <td><input class="intext" type="text" name="cname" value="${client.cname }" placeholder="${client.cname }"></td>
                        </tr>

                        <tr>
                            <th>닉네임</th>
                            <td><input class="intext"  type="text" name="cnick" value="${client.cnick }" id="inputNick" class="form-control" onkeyup ="nickCheck()" placeholder="${client.cnick }">
                            	 <b style="color: lightgray;">* 10자 이내(한글/영어 포함)</b>
		   	    				<div style="color: red;" class="form-text" id="message_nick"><b> </b></div>
                            </td>
                        </tr>

                        <tr>
                            <th>전화번호</th>
                            <td>
                            	<input class="intext" type="tel" name="cphone" value="${client.cphone }" id="phoneNumber" placeholder="${client.cphone }">
                            	<b style="color: lightgray;">* 꼭 본인의 전화번호를 입력해주세요. (자동 '-' 추가)</b>
                            	<div class="form-text" id="message_phone"> </div>
                            </td>
                           
                        </tr>

                        <tr>
                            <th>주소</th>
                            <td>
	                            <input class="intext" type="text"  id="zipNo" disabled="disabled">
	                            <input type="button" class="inbutton" style="background-color:#009970" onClick="goPopup();" value="우편검색"/><br>
	                            <input class="intext" style="width:410px;" type="text"  id="roadFullAddr" name="caddress" value="${client.caddress }" placeholder="${client.caddress }">
								<input type="hidden"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" />
								<input type="hidden"  style="width:500px;" id="addrDetail"  name="addrDetail" />
								<input type="hidden"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" />
								<input type="hidden"  style="width:500px;" id="engAddr"  name="engAddr" />
								<input type="hidden"  style="width:500px;" id="jibunAddr"  name="jibunAddr" />
							</td>
                        </tr>

						<tr>
                            <th>reCAPTCHA 인증</th>
                            <td><div class="g-recaptcha" data-sitekey="6LdmFnkaAAAAAHJ3J3us2vWVPq6jO-Pze8PumMCH"></div>
                            	<b style="color: lightgray;">* ☑ 체크하여 로봇이 아님을 증명해주세요.</b>
                            	<div class="form-text" id="message_phone"> </div>	
                            </td>
                        </tr>
						
                        <tr>
                            <td colspan="2" style="color: gray;">	
                                <input type="button" onclick="fn_sendClient()" class="btn btn-success" style="background-color:#009970" value="수정하기">
                                <input type="reset" class="btn btn-outline-success" value="다시입력">
                                <a href="/client/mypage_info?cid=${memberVO.cid}"><input type="button" class="btn btn-success" style="background-color:#17A2B8" value="뒤로가기"></a>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
            </div>
        </div>
    </div>
    
</section><!-- End Hero -->


<script src="https://www.google.com/recaptcha/api.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	//Ajax중복 내용 검사하여 다시 한번 더 Form에 표시 하기 위한 변수 설정
    var nickOverlap = "YES";
    var phoneOverlap = "YES";

	//기본적인 form의 유효성 검사
    function fn_sendClient() {

        var form = document.form;

        var cnick = form.cnick.value;
        var cname = form.cname.value;
        var cphone = form.cphone.value;

        //아이디 유효성
        //영문자로 시작하고, 6~20자 영문자 또는 숫자 이상 입력
        var regExpId = /^[a-z]+[a-z0-9]{5,19}$/g;
        
        //비밀번호 유호성
        //6~20 영문 대소문자, 최소 1개의 숫자 혹은 특수 문자  입력
        var regExpPw = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/;
        
        
        if (cname.length == 0 || cname == "") {

            alert("이름은 필수입니다.");
            document.form.cname.focus();
            return false;

        } else if (cnick.length == 0 || cnick == "" ) {

            alert("닉네임은 필수입니다.");
            document.form.cnick.focus();
            return false;

        } else if (cphone.length == 0 || cphone == "") {

            alert("전화번호 필수입니다.");
            document.form.cphone.focus();
            return false;

        } else if (nickOverlap != "YES") {

            nickOverlap = "YES"
            alert("닉네임이 중복 됩니다. 다른 닉네임을 사용해주세요.");
            document.form.cnick.focus();
            return false;

        } else if (phoneOverlap != "YES") {

            phoneOverlap = "YES"
            alert("전화번호가 중복 됩니다. 전화번호를 사용해주세요.");
            document.form.cphone.focus();
            return false;

        } else if ( cnick.length > 10  ) {
        	
            alert("닉네임은 10글자 이내로 작성해주세요.");
            return false;
            
        } else if (grecaptcha.getResponse().length == 0) {
        		alert('reCAPTCHA를 이용해서 사람임을 증명해주세요.');
        		return false;
        		if(grecaptcha.getResponse().length != 0) {
        			
        			return true;
        		}
        		
        } else {

        	alert("정보 수정이 완료 되었습니다. 수정 내용은 다시 로그인 시 업데이트 됩니다.");
            form.method = "post";
            form.action = "/client/modify";
            form.submit();

        }
        
    };




//전화번호 하이븐 자동 입력
$(document).on("keyup", "#phoneNumber", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "")
		   .replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3")
		   .replace("--", "-") ); 
	phoneCheck();
});



//닉네임 중복검사
 //회원 정보에서 같은 닉네임 유효성 검사
    function nickCheck() {

        var _nick = $("#inputNick").val();
        var cnick = form.cnick.value;
        
        $.ajax({
            type: "get",
            async: true,
            url: "/nickCheck",
            dataType: "text",
            data: {
                nick: _nick
            },
            success: function(data) {

                if (data == 'not_usable' || cnick.length > 10) {

                    nickOverlap = "NO";
                    $('#message_nick').text("사용할 수 없는 닉네임입니다.");
                    $('#message_nick').css("color", "red");

                } else {

                    nickOverlap = "YES";
                    $('#message_nick').text("사용할 수 있는닉네임입니다.");
                    $('#message_nick').css("color", "blue");

                }
            },
            error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    }
    
    
  	//전화번호 유효성 검사
    function phoneCheck() {

    var _cphone = $("#phoneNumber").val();
    var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;

    
    $.ajax({
        type: "get",
        async: true,
        url: "/phoneCheck_client",
        dataType: "text",
        data: {
            cphone: _cphone
        },
        success: function(data) {

            if (data == 'not_usable' || !regExpPhone.test($("input[name=cphone]").val())) {

                nickOverlap = "NO";
                $('#message_phone').text("사용할 수 없는 번호 입니다.");
                $('#message_phone').css("color", "red");

            } else {

                nickOverlap = "YES";
                $('#message_phone').text("사용할 수 있는 번호입니다.");
                $('#message_phone').css("color", "blue");

            }
        },
        error: function(request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}
  	
    //시큐리티 접근을 제한을 풀기 위해 csrf 변수 지정
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";

    //reCAPTCHA(로봇이 아닙니다 Ajax)
    $(document).ready(function() {
        $("#submit_Btn").click(function() {
            $.ajax({
                url: '/VerifyRecaptcha',
                type: 'post',

                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                dataType: "json",
                data: {
                    recaptcha: $("#g-recaptcha-response").val()

                },
                success: function(data) {
                    switch (data) {
                        case 0:
                            alert("자동 가입 방지 봇 통과");
                            break;

                        case 1:
                            //alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
                            break;

                        default:
                            alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
                            console.log(Number(data));
                            console.log(data);
                            break;
                    }
                }

            });
        });
    });
  	
  	
//주소 API
//opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
 /* zdocument.domain = "abc.go.kr"; */

 function goPopup(){
 	// 주소검색을 수행할 팝업 페이지를 호출합니다.
 	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
 	var pop = window.open("/juso/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
 	
 	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
     //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
 }


 function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
 		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.roadFullAddr.value = roadFullAddr;
		document.form.roadAddrPart1.value = roadAddrPart1;
		document.form.roadAddrPart2.value = roadAddrPart2;
		document.form.addrDetail.value = addrDetail;
		document.form.engAddr.value = engAddr;
		document.form.jibunAddr.value = jibunAddr;
		document.form.zipNo.value = zipNo;

 }
 
</script>

<!--  <main id="main">
  </main>End #main -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>