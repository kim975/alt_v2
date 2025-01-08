<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

.intextarea {
        width: 650px;
        border-style: solid;
        border-width: 0 0 0 8px;
        padding: 12px;
        word-break: break-all;
        border-color: #009970;
        background-color: rgba(211, 211, 211, 0.2);
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
	    <li class="breadcrumb-item"><a href="/vendor/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item active" aria-current="page">내 정보 수정</li>
	  </ol>
	</nav>

<!-- ======= mypage Section ======= -->
<section id="mypage" class="contact">
    <div class="container">
    
        <div class="row">
          <div class="col-lg-4">
            <div class="section-title" data-aos="fade-right">
              <h2>내 정보 수정</h2>
              <p style="color: Gray">기본적인 정보를 변경할 수 있습니다.<br>기존 정보가 기억이 안나시면 칸을 다 지우시면 기본정보가 나옵니다. 그대로 입력해주세요.</p>
            </div>
          </div>

     	<div class="row justify-content-center">
                <form name="form" >
                    <table class="table">
					    <tr>
					        <td>아이디</td>
                            <td><input type="text" class="intext" name="vid" value='<c:out value="${vendor.vid }"/>' readonly="readonly" />
                            <b style="color: lightgray;">* 아이디는 변경이 불가능합니다.</b></td>
			       		</tr>
			      		<tr>
					        <td>비밀번호</td>
                            <td><input type="password" class="intext" name="vpassword" value='<c:out value="${vendor.vpassword }"/>'readonly="readonly">
                            <b style="color: lightgray;">* 비밀번호는 내 정보에서 수정할 수 있습니다.</b></td>
			       		</tr>
			   	  		<tr>
					        <td>업체 이름</td>
                            <td><input type="text" class="intext" name="vname"  onkeyup="vendorName()" id="inputName" value='<c:out value="${vendor.vname }"/>' placeholder="${vendor.vname }">
                            <b style="color: lightgray;">* 업체 이름 변경 시 사업자 등록 번호를 확인해 주세요.</b>
                            <div class="form-text" id="message_nick"><b> </b></div></td>
                            
			       		</tr>
			       		<tr>
					        <td>사업자 등록 번호</td>
                            <td><input type="text" class="intext" name="vregisterNo" onkeyup="vendorNoCheck()" id="inputNo" value='<c:out value="${vendor.vregisterNo }"/>' placeholder="${vendor.vregisterNo }" readonly="readonly">
                            	<div class="form-text" id="message_no"><b> </b></div></td>
			       		</tr>
			       		<tr>
					        <td>업체 전화번호</td>
                            <td><input type="text" class="intext" name="vphone" id="phoneNumber" value='<c:out value="${vendor.vphone }"/>' placeholder="${vendor.vphone }">
                            <b style="color: lightgray;">* 꼭 본인의 전화번호를 입력해주세요. (자동 '-' 추가)</b>
                            	<div class="form-text" id="message_phone"> </div></td>
			       		</tr>
			       		<tr>
					        <td>주소</td>
                            <td>
                            	<input class="intext" type="text"  id="zipNo" disabled="disabled">
	                            <input type="button" class="inbutton" style="background-color:#009970" onClick="goPopup();" value="우편검색"/><br>
	                            <input type="text" class="intext" name="vaddress" value='<c:out value="${vendor.vaddress }"/>' placeholder="${vendor.vaddress }">
								<input type="hidden"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" />
								<input type="hidden"  style="width:500px;" id="addrDetail"  name="addrDetail" />
								<input type="hidden"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" />
								<input type="hidden"  style="width:500px;" id="engAddr"  name="engAddr" />
								<input type="hidden"  style="width:500px;" id="jibunAddr"  name="jibunAddr" />
                            </td>
			       		</tr>
			       		<tr>
					        <td>업체 설명</td>
                            <td><textarea class="intextarea" rows="7" name="vinfo" placeholder="${vendor.vinfo }" ><c:out value="${vendor.vinfo }"/></textarea></td>
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
                                <input type="button" onclick="fn_sendVendor()" class="btn btn-success" style="background-color:#009970" value="수정하기">
                            	<input type="reset" class="btn btn-outline-success" value="다시입력">
								<button type="button" class="btn btn-info" onclick="location.href='/vendor/mypage'">내정보 목록</button>
                            </td>
                        </tr>
                    </table>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
                </div>
        </div><!-- End row -->
    </div><!-- End container -->
</section><!-- End section -->

<script src="https://www.google.com/recaptcha/api.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
 
var nameOverlap = "YES";
var phoneOverlap = "YES";
 
function fn_sendVendor() {

    var form = document.form;

    var vname = form.vname.value;
    var vregisterNo = form.vregisterNo.value;
    var vphone = form.vphone.value;
    var vaddress = form.vaddress.value;


     if (vname.length == 0 || vname == "") {

        alert("업체이름은 필수입니다.");
        document.form.vname.focus();
        return false;

    } else if (vregisterNo.length == 0 || vregisterNo == "") {

        alert("사업자 등록 번호는 필수입니다.");
        document.form.vregisterNo.focus();
        return false;

    } else if (vphone.length == 0 || vphone == "") {

        alert("업체 전화번호 필수입니다.");
        document.form.vphone.focus();
        return false;

    } else if (vaddress.length == 0 || vaddress == "") {

        alert("업체 주소는 필수 입니다.");
        document.form.vaddress.focus();
        return false;

    }  else if (nameOverlap != "YES") {

    	nameOverlap = "YES"
        alert("업체 이름이 중복 됩니다. 다른 닉네임을 사용해주세요.");
        document.form.vname.focus();
        return false;

    } else if (phoneOverlap != "YES") {

        phoneOverlap = "YES"
        alert("전화번호가 중복 됩니다. 전화번호를 사용해주세요.");
        document.form.cphone.focus();
        return false;

    } /* else if ( vregisterNo.length > 10  || vregisterNo.length < 10) {
    	
        alert("사업자 등록 번호가 중복 됩니다. 다시 입력해주세요.");
        return false;
        
    }  */else if (grecaptcha.getResponse().length == 0) {
    		alert('reCAPTCHA를 이용해서 사람임을 증명해주세요.');
    		return false;
    		if(grecaptcha.getResponse().length != 0) {
    			
    			return true;
    		}
    		
    } else {

    	alert("정보 수정이 완료 되었습니다. 수정 내용은 다시 로그인 시 업데이트 됩니다.");
        form.method = "post";
        form.action = "/vendor/modify";
        form.submit();

    }
    
};

//업체 이름 중복검사
function vendorName() {

    var _vname = $("#inputName").val();

    $.ajax({
        type: "get",
        async: true,
        url: "/vendorName",
        dataType: "text",
        data: {
            vname: _vname
        },
        success: function(data) {

            if (data == 'not_usable') {
            	
            	nameOverlap = "NO";
            	
                $('#message_nick').text("이미 존재하는 업체이름입니다.");
                $('#message_nick').css("color", "red");
                
            } else {
            	
            	nameOverlap = "YES";
            	
                $('#message_nick').text("사용 가능한 업체이름입니다.");
                $('#message_nick').css("color", "blue");

            }
        },
        error: function(request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}


//업체 사업자 등록 번호 중복 체크
/* function vendorNoCheck() {

    var _vregisterNo = $("#inputNo").val();
    var vregisterNo = form.vregisterNo.value;

    $.ajax({
        type: "get",
        async: true,
        url: "/vendorNoCheck",
        dataType: "text",
        data: {
            vregisterNo: _vregisterNo
        },
        success: function(data) {

            if (data == 'not_usable' || vregisterNo.length < 10 || vregisterNo.length > 10) {
               
                $('#message_no').text("사용할 수 없는 사업자 등록 번호입니다.");
                $('#message_no').css("color", "red");
                
            } else if(vregisterNo.length == 10) {
               
                $('#message_no').text("사용 가능한 사업자 등록 번호입니다.");
                $('#message_no').css("color", "blue");

            }
        },
        error: function(request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
} */
 

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


//전화번호 유효성 검사
function phoneCheck() {

var _vphone = $("#phoneNumber").val();
var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;


$.ajax({
    type: "get",
    async: true,
    url: "/phoneCheck_vendor",
    dataType: "text",
    data: {
    	vphone: _vphone
    },
    success: function(data) {

        if (data == 'not_usable' || !regExpPhone.test($("input[name=vphone]").val())) {

            $('#message_phone').text("사용할 수 없는 번호 입니다.");
            $('#message_phone').css("color", "red");

        } else {

        	
            $('#message_phone').text("사용할 수 있는 번호입니다.");
            $('#message_phone').css("color", "blue");

        }
    },
    error: function(request, status, error) {
        alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    }
});
}
 
//전화번호 하이븐 자동 입력
$(document).on("keyup", "#phoneNumber", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "")
		   .replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3")
		   .replace("--", "-") ); 
	phoneCheck();
});

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
<%@include file="/WEB-INF/views/include/footer.jsp" %>