<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>

 <!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리자 페이지</title>
     <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body>
	<sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.memberVO" var="memberVO" />
    </sec:authorize>

  <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
                <div class="sidebar-brand-icon rotate-n-15">
                  
                </div>
                <div class="sidebar-brand-text h3 mb-1">A.L.T <sup></sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="/admin/admin">
                      <i class="fas fa-laugh-wink"></i>
                    <span>관리자 페이지</span></a>
            </li>

              <!-- Divider -->
            <hr class="sidebar-divider"/>

            <!-- 회원메뉴   -->
            <li class="nav-item sidebar-divider">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                    	회원
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar" >
                    <div class="bg-success py-2 collapse-inner rounded " >
                       
                        <a class="collapse-item" href="clientInfo" >회원목록</a>
	         			<a class="collapse-item"  href="clientListYPaging" >회원탈퇴여부</a>
                        <a class="collapse-item" href="clientListRPaging">회원신고여부</a>
                          
                    </div>
                </div>
            </li>
 
              <!-- 업체메뉴 -->
            <li class="nav-item ">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
                 			   업체
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar"  >
                    <div class="bg-success py-2 collapse-inner rounded">
                        
                        <a class="collapse-item" href="vendorListPaging" >업체 목록</a>
                        <a class="collapse-item" href="vendorListYPaging">업체 탈퇴여부</a>
                        <a class="collapse-item" href="vendorListRPaging">업체 신고 횟수 </a>
                        <div class="collapse-divider"></div>
                    
                    </div>
                </div>
            </li>
             <!-- 게시판메뉴 -->
             <li class="nav-item ">
                <a class="nav-link " href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapsePages">
                 			   게시판
                </a>
                <div id="collapseUtilities"  class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar"  >
                    <div class="bg-success py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/admin/saleList" >판매게시판</a>
                        <a class="collapse-item" href="/notice/list">공지사항</a>
                       
                        <div class="collapse-divider"></div>
                    </div>
                </div>
            </li>
              
             <!-- 상품-->
             <li class="nav-item ">
                <a href="/admin/productList" class="nav-link" >
                 			  상품등록
                </a>
            </li>
            
        </ul>
        
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                   
                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- 유튜브  -->
                        <li class="nav-item dropdown no-arrow mx-1"  >
                            <a class="nav-link dropdown-toggle "  href="https://youtube.com/channel/UC5NDFzO6NTBCUNo3v8vvbrA"
                                    >youtube</a> 
                        </li>
                        
                           <!-- 인스타  -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="https://www.instagram.com/panorama__v/" 
                            		  >instargram</a>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span>
                                <img class="img-profile rounded-circle"
                                    src="/resources/img/undraw_profile.svg">
                            </a>

                        </li>
                        <li>
						<sec:authorize access="isAuthenticated()">
                                <form id="logout" action="/Logout" method="post">
                                	<input type="submit" class="btn btn-danger" value="로그아웃">
                                    <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>
                        	</sec:authorize>
                        </li>
                    </ul>

                </nav>
                
  
                <!-- End of Topbar -->
                
                <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

 