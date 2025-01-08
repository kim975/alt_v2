<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
	table{width:80%; auto;}
</style>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/vendor/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item active" aria-current="page">판매글 목록</li>
	  </ol>
	</nav>

<!-- ======= mypage Section ======= -->
<section id="mypage" class="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>판매글 목록</h2>
            </div>
          </div><!-- End col-lg-4 -->

	<table class="table table-striped table-bordered table-hover">
		<thead>
		    <tr>
		        <th>#판매번호</th>
		        <th>제목</th>
		        <th>내용</th>
		        <th>작성일</th>
  		        <th>수정일</th>
		        <th>가격</th>
		        <th>수량</th>
		    </tr>
		</thead>
		<tbody>
			<c:forEach items="${salelist }" var="list">
			<tr>
				<td> <c:out value="${list.sno }"></c:out> </td>
				<td style="font-weight:bold;"><a href='/board/saleDetail?sno=<c:out value="${list.sno }" 	/>'><c:out value="${list.stitle }"/></a></td>
				<%-- <td> <c:out value="${list.stitle }"></c:out> </td> --%>
				<td> <c:out value="${list.sinfo }"></c:out> </td>
				<td> <fmt:formatDate value="${list.swriteDate }" pattern="yyyy/MM/dd HH:mm:ss"/> </td>
				<td> <fmt:formatDate value="${list.supdateDate }" pattern="yyyy/MM/dd HH:mm:ss"/> </td>
				<td> <c:out value="${list.sprice }"></c:out> </td>
				<td> <c:out value="${list.samount }"></c:out> </td>
			</tr>
			</c:forEach>
		</tbody>
	</table><!-- /.board table -->
	
      </div><!-- End row -->
    </div><!-- End container -->
</section><!-- End mypage -->

<script>
//지영
//saleboard 글번호 상세페이지로 이동(url 확인해야함)
/* $(".move").on("click",function(e) {
	e.preventDefault();
	actionForm.append("<input type='hidden' name='sno' value='"+ $(this).attr("href") +"'>");
	actionForm.attr("action","/board/saleboard/get")
	actionForm.submit();
}); */
</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>
