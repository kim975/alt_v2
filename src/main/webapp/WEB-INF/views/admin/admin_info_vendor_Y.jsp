<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
  <%@ include file="/WEB-INF/views/include/admin_header.jsp" %>         
 
<style>
  table, #searchForm{auto:0; width:100%; height:100%;}
  
  .bt2{
	background-color: silver;
	color: green;
	margin:20px;
	padding: 5px 10px;
	barder-style: soild;
	barder-width: 3px 3px 3px 3px;
	border-color: green  green  green  green;
}
 
 .page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: green;
    border-color: #007bff;
}

.page-link {
    position: relative;
    display: block;
    padding: .5rem .75rem;
    margin-left: -1px;
    line-height: 1.25;
    color: green;
    background-color: #fff;
    border: 1px solid #dee2e6;
}
a {
    color: green;
    text-decoration: none;
    background-color: transparent;
}
 
</style>
<br><br>

 <h2> 업체 탈퇴 여부 페이지</h2> 
	   
	<br><br> 
	  <nav class="navbar navbar-light bg-light d-flex justify-content-center" >
		  <div class="container-center" >
						<form  class="d-flex justify-content-center" id='searchForm' action="/admin/vendorListYPaging" method='get'>
						<select class="form-control me-2" name="type">
								<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="I"
									<c:out value="${pageMaker.cri.type eq 'I'?'selected':''}"/>>아이디</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>기간</option>
								<option value="A"
									<c:out value="${pageMaker.cri.type eq 'A'?'selected':''}"/>>주소</option>
								<option value="IT"
									<c:out value="${pageMaker.cri.type eq 'IT'?'selected':''}"/>>아이디   or 기간</option>
								<option value="IA"
									<c:out value="${pageMaker.cri.type eq 'IA'?'selected':''}"/>>아이디   or 주소</option>
								<option value="ITA"
									<c:out value="${pageMaker.cri.type eq 'ITA'?'selected':''}"/>>아이디 or 기간    or 주소</option>
							</select> 
							<input class="form-control me-2 " type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="입력하세요">
							<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum }'>
							<input type="hidden" name="amount" value='${pageMaker.cri.amount }'>
							<button type="button" class='form-control btn btn-success me-2'>검색</button>  	
							</form>
					    </div><!-- /.container -->
					    </nav>
				

        <form id= "vendorList" method="get">
          <div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="200">  	
      	<div class="row">
			<table class="table table-striped table-bordered table-hover">
			    <thead>
			         <tr>
								            <th>아이디</th>
								            <th>이름</th>
								            <th>사업자 번호</th>
								            <th>전화번호</th>
								            <th>주소</th>
								            <th>가입일</th>
								            <th>업체정보</th>
								            <th>신고</th>
								            <th>삭제여부</th>
								            <th>등급</th>
								            <th>삭제</th>
								             
								            
								        </tr>
			    </thead>
			    <tbody>
			    	 <c:forEach items="${vendorListYPaging }" var="vendorY">
                                  <tr>
	                                <td><c:out value="${vendorY.vid }"  /></td>
	                                <td><c:out value="${vendorY.vname }"/></td>
	                                <td><c:out value="${vendorY.vregisterNo }"/></td>
	                                <td><c:out value="${vendorY.vphone }"/></td>
	                                <td><c:out value="${vendorY.vaddress }"/></td>
	                                <td><fmt:formatDate pattern="yy/MM/dd" value="${vendorY.vjoinDate }"/></td>
	                                <td><c:out value="${vendorY.vinfo }"/></td>
	                                <td><c:out value="${vendorY.vreport }"/></td>
	                                <td><c:out value="${vendorY.vdelete }"/></td>
			                        <td><c:out value="${vendorY.vgrade}"/></td>
		                             <td> 
		                             <button type="button" class='form-control btn btn-danger me-2'onclick="location.href='/admin/vendortDeleteY?vid=${vendorY.vid}'">삭제</button> </td>
		                               
	                             </tr>
	                            </c:forEach>
			     </tbody>
			 </tbody>
			</table><!-- /.table-responsive -->
			 <!-- 페이징 번호 표시 -->
		<div class=" dataTables_paginate paging_simple_numbers"  >    <!-- 가운데  paginate_button page-item active-->
		<nav aria-label="pagination">
		  	<ul class="pagination justify-content-center">
				<c:if test="${pageMaker.prev }"><li class="paginate_button page-item active">
					<li class="paginate_button previous btn-outline-success"><a href="1">&lt;&lt;</a></li>
					<li class="paginate_button previous btn-outline-success">
						<a href="${pageMaker.startPage -1 }">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<li class='paginate_button page-item ${pageMaker.cri.pageNum == num ? "active":""}'><a href="${num}"  aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button page-item "><a href="${pageMaker.endPage +1 }"  aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">&gt;</a></li>
				</c:if>
		  	</ul>
		</nav>
		</div>
      	</div>
      	</form>
      		<!-- 페이지번호표시 -->
                 <!-- 페이징 번호 클릭시 자바스크립트를 이용하여 컨트롤러에 전달한 값을 가진 from -->
				 <form id="actionForm" action="/admin/vendorListYPaging" method="get">
					 <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					 <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					 <input type='hidden' name="type" value='<c:out value="${pageMaker.cri.type}"/>'> 
					 <input type='hidden' name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
				 </form>
      	
     
				
				<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
				<script>
				//페이징 고려
				//현재 페이지의 페이지 번호와 행수를 가진 폼에게 변수에 저장
				var actionForm = $("#actionForm");
				
				//페이징번호 클릭시 폼 전송
				$(".paginate_button a").on("click", function(e){
					
					e.preventDefault();
					console.log('click');
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit();
				});
				
				
				/* 검색조건 */
				var searchForm = $("#searchForm");
				
				$("#searchForm button").on("click", function(e){
					
					if (!searchForm.find("option:selected") .val()) {
						alert("검색종류를 선택하세요");
						return false;
					   }

					if (!searchForm.find("input[name='keyword']").val()) {
						alert("키워드를 입력하세요");
						return false;
				    	}

					searchForm.find("input[name='pageNum']") .val("1");
					e.preventDefault();

					searchForm.submit();

						 });

				
				
				</script>
      
      	<%@ include file="/WEB-INF/views/include/admin_footer.jsp" %>