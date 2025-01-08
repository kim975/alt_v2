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

</style>

<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/vendor/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item active" aria-current="page">비밀번호 변경</li>
	  </ol>
	</nav>

<!-- ======= Hero Section ======= -->
    <section id="services" class="">
      <div class="container">

        <div class="row">
          <div class="col-lg-4">
            <div class="section-title" data-aos="fade-right">
              <h2>비밀번호 수정</h2>
              <p></p>
            </div>
          </div>
          </div>

        <div class="container">
            <div class="row justify-content-center">
                <form name="frmSignup">
                    <table class="table table-boardered">
                        <tr>
                            <th>현재 비밀번호</th>
                            <td>
                            	<input type="hidden" class="intext" id="inputId" name="vid" value="${vendor.vid }"/>
                            	<input type="text" class="intext" name="nowvpassword">
                            
                            </td>
                        </tr>

                        <tr>
                            <th>변경 할 비밀번호</th>
                            <td><input type="text" class="intext" name="vpassword"></td>
                        </tr>
                        
                         <tr>
                            <th>변경 할 비밀번호 확인</th>
                            <td><input type="text" class="intext" name="revpassword"></td>
                        </tr>

						<tr>
                            <td colspan="2">
                                <input type="button" class="inbutton" style="background-color:#009970" value="수정하기" onclick="check()">
                                <input type="reset" class="inbutton" style="background-color:#17A2B8" value="다시입력">
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

	var vpassword = '<c:out value="${vendor.vpassword}"/>';

	
    //비밀번호 일치 유효성
    if (document.frmSignup.vpassword.value != document.frmSignup.revpassword.value) {

        alert("입력한 2개의 비밀번호가 일치하지 않습니다.");
        document.addjoin.vpassword.focus();
        exit;

    }
    
    if(document.frmSignup.nowvpassword.value != vpassword){
    	
    	alert("현재 비밀번호가 틀렸습니다.");
        document.addjoin.nowvpassword.focus();
        exit;
    	
    }
    
    alert("비밀번호를 변경했습니다. 다시 로그인 해주세요.");
    frmSignup.method = "post";
    frmSignup.action = "/vendor/modifyPassword";
    frmSignup.submit();
	
}

</script>

<!--  <main id="main">
  </main>End #main -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>