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
	    <li class="breadcrumb-item active" aria-current="page">탈퇴</li>
	  </ol>
	</nav>

<!-- ======= Hero Section ======= -->
    <section id="services" class="">
      <div class="container">

        <div class="row">
          <div class="col-lg-4">
            <div class="section-title" data-aos="fade-right">
              <h2>ALT 탈퇴</h2>
              <p style="color: Gray">ALT를 탈퇴하기 위해서는 현재 비밀번호를 입력해주세요.</p>
            </div>
          </div>

     <div class="container">
     	<div class="row justify-content-center">
                <form name="frmdelete">
                    <table class="table table-boardered">
                        <tr>
                            <th style="color: gray;">아이디</th>
                            <td><input type="text" class="intext" id="inputId" name="cid" value="${memberVO.cid}" readonly="readonly" /></td>
                        </tr>

                        <tr>
                            <th style="color: gray;">패스워드</th>
                            <td><input type="password" class="intext" name="cpassword" placeholder="변경할 비밀번호를 입력해주세요"></td>
                        </tr>

                        <!-- <tr>
                            <th style="color: gray;">패스워드확인</th>
                            <td><input type="password" class="form-control" name="repassword" placeholder="비밀번호를 한번 더 입력해주세요"></td>
                        </tr> -->
                        
                        <tr>
                            <td colspan="2" style="color: gray;">
                                <input type="reset" class="inbutton" style="background-color:#009970" value="다시입력">
                                <input type="button" class="inbutton" style="background-color:#DC3545" onclick="check()"  value="탈퇴하기">     
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
            </div>
		</div>
    </div>
  </section><!-- End Hero -->

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

function check() {

	var cpassword = '<c:out value="${memberVO.cpassword}"/>';

	console.log(cpassword);
	
    //비밀번호 일치 유효성

    if(document.frmdelete.cpassword.value != cpassword){
    	
    	alert("비밀번호가 틀립니다. 정확히 입력해주세요");
        document.addjoin.cpassword.focus();
        exit;
    	
    }
    
    alert("ALT사이트를 탈퇴하셨습니다.");
    frmdelete.method = "post";
    frmdelete.action = "/client/delete";
    frmdelete.submit();
	
}

</script>


<%@include file="/WEB-INF/views/include/footer.jsp" %>