<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>

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

<main id="main">

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active" aria-current="page">공지사항</li>
	  </ol>
	</nav>


<!-- ======= searchBar Section ======= -->
<section id="searchBar" class="d-flex align-items-center">
  
  	<!-- Model 추가-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel"></h4>
	            </div>
	            <div class="modal-body">처리가 완료되었습니다.</div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

    <div class="container position-relative" data-aos="fade-in" data-aos-delay="200">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>공지사항</h2>
              
            </div>
          </div><!-- End col-lg-4 -->
        </div><!-- End row -->

		<!-- 검색 form -->
		<nav class="navbar navbar-light bg-light">
		  <div class="container-fluid">
			<form class="d-flex justify-content-center" id='searchForm' action="/notice/list" method="get">
				<select class="form-control me-2" name="type">
					<option value=""<c:out value="${pageMaker.cri.type == null?'selec	ed':'' }"/>>검색범위를 선택하세요</option>
					<option value="T"<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
					<option value="C"<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
					<option value="W"<c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
					<option value="TC"<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
					<option value="TW"<c:out value="${pageMaker.cri.type eq 'Tw'?'selected':'' }"/>>제목 or 작성자</option>
					<option value="TCW"<c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
				</select>
				<input class="form-control me-2" type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="검색어를 입력하세요">
				<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum }'>
				<input type="hidden" name="amount" value='${pageMaker.cri.amount }'>
				<button type="button" class='form-control btn btn-success me-2'>검색</button>  	
			</form>
		  </div>
		</nav>

	</div><!-- END container -->
</section>
        	<!-- <div class="d-grid gap-2 d-md-flex justify-content-md-end"> -->

<!-- ======= tableList Section ======= -->
<section id="tableList" class="d-flex align-items-center">
  <div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="200">  	
      	<div class="row">
			<table class="table table-striped table-bordered table-hover">
			    <thead>
			        <tr>
			            <th>#번호</th>
			            <th>제목</th>
			            <th>작성자</th>
			            <th>작성일</th>
			            <th>수정일</th>
			        </tr>
			    </thead>
			    <tbody>
			    	<c:forEach items="${noticeList}" var="notice">
			    	<tr>
			    		<td><c:out value="${notice.nno }"/></td>
			    		<td><a class='toGet' style="color:#009970; font-weight:bold;" href='<c:out value="${notice.nno }"/>'><c:out value="${notice.ntitle }"/></a></td>
			    		<td><c:out value="${notice.nwriter }"/></td>
			    		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${notice.nwriteDate }"/></td>
			    		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${notice.nupdateDate }"/></td>
			    	</tr>
			    	</c:forEach>
			    </tbody>
			</table><!-- /.table-responsive -->
      	</div><!-- /.row -->
      	
		<!-- 페이징 FORM -->
		<form id="actionForm" action="/notice/list" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
			<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
		</form>
		
	    <!-- 페이징 번호 표시 -->
	    <%-- <div class="d-flex flex-row-reverse bd-highlight">
		<nav aria-label="Page navigation">
		  	<ul class="pagination justify-content-end">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous p-3 bd-highlight btn-outline-success"><a href="1">&lt;&lt;</a></li>
					<li class="paginate_button previous p-3 bd-highlight btn-outline-success">
						<a href="${pageMaker.startPage -1 }">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<li class='paginate_button p-3 bd-highlight btn-outline-success ${pageMaker.cri.pageNum == num ? "active":""}'><a href="${num}">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next p-3 bd-highlight btn-outline-success"><a href="${pageMaker.endPage +1 }">&gt;</a></li>
				</c:if>
		  	</ul>
		</nav>
		</div> --%>
		
		<!-- 페이징 번호 표시 -->
      	<div class=" dataTables_paginate paging_simple_numbers"  >    <!-- 가운데  paginate_button page-item active-->
      	<nav aria-label="pagination">
           <ul class="pagination justify-content-center">
            <c:if test="${pageMaker.prev }"><li class="paginate_button page-item active">
               <li class="paginate_button page-link"><a href="1">&lt;&lt;</a></li>
               <li class="paginate_button page-link">
                  <a href="${pageMaker.startPage -1 }">&lt;</a>
               </li>
            </c:if>
            <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
               <li class='paginate_button page-item ${pageMaker.cri.pageNum == num ? "active":""}'><a href="${num}"  aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${num}</a></li>
            </c:forEach>
            <c:if test="${pageMaker.next }">
               <li class="paginate_button page-item "><a href="${pageMaker.endPage + 1 }"  aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">&gt;</a></li>
            </c:if>
           </ul>
     	</nav>
      	</div>
      	<sec:authorize access="hasRole('ROLE_ADMIN')">
	      	<div class="d-flex flex-row-reverse">
				<button id='addBtn' type="button" class="btn btn-success" style="background-color:#009970" onclick="self.location='/notice/register'">글작성</button>
	    	</div>
	    </sec:authorize>
    </div><!-- /.container -->
</section><!-- End about -->

<!-- ======= Counts Section ======= -->
<section id="counts" class="counts">
  <div class="container">
    <div class="row counters">
      <div class="col-lg-3 col-6 text-center">
        <span data-toggle="counter-up">${clientCount}</span>
        <p>회원수</p>
      </div>
      <div class="col-lg-3 col-6 text-center">
        <span data-toggle="counter-up">${vendorCount}</span>
        <p>업체수</p>
      </div>
      <div class="col-lg-3 col-6 text-center">
        <span data-toggle="counter-up">${totalsaleboard}</span>
        <p>상품수</p>
      </div>
      <div class="col-lg-3 col-6 text-center">
        <span data-toggle="counter-up">${totalOrd}</span>
        <p>주문 수</p>
      </div>
    </div>
  </div>
</section><!-- End Counts Section -->

</main><!-- End #main -->

<script type="text/javascript">

//지영
//페이지 동작
window.addEventListener('popstate',function(event){
	history.pushState(null,null,location.href);
});

$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	checkModal(result);
	
	history.pushState(null,null,location.href);
});

//지영
//처리완료 modal
function checkModal(result) {
	if (result==='' || history.state) {
		return;
	}

	if (parseInt(result)>0) {
		$(".modal-body").html("게시글 " + parseInt(result)+ " 번이 등록되었습니다.");
	}
	$("#myModal").modal('show');
}

$("#regBtn").on("click", function() {
	self.location = "/notice/register";
});

var actionForm = $("#actionForm");

$(".paginate_button a").on("click", function(e) {
	e.preventDefault();
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.submit();
});

//지영
//get페이지 이동
 $(".toGet").on("click",function(e) {
	e.preventDefault();
	actionForm.append("<input type='hidden' name='nno' value='"+ $(this).attr("href") +"'>");
	actionForm.attr("action","/notice/get")
	actionForm.submit();
});

//지영
//검색
var searchForm = $("#searchForm");

$("#searchForm button").on("click", function(e) { 
	
	if(!searchForm.find("option:selected").val()) {
		alert("검색범위를 선택하세요.");
		return false;
	}
	
	if(!searchForm.find("input[name='keyword']").val()) {
		alert("검색어를 입력하세요.");
		return false;
	}
	
	searchForm.find("input[name='pageNum']").val("1");
	e.preventDefault();
	searchForm.submit();
});
</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>