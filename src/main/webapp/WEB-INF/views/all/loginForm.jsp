<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>농축산 거래의 시작 ! A.L.T</title>
	<link href="/resources/assets/img/altfavicon.ico" rel="icon">
	<link rel="stylesheet" type="text/css" href="/resources/sorc/css/style.css">
	<link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/a81368914c.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<img class="wave" src="/resources/sorc/img/wave.png">
	<div class="container">
		<div class="img">
			<img src="/resources/sorc/img/bg.svg">
		</div>
		<div class="login-content">
			<form id="frmSignup" name="frmSignup" action="/all/login" method="post">
				<img src="/resources/sorc/img/avatar.svg">
				<h2 class="title" >ALT 통합 로그인</h2>
				<p class="input" style="color: gray;"><c:out  value="${error}"/></p>
  				<p class="input" style="color: gray;"><c:out value="${logout}"/><p>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<input type="text" class="username input" name="username" placeholder="Username"/>
           		   </div>
           		</div>
           		<div class="input-div pass">
           		   <div class="i"> 
           		    	<i class="fas fa-lock"></i>
           		   </div>
           		   <div class="div">
           		    	<input type="password" class="input" name="password" placeholder="Password" />
            	   </div>
            	</div>
            	
            	<input type="radio" name="user" id="radioo" value="client"> 회원
            	<input type="radio" name="user" id="radioo" value="vnedor"> 업체
            	
            	<c:if test="${msg=='logout' }">
                	<div style="color: red">로그아웃 되었습니다.</div>
               	</c:if>
            	<input type="button" class="btn loginCon" value="Login">
            	<!-- <a href="/sign_check_client"><input type="button" class="btn" value="아직 가입을 안하셨나요?"></a> -->
            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
        </div>
    </div>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	var frmSignup = $("#frmSignup");
	
	$(".loginCon").on("click", function(e) {
		
		var cli = $("input[name='user']:checked").val();
		
		var username ="";
		
		if (cli == "client") {
			
			username = 'c' + $(".username").val();	
		} else {
			username = 'v' + $(".username").val();
		}
		
		$(".username").val(username);
		
		alert(username);
		
		frmSignup.submit();
	})
	

</script>

</html>