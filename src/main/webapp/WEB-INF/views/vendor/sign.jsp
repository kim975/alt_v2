<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
    .intext {
        width: 300px;
        border-style: solid;
        border-width: 0 0 0 8px;
        padding: 12px;
        word-break: break-all;
        border-color: #009970;
        background-color: rgba(211, 211, 211, 0.2);
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
        width: 100px;
        background-color: #00CC00;
        border: none;
        color: #fff;
        padding: 15px 0;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 15px;
        margin: 4px;
        text-align: center;
        cursor: pointer;
        border-radius: 10px 0 10px 0;
    }

    .in-line {
        width: 350px;
        height: 40px;
    }

    input {
        margin: 0;
    }

    .ontext {
        width: 70%;
        height: 100%;
        border: none;
        font-size: 1em;
        padding-left: 5px;
        font-style: oblique;
        display: inline;
        outline: none;
        box-sizing: border-box;
        color: black;

    }

    .onbutton {
        width: 30%;
        height: 100%;
        background-color: lightgray;
        border: none;
        background-color: white;
        font-size: 1em;
        color: #042AaC;
        outline: none;
        display: inline;
        margin-left: -10px;
        box-sizing: border-box;
    }

    .onbutton:hover {
        background-color: lightgray;
    }
</style>

<!-- ======= Hero Section ======= -->
<section id="services" class="">
    <div class="container">

         <div class="row">
            <div class="col-lg-4">
                <div class="section-title" data-aos="fade-right">
                    <h2>A.L.T 업체 가입</h2>
                    <p style="color: Gray">회원 가입을 소중한 정보를 입력해주세요.<br>저희 A.L.T는 당신의 정보를 소중히 하겠습니다.</p>
                </div>
            </div>

            <div class="container">
                <div class="row justify-content-center">
                    <form name="form" id="form">
                        <table class="table table-boardered">
                            <tr>
                                <th>아이디</th>
                                <td>
                                    <input class="intext" type="text" name="vid" id="inputvendorId" onkeyup="vendoridCheck()" placeholder="아이디를 입력해주세요." />
                                    <b style="color: lightgray;">* 영문자 시작하고, 6~20자 영문자 또는 숫자 이상</b>
                                    <div class="form-text" id="message_id"> </div>
                                </td>
                            </tr>

                            <tr>
                                <th>비밀번호</th>
                                <td>
                                    <input class="intext" type="password" name="vpassword" id="inputPassword" required placeholder="비밀번호를 입력해주세요.">
                                    <b style="color: lightgray;">* 6~20 영문 대소문자, 최소 1개의 숫자 혹은 특수 문자</b>
                                </td>

                            </tr>

                            <tr>
                                <th>비밀번호 재확인</th>
                                <td><input type="password" name="vpasswordcheck" id="inputPasswordcheck" required class="intext" placeholder="비밀번호를 한번 더 입력해주세요.">
                                    <div id="pwMessage"></div>
                                    <div id="successPw" style="color: blue;">비밀번호가 일치합니다.</div>
                                    <div id="failPw" style="color: red;">비밀번호가 일치하지않습니다.</div>
                                </td>
                            </tr>

                            <tr>
                                <th>업체 이름</th>
                                <td><input class="intext" type="text" name="vname" id="inputName" onkeyup="vendorName()" placeholder="업체이름을 입력해주세요.">
                                    <div class="form-text" id="message_nick"><b> </b></div>
                                </td>
                            </tr>

                            <tr>
                                <th>사업자 등록 번호</th>
                                <td><input class="intext" type="text" name="vregisterNo" id="inputNo" onkeyup="vendorNoCheck()" placeholder="사업자 등록 번호를 입력해주세요.">
                                    <b style="color: lightgray;">* 사업자 등록 번호가 없을 경우 업체 가입이 불가능합니다.</b>
                                    <div class="form-text" id="message_no"><b> </b></div>
                                </td>
                            </tr>

                            <tr>
                                <th>업체 전화번호</th>
                                <td><input class="intext" type="tel" name="vphone" id="phoneNumber" placeholder="업체 전화번호를 입력해주세요.">
                                    <b style="color: lightgray;">* 꼭 본인의 전화번호를 입력해주세요. (자동 '-' 추가)</b>
                                    <div class="form-text" id="message_phone"> </div>
                                </td>
                            </tr>

                            <tr>
                                <th>업체 주소</th>
                                <td>
                                    <input class="intext" type="text" id="zipNo" disabled="disabled">
                                    <input type="button" class="btn btn-success" onClick="goPopup();" value="우편검색" /><br><br>
                                    <input class="intext" style="width:410px;" type="text" id="roadFullAddr" name="vaddress" placeholder="우편검색으로 주소를 입력해주세요.">
                                    <input type="hidden" style="width:500px;" id="roadAddrPart1" name="roadAddrPart1" />
                                    <input type="hidden" style="width:500px;" id="addrDetail" name="addrDetail" />
                                    <input type="hidden" style="width:500px;" id="roadAddrPart2" name="roadAddrPart2" />
                                    <input type="hidden" style="width:500px;" id="engAddr" name="engAddr" />
                                    <input type="hidden" style="width:500px;" id="jibunAddr" name="jibunAddr" />
                                </td>
                            </tr>

                            <tr>
                                <th>업체 정보</th>
                                <td>
                                <textarea class="intextarea" rows="7" name="vinfo" placeholder="업체에 대한 정보를 간다히 입력해주세요.&#13;&#10;&#13;&#10;ex)&#13;&#10;저희 OOO업체는 주로 야채쪽을 재배하는 업체입니다.&#13;&#10;야채 하면 저희 OOO업체 입니다!"></textarea></td>
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
                                <div class="text-center" style="margin: 0 auto;">
                                    <input type="button" class="btn btn-success" style="background-color:#009970" value="가입하기" onclick="fn_sendVendor()">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="reset" class="btn btn-info" value="다시입력">
                                    <input type="hidden" name="command" value="addMember" />
                                </div>
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

	//기본 유효성 검사 체크
    /* function fn_sendClient() {
    	
    	if (grecaptcha.getResponse().length == 0) {
    		alert('reCAPTCHA를 이용해서 사람임을 증명해주세요.');
    		return false;
    		if(grecaptcha.getResponse().length != 0) {
    			
    			return true;
    		}
    		
    	} 
    	
    	alert("A.L.T에 오신걸 환영합니다. 업체 가입 되었습니다.");
        form.method = "post";
        form.action = "/vedor_join";
        form.submit();
       
    } */
    
  //Ajax중복 내용 검사하여 다시 한번 더 Form에 표시 하기 위한 변수 설정
    var idOverlap = "YES";
    var nameOverlap = "YES";
    var phoneOverlap = "YES";

	//기본적인 form의 유효성 검사
    function fn_sendVendor() {

        var form = document.form;

        var vid = form.vid.value;
        var vpassword = form.vpassword.value;
        var vpasswordcheck = form.vpasswordcheck.value;
        var vname = form.vname.value;
        var vregisterNo = form.vregisterNo.value;
        var vphone = form.vphone.value;
        var vaddress = form.vaddress.value;

        //아이디 유효성
        //영문자로 시작하고, 6~20자 영문자 또는 숫자 이상 입력
        var regExpId = /^[a-z]+[a-z0-9]{5,19}$/g;
        
        //비밀번호 유호성
        //6~20 영문 대소문자, 최소 1개의 숫자 혹은 특수 문자  입력
        var regExpPw = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/;
        
        
        if (vid.length == 0 || vid == "") {

            alert("아이디는 필수입니다.");
            document.form.vid.focus();
            return false;

        } else if (vpassword.length == 0 || vpassword == "") {

            alert("암호는 필수입니다.");
            document.form.vpassword.focus();
            return false;

        } else if (vname.length == 0 || vname == "") {

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

        } else if (idOverlap != "YES") {

            idOverlap = "YES"
            alert("아이디가 중복 됩니다. 다른 아이디를 사용해주세요.");
            document.form.cid.focus();
            return false;

        } else if (nameOverlap != "YES") {

        	nameOverlap = "YES"
            alert("업체 이름이 중복 됩니다. 다른 닉네임을 사용해주세요.");
            document.form.vname.focus();
            return false;

        } else if (phoneOverlap != "YES") {

            phoneOverlap = "YES"
            alert("전화번호가 중복 됩니다. 전화번호를 사용해주세요.");
            document.form.cphone.focus();
            return false;

        } else if ( !regExpId.test($("input[name=vid]").val() ) ) {
        	
            alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
            return false;
            
        } else if ( !regExpPw.test($("input[name=vpassword]").val() ) ) {
        	
            alert("비밀번호는 6~20자 영문 대소문자, 최소 1개의 숫자 혹은 특수 문자를 포함해주세요");
            return false;
            
        } else if ( vregisterNo.length > 10  || vregisterNo.length < 10) {
        	
            alert("사업자 등록 번호가 중복 됩니다. 다시 입력해주세요.");
            return false;
            
        } else if (grecaptcha.getResponse().length == 0) {
        		alert('reCAPTCHA를 이용해서 사람임을 증명해주세요.');
        		return false;
        		if(grecaptcha.getResponse().length != 0) {
        			
        			return true;
        		}
        		
        } else {

        	alert("A.L.T에 오신걸 환영합니다. 업체 가입 되었습니다.");
            form.method = "post";
            form.action = "/vendor_join";
            form.submit();

        }
        
    };
    
    //업체 아이디 중복 체크
    $("#vid").change(function() {

        var _id = $("#inputvendorId").val();

        if ($('#vid').val() == "" || $('#vid').val().length == 0) {

        } else {
            vendoridCheck();
        }
    });

    function vendoridCheck() {
        var _vid = $("#inputvendorId").val();
        var regExpId = /^[a-z]+[a-z0-9]{5,19}$/g;

        $.ajax({
            type: "get",
            async: true,
            url: "/vendoridCheck",
            dataType: "text",
            data: {
                vid: _vid
            },
            success: function(data, textStatus) {

                if (data == 'not_usable' || !regExpId.test($("input[name=vid]").val())) {

                	idOverlap = "NO";
                	
                    $('#message_id').text("사용할 수 없는 ID입니다.");
                    $('#message_id').css("color", "red");

                } else {
                	
                	idOverlap = "YES";
                	
                    $('#message_id').text("사용할 수 있는 ID입니다.");
                    $('#message_id').css("color", "blue");
                    // 	$('#inputId').prop("readonly", true) ;
                    
                }
            },
            error: function(request, status, error) {

                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

            }
        });
    }

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
    function vendorNoCheck() {

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
    }


    //비밀번호 체크 유효성 검사
    $(function() {

        $("#successPw").hide();
        $("#failPw").hide();
        $("input").keyup(function() {

            var pw1 = $("#inputPassword").val();
            var pw2 = $("#inputPasswordcheck").val();

            if (pw1 != "" || pw2 != "") {
                if (pw1 == pw2) {
                    $("#successPw").show();
                    $("#failPw").hide();
                    $("#submit").removeAttr("disabled");
                } else {
                    $("#successPw").hide();
                    $("#failPw").show();
                    $("#submit").attr("disabled", "disabled");

                }
            }
        });
    });

    //전화번호 하이븐 자동 입력
    $(document).on("keyup", "#phoneNumber", function() {
        $(this).val($(this).val().replace(/[^0-9]/g, "")
            .replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3")
            .replace("--", "-"));
        phoneCheck();
    });


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

    //주소 API
    //opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
    /* zdocument.domain = "abc.go.kr"; */

    function goPopup() {
        // 주소검색을 수행할 팝업 페이지를 호출합니다.
        // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        var pop = window.open("/juso/jusoPopup", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");

        // 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
    }


    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo) {
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