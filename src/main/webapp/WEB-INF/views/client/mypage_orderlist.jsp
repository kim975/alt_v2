<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
	table{width:80%; auto; text-align:center; background-color:white;}
	
	.btn-outline-success {
    	width: 80px;
	}
</style>
	
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/client/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item active" aria-current="page">내 주문 목록</li>
	  </ol>
	</nav>

<!-- ======= mypage Section ======= -->
<section id="mypage" class="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>내 주문 목록</h2>
              <p>내 주문을 확인 및 결제 여부 확인 할 수 있습니다.<br>만약 문의가 있다면 문의하기로 업체와 직접 커뮤니케이션 하세요.</p>
            </div>
          </div><!-- End col-lg-4 -->
       </div><!-- END row --> 
       
       <!-- 검색 form --><!-- id를 변경 -->
       <nav class="navbar navbar-light bg-light">
	       <div class="dropdown event-dropdown ms-3">
				<a href="" class="btn btn-bd-light dropdown-toggle" data-toggle="dropdown">거래별</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item current" aria-current="true" href="/client/mypage_orderlist?type=&cid=${memberVO.cid}">전체거래</a></li>
					<li><hr class="dropdown-divider"></li>
				    <li><a class="dropdown-item" href="/client/mypage_orderlist?type=Y&cid=${memberVO.cid}">상거래</a></li>
				    <li><a class="dropdown-item" href="/client/mypage_orderlist?type=N&cid=${memberVO.cid}">직거래</a></li>
				</ul>
			</div>
	  </nav>
       <div class="row aos-init aos-animate" data-aos="fade-up" data-aos-delay="200">
	        <div class="col-lg-12 d-flex justify-content-center">
				<table class="table table-striped table-bordered table-hover">
					<thead>
					    <tr>
					        <th>주문번호</th>
					        <th>주문자</th>
					        <th>주소</th>
					        <th>수령인 번호</th>
					        <th>주문 날짜</th>
					        <th>직거래/상거래</th>
					        <th>비고</th>
					    </tr>
					</thead>
					<tbody>
						<c:forEach items="${ordlist }" var="list">
						<tr>
							<td style="font-weight:bold"> <a href="/client/mypage_ordercode?ocode=${list.ocode }"><c:out value="${list.ocode }"/></a> </td>
							<td> <c:out value="${list.cid }"/> </td>
							<td> <c:out value="${list.oaddress }"/> </td>
							<td> <c:out value="${list.ophone }"/> </td>
							<td> <fmt:formatDate value="${list.odate }" pattern="yyyy/MM/dd HH:mm:ss"/> </td>
							<c:if test="${list.opay == 'N'}">
								<td style="color: red;"> <b>직거래</b> </td>
							</c:if>
							<c:if test="${list.opay == 'Y'}">
								<td style="color: blue;"> <b>상거래</b> </td>
							</c:if>
							<td> 
							<c:if test="${list.opay == 'N'}">
								<a class="btn btn-outline-success" href="/board/conferDoc?ocode=${list.ocode }">협의서</a>
							</c:if> 
							</td>
						</tr>
						</c:forEach>
					    </tbody>
				</table><!-- /.board table -->
            <!-- </div> -->

	       </div>
	     </div><!-- End row -->
     
	</div><!-- End container -->
</section><!-- End mypage -->

<script>

//
// dropdown 메뉴가 보이기 직후에 호출되는 이벤트
$('.event-dropdown').on('shown.bs.dropdown', function () {
});

//
// dropdown 메뉴가 사라진 직후에 호출되는 이벤트
$('.event-dropdown').on('hidden.bs.dropdown ', function () {
});

</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>