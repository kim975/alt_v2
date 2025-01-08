<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>




<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>

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
	    <li class="breadcrumb-item"><a href="/client/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item active" aria-current="page">내 정보</li>
	  </ol>
	</nav>

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
                 <td class="infotd"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.cid}</td>
             </tr>
             
			<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
			
             <tr>
                 <th  class="row"><b>이름</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.cname}</td>
             </tr>
			
			<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
			
            <tr>
                 <th class="row"><b>닉네임</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.cnick}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th  class="row"><b>전화 번호</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.cphone}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th  class="row"><b>주소</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.caddress}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th  class="row"><b>신고횟수</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.creport} 회 <b style="color: red;"> * (신고횟수 10회 이상 제제대상)</b></td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
             <tr>
                 <th class="row"><b>가입날짜</b></th>
                 <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${client.cjoinDate}</td>
             </tr>
             
             <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
             
         </table>
         <div class="row">
          <a href="/client/mypage_update?cid=${memberVO.cid}">
         	<input type="submit" class="inbutton" style="background-color:#009970" value="수정하기">
         </a>
                     
         <a href="/client/mypage_update_password?cid=${memberVO.cid}">
         	<input type="submit" class="inbutton" style="background-color:#17A2B8" value="비밀번호 변경">
         </a>
		</div>
            </div>
          </div>

    </section><!-- End Services Section -->

 <!--  <main id="main">
  </main>End #main -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>

