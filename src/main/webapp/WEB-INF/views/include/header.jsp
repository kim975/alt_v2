<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- 시큐리티 csrf 파일 전송  -->
    <meta name="_csrf_parameter" content="${_csrf.parameterName}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta name="_csrf" content="${_csrf.token}" />

    <title>농축산 거래의 시작 ! A.L.T</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/resources/assets/img/altfavicon.ico" rel="icon">
    <link href="/resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
    <link href="/resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/resources/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/resources/assets/vendor/venobox/venobox.css" rel="stylesheet">
    <link href="/resources/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">

    <!-- Template Main CSS File -->
    <link href="/resources/assets/css/style.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    


    <!-- =======================================================
  * Template Name: Bethany - v2.2.1
  * Template URL: https://bootstrapmade.com/bethany-free-onepage-bootstrap-theme/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->

</head>

<body>
	
    <!-- ======= Header ======= -->
    <header id="header" class=" d-flex align-items-center">
        <div class="container">
            <div class="header-container d-flex align-items-center">
                <div class="logo mr-auto">
                    <h1 class="text-light"><a href="/"><span>A <b style="color: yellow;">.</b> L <b style="color: yellow;">.</b> T </span></a></h1>
                    <!-- Uncomment below if you prefer to use an image logo -->
                    <!-- <a href="index.html"><img src="/resources/assets/img/logo.png" alt="" class="img-fluid"></a>-->
                </div>

                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.memberVO" var="memberVO" />
                </sec:authorize>

                <nav class="nav-menu d-none d-lg-block">
                    <ul>
                        <li><a class="btn btn-link" onclick="basketgo()">장바구니</a></li>
                        <li><a class="btn btn-link" href="/board/saleBoard">판매게시판</a></li>
                        <li><a class="btn btn-link" onclick="mypagecheck()">마이페이지</a></li>
                        <li><a class="btn btn-link" href="/notice/list">공지사항</a></li>
                        <!-- <li><a class="btn btn-link" href="#contact">고객센터</a></li> -->
                        <!-- <li class="drop-down"><a href="">Drop Down</a>
                            <ul>
                                <li><a href="#">Drop Down 1</a></li>
                                <li class="drop-down"><a href="#">Drop Down 2</a>
                                    <ul>
                                        <li><a href="#">Deep Drop Down 1</a></li>
                                        <li><a href="#">Deep Drop Down 2</a></li>
                                        <li><a href="#">Deep Drop Down 3</a></li>
                                        <li><a href="#">Deep Drop Down 4</a></li>
                                        <li><a href="#">Deep Drop Down 5</a></li>
                                    </ul>
                                </li>
                                <li><a href="#">Drop Down 3</a></li>
                                <li><a href="#">Drop Down 4</a></li>
                                <li><a href="#">Drop Down 5</a></li>
                            </ul> 
                        </li> -->
                        
						
                        <sec:authorize access="isAnonymous()">
                            <li><span class="material-icons"></span><a href="/loginForm">현재 비회원 접속중..</a></li>
                        </sec:authorize>
                        
                        <sec:authorize access="isAnonymous()">
                            <li class="get-started"><a href="/client/loginForm">회원</a></li>
                            <li class="get-started"><a href="/vendor/loginForm">업체</a></li>
                            <li class="get-started"><a href="/all/loginForm">통합</a></li>
                        </sec:authorize>
                        
                        <sec:authorize access="hasRole('ROLE_CLIENT')">
                            <li><a href="/mypage">${memberVO.cnick}(${memberVO.cid}) 님 어서오세요!</a></li>
                        </sec:authorize>
                        
                        <sec:authorize access="hasRole('ROLE_VENDOR')">
                            <li><a href="/mypage">${memberVO.vname}(${memberVO.vid}) 님 어서오세요!</a></li>
                        </sec:authorize>
                        
                        <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
                        	<li><a href="/mypage">${memberVO.cname}(관리자) 님 어서오세요!</a></li>
                        </sec:authorize>
                        
		                <sec:authorize access="hasAnyRole('ROLE_VENDOR','ROLE_CLIENT','ROLE_ADMIN')">
			                <!-- 지영 -->
			                <!-- chat -->
							<li><a href="" onclick="javascript:window.open('/room','new','left=50, top=50, width=450, height=700')"><img src="/resources/assets/img/chat-2389223_1280.png" style="width:35px; height:35px;"></a></li>
		            	</sec:authorize>
		            	
		          		<li id="msgStack"></li>
		          		
                        <sec:authorize access="isAuthenticated()">
                            <li class="get-started">
                                <form id="logout" action="/Logout" method="post">
                                	<a>로그아웃</a>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>
                            </li>
                        </sec:authorize>
                        
                        
                        
                    </ul>
                </nav><!-- .nav-menu -->
            </div><!-- End Header Container -->
        </div>

        <script type="text/javascript">
        
        	//마이페이지 유효성 체크
            function mypagecheck() {


                var cid = '<c:out value="${memberVO.cid}"></c:out>';
                var vid = '<c:out value="${memberVO.vid}"></c:out>';

                if (cid == '' && vid == '') {

                    alert("로그인 후 사용이 가능합니다.");
                    location.href = "/";

                } else if (cid != '' && vid == '') {

                    location.replace("/client/mypage");

                } else if (cid == '' && vid != '') {

                    location.replace("/vendor/mypage");

                }

            }

            //장바구니 유효성 체크
            function basketgo() {


                var ccid = '<c:out value="${memberVO.cid}"></c:out>';
                var vvid = '<c:out value="${memberVO.vid}"></c:out>';

                if (ccid == '' && vvid == '') {

                    alert("로그인을 해야지 가능한 기능입니다.");
                    location.href = "/";

                } else if (ccid != '' && vvid == '') {

                    location.replace("/board/basketList?cid=<c:out value='${memberVO.cid}'></c:out>");

                } else if (ccid == '' && vvid != '') {

                    alert("장바구니는 회원전용입니다.");
                    location.replace("/");

                }

            }
			
            //로그아웃 
            $("#logout a").on("click", function() {

                $("#logout").submit();

            });
            
        </script>
    </header><!-- End Header -->