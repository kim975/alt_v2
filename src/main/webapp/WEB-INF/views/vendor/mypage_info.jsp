<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>

table{width:80%; auto;}


.simple_table { width: 100%; border: 0; border-collapse: separate; border-spacing: 2px;}
.simple_table th { padding: 15px; border: none; border-left: 5px solid #009970; border-bottom: 1px solid #DDD; background: #F4FFFF;  font-weight: normal; text-align:center; text-shadow: 0 1px #FFF; vertical-align: middle;}
.simple_table td { padding: 15px; border: none; border-bottom: 1px solid #DDD; text-align: left; vertical-align: baseline;}

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
	    <li class="breadcrumb-item active" aria-current="page">내 정보</li>
	  </ol>
	</nav>

<!-- ======= mypage Section ======= -->
    <section id="services" class="">
      <div class="container">

        <div class="row">
          <div class="col-lg-4">
            <div class="section-title" data-aos="fade-right">
              <h2>내 정보</h2>
              <p>당신 현재 가지고 있는 정보를 보여줍니다.<br>당신의 정보를 확인해보세요.</p>
            </div>
          </div>
       	<table class="simple_table" style="margin-top:7px;">
       	
             <tr>
                 <th  class="row"><b>아이디</b></th>
                 <td class="infotd"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vid}</td>
             </tr>
             
			<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
			
             <tr>
                 <th  class="row"><b>업체 이름</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vname}</td>
             </tr>
			
			<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
			
            <tr>
                 <th class="row"><b>업체등록번호</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vregisterNo}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th  class="row"><b>업체 연락처</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vphone}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th  class="row"><b>업체 주소</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vaddress}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
            
             
             <tr>
                 <th class="row"><b>신고 횟수</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vreport} 회<b style="color: red;"> * (신고횟수 10회 이상 제제대상)</b></td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th class="row"><b>업체 등급</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vgrade}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th class="row"><b>업체 가입 날짜</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vjoinDate}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
              <tr>
                 <th  class="row"><b>업체 설명</b></th>
                 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${vendor.vinfo}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
         </table>
         <div class="row">
          <a href="/vendor/mypage_modify?vid=${memberVO.vid}">
         	<input type="submit" class="inbutton" style="background-color:#009970" value="수정하기">
         </a>
                     
         <a href="/vendor/mypage_update_password?vid=${memberVO.vid}">
         	<input type="submit" class="inbutton" style="background-color:#17A2B8" value="비밀번호 변경">
         </a>
		</div>
            </div>
          </div>

    </section><!-- End Services Section -->

 <!--  <main id="main">
  </main>End #main -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
