<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
    .intext {
        width: 400px;
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

</style>

<!-- ======= Hero Section ======= -->
<section id="services" class="">
    <div class="container">

        <div class="row">
            <div class="col-lg-12">
                <div class="section-title center" data-aos="fade-right">
                    <h2 style= "text-align:center;">발주서</h2>
                </div>
            </div>

            <div class="container">
                <div class="row justify-content-center">
                    <form name="frmRegister" id="frmRegister">
                        <table class="table table-boardered">
                            <tr>
                                <th style= "border-top-color:#009970; border-top-width: thick;">받을 아이디</th>
                                <td style= "border-top-color:#009970; border-top-width: thick;">
                                   <sec:authorize access="hasRole('ROLE_VENDOR')">
                              <input class="intext" type="text" name="cid" value="${cid }" readonly="readonly">
                           </sec:authorize>
                           <sec:authorize access="hasRole('ROLE_CLIENT')">
                              <input class="intext" type="text" name="cid" value="${memberVO.cid }" readonly="readonly">
                           </sec:authorize>
                                   
                                    
                                </td>
                            </tr>
                     
                     <tr>
                                <th>판매 물품의 게시판 번호를 작성해주세요</th>
                                <td><input id="sno" class="intext" type="text" name="sno" value="${confer.SNO }">
                                    
                                </td>
                            </tr>
                     
                            <tr>
                                <th>가격</th>
                                <td><input min="0" id="oprice" class="intext" type="text" name="oprice" value="${confer.OPRICE }" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                    
                                </td>
                            </tr>
                            
                            <tr>
                                <th>거래 수량</th>
                                <td><input min="0" id="oamount" class="intext" type="text" name="oamount" value="${confer.OAMOUNT }" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                </td>

                            </tr>

                            <tr>
                                <th>주소</th>
                                <td>
                                	
                                   <input class="intext oaddress" style="width:520px;" type="text" id="roadFullAddr" name="oaddress" placeholder="구매자가 작성">
                               <input type="button" class="btn btn-success" onClick="goPopup();" value="우편검색" />
                               <p><b style="color: lightgray;">* 주소는 협의서를 보낸뒤에 구매자가 작성합니다.</b></p>
                                </td>
                            </tr>

                            <tr>
                            	
                                <th>핸드폰번호</th>
                                <td><input id="ophone" class="intext" type="text" name="ophone" placeholder="구매자가 작성">
                                <p><b style="color: lightgray;">* 핸드폰 번호는 협의서를 보낸뒤에 구매자가 작성합니다.</b></p></td>
                            </tr>

                             
                            <tr>
                                <td colspan="2" style="color: gray; margin: 0 auto;">
                                   <div class="text-center" style="margin: 0 auto;">
                                      <sec:authorize access="hasRole('ROLE_VENDOR')">
                                 <input class="btn btn-success" id="btnSubmit" type="button" value="제안서보내기">
                              </sec:authorize>
                              <sec:authorize access="hasRole('ROLE_CLIENT')">
                                 <input class="btn btn-success" style="background-color:#009970;" id="btnsend" type="button" value="전송하기">
                              </sec:authorize>
                                       &nbsp;&nbsp;&nbsp;&nbsp;
                                         <input type="reset" class="btn btn-outline-success" style="color:#009970" value="다시입력">
                                       <input type="hidden" name="command" value="addMember" />
                           </div>
                                </td>
                            </tr>

                        </table>
                        <input type="hidden" name="ocode" value="${confer.OCODE }"/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </form>


                </div>
            </div>
        </div>
</div>
</section><!-- End Hero -->
<sec:authentication property="principal" var="principal"/>

<script type="text/javascript">

	var frmRegister = document.frmRegister;
	
	console.log(frmRegister);
	$("#btnSubmit").on("click", function(e){
	   
	   e.preventDefault();
	   
	   frmRegister.method = "post";
	   frmRegister.action = "/board/conferDocSend";
	   frmRegister.submit();
	});
	
	$("#btnsend").on("click", function(e){
	   
	   console.log(frmRegister);
	   
	   e.preventDefault();
	   frmRegister.method = "post";
	   frmRegister.action = "/board/conferCheck";
	   frmRegister.submit();
	});
	
	
	console.log('${principal.authorities}' );
	
	$(document).ready(function() {
	    
	   if (${principal.authorities == '[ROLE_VENDOR]'}) {
	      
	      $(".oaddress").attr("readonly",true);
	      $("#ophone").attr("readonly",true);
	      
	   } else {
	      
	      $("#sno").attr("readonly",true);
	      $("#oprice").attr("readonly",true);
	      $("#oamount").attr("readonly",true);
	   }
	   
	});

   function goPopup() {
   
      if (${principal.authorities == '[ROLE_VENDOR]'}) {
         return;
      }
        // 주소검색을 수행할 팝업 페이지를 호출합니다.
        // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        var pop = window.open("/juso/jusoPopup", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");

        // 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
    }


    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo) {
        // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
        $("#roadFullAddr").val(roadFullAddr);

    }
    
</script> 


<%@include file="/WEB-INF/views/include/footer.jsp" %>