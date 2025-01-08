<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>
<script src="https://kit.fontawesome.com/3929e16ef5.js"></script>
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
 
	
	.goods:hover {
		
		box-shadow: 1px 1px 20px #ddd
		
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

.intext{
   width:300px; 
   border-style: solid;
   border-width: 0 0 0 8px; 
   padding: 12px; 
   word-break: break-all;
   border-color: #009970;
   background-color:rgba(211, 211, 211, 0.2);
}
</style>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active" aria-current="page">판매게시판</li>
	  </ol>
	</nav>

<!-- ======= Hero Section ======= -->

	<section id="portfolio" class="portfolio">
      <div class="container">

        <div class="section-title" data-aos="fade-left">
          <h2>농축산물 판매 정보/리뷰</h2>
          <p>우리 A.L.T 홈페이지에서는 직거래를 통해서 좀더 저렴하고, 질 좋은 상품들을 선택 할 수 있습니다 ! 당신은 더욱 더 좋은 상품을 선택할 수 있습니다.</p>
          <p>모든 농축산물 거래의 시작 A.L.T ! </p>
        </div>
		
        <div class="row" data-aos="fade-up" data-aos-delay="100">
          <div class="col-lg-12 d-flex justify-content-center">
            <ul id="portfolio-flters">
              <form id="searchForm" action="/board/saleBoard" method="get">
              	<input class="btn btn-default btn-xs intext" type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
             	<button class='btn btn-success btn-xs'>검색</button>
             	<sec:authorize access="hasRole('ROLE_VENDOR')">
              		<a href="/board/saleRegister"><li class="filter-active">판매하기</li></a>
              	</sec:authorize>
              	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
				<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
              </form>
              	
            </ul>
          </div>
        </div>
        
        <div class="row">
          <div class="col-lg-12 d-flex align-items-stretch"  style="width: 100%;">
            <div class="icon-boxes d-flex flex-column justify-content-center" style="width: 100%;">
			
			<c:set var="i" value="0" />
			<c:set var="j" value="4" />
			
  			<c:choose>
				<c:when test="${saleBoardList != null}">
    				<c:forEach items="${saleBoardList}" var="board" varStatus="status">
     					<c:if test="${i%j == 0}">
      						<div class="row d-flex" style="margin-bottom: 20px; width: 100%;">
     					</c:if>
			                <!-- <div class="col-xl-3 d-flex align-items-stretch aos-init aos-animate" data-aos="zoom-in" data-aos-delay="100"> -->
			                <div class="col-lg-3" style="height: 300px;">
			                	<a href="/board/saleDetail?sno=${board.sno }">
			                	<div class="goods" style="width: 230px; height: 100%; padding-left: 10px;">
	     							<div class="span3">
	     								<div  id="${board.sno }">
	     									<div style="margin-bottom: 5px;"><div style="width: 100%; height: 100%"><img style='width: 100%; height: 210px;' src='/resources/img/no_img.gif'></div></div>
	     								</div>
	     								<span style="color: black;">
	     									<span style="font-size: 14px;"><c:out value="${board.stitle }"/></span><br>
	     									<span style="color: #ae0000; font-weight: bold;"><fmt:formatNumber value="${board.sprice }" pattern="###,###"/>원</span><br>
	     									<span class="boardContent${board.sno }" style="color: orange;">
	     										<i class='far fa-star'></i><i class='far fa-star'></i><i class='far fa-star'></i><i class='far fa-star'></i><i class='far fa-star'></i>
	     										<span style="font-size: 11px; color: #888;">(0)</span>
	     									</span>
										</span>
									</div>
								</div>
								</a>
			                </div>
            			<c:if test="${i%j == j-1}">
     						</div>
     						<div style="margin-bottom: 30px;">
     							<hr style="height: 1px;">
     						</div>
    					</c:if> 
   						<c:set var="i" value="${i+1}" />
    				</c:forEach>
   				</c:when>
   				
				<c:otherwise>
   					<div>
    					<span>존재하지 않습니다.</span>
   					</div>
  				</c:otherwise>
  			</c:choose>
              
            </div><!-- End .content-->
          </div>
        </div>
        
          <!-- 페이징 번호 표시 -->
      <div class=" dataTables_paginate paging_simple_numbers"  >    <!-- 가운데  paginate_button page-item active-->
	      <nav aria-label="pagination">
	           <ul class="pagination justify-content-center">
	            <c:if test="${pageMaker.prev }"><li class="paginate_button page-item active">
	               <li class="paginate_button page-item">
	              	 <a href="1" aria-controls="dataTable" class="page-link">&lt;&lt;</a>
	               </li>
	               <li class="paginate_button page-item">
	               	  <a href="${pageMaker.startPage -1 }" class="page-link">&lt;</a>
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
    
      
	</section>		
	
	<form id='actionForm' action="/board/saleBoard" method='get'>
	 	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>' />
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
	 </form>
	 
		

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>        
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script type="text/javascript" src="/resources/customjs/board.js"></script> -->
<script type="text/javascript">
	
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ajaxSend(function(e, xhr, options) {
   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
})

	var actionForm = $("#actionForm");

	//페이지 번호 클릭 시, 폼의 현태번호를 클릭한 페이지호로 변경하여 전송
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
		
	});
	
	$(document).ready(function() {
		(function() {
			
			var snoStr = '<c:out value="${thumbImgSnoList}"/>';
			
			$.getJSON("/board/getThumbList", {snoStr: snoStr}, function(arr) {
	
				var str = "";
				
				$(arr).each(function(i, attach) { 
					
						
					var fileCallPath = encodeURIComponent(attach.stuploadPath + "/s_" + attach.stuuid + "_" + attach.stfileName);
					
					str = "<div style='margin-bottom: 5px;' data-path='" + attach.stuploadPath + "' data-uuid='" + attach.stuuid + "' data-filename='" + attach.stfileName + "' data-type='" + attach.stfileType + "'>"
						+  "	<div style='width: 100%; height: 100%;'>"
						+  "		<img style='width: 100%; height: 210px;' src='/display?fileName=" + fileCallPath + "'>"
						+  "	</div>"
						+  "</div>";
						
					$("#" + attach.sno).html(str);
				});
				
			}); //end getJSON
		})();
	});
	
	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e) {

		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}

		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();

	});
	
	$(document).ready(function() {
		
		<c:forEach items="${star }" var="starList">
			
			str = "";
		
			for (var j = 0; j < 5; j++) {
				if(j < '${starList.RSTAR}') {
					str += "<i class='fas fa-star'></i>";	
				} else {
					str += "<i class='far fa-star'></i>";
				}
			}
			str += "<span style='font-size: 11px; color: #888;'>(${starList.CNT})</span>"
			$(".boardContent${starList.SNO}").html(str);
		</c:forEach>
		
	});
	
	
</script>
<%@include file="/WEB-INF/views/include/footer.jsp" %>
  <!-- session start div -->

