<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/client/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item active" aria-current="page">내 찜 목록</li>
	  </ol>
	</nav>



<!-- ======= Hero Section ======= -->
  <section id="mypage" class="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>나의 찜 목록</h2>
            </div>
          </div><!-- End col-lg-4 -->
       </div>
       
    <c:forEach items="${zimlist }" var="list">
    <div class="container h-100">
    <div class="d-flex justify-content-center align-items-center h-100" style="margin-bottom: 20px; width: 100%;">
    	<div class="card" style="width:100%;">
            <div class="row sno">
            	<a href="/board/saleDetail?sno=${list.sno }">
					<div class="col-lg-2 img${list.sno }">
					
					</div>
				</a>
                <div class="col-lg-8 card-body">
                	<a href="/board/saleDetail?sno=${list.sno }">
                    	<h5 class="card-title" style="color:#009970; font-weight:bold;">상품 : <c:out value="${list.stitle }"/></h5>
                    </a>
                    <p class="card-text" style="font-weight:bold;">가격 : <c:out value="${list.sprice }"/></p>
                </div>
                <div class="col-lg-2 card-body">
                	<button id='moveBasket' type="button" class="btn btn-primary" value="${list.sno }">담아두기</button>
                </div>
                <input type="hidden" value="${memberVO.cid }" name="cid">
                <input type="hidden" value="${list.sprice }" name="price">
                <input type="hidden" value="${list.sno }" name="sno">
                <input type="hidden" value="1" name="amount">
            </div>
		</div>
    </div>

</div>
</c:forEach>
    
	</div>
  </section><!-- End Hero -->

 <!--  <main id="main">
  </main>End #main -->
  
<script type="text/javascript" src="/resources/customjs/basket.js"></script>
<script type="text/javascript">

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ready(function() {
	(function() {
		
		var snoStr = '<c:out value="${thumbImgSnoList}"/>';
		
		$.getJSON("/board/getThumbList", {snoStr: snoStr}, function(arr) {

			var str = "";
			
			$(arr).each(function(i, attach) { 
				
					
				var fileCallPath = encodeURIComponent(attach.stuploadPath + "/s_" + attach.stuuid + "_" + attach.stfileName);
				
				str = "<div data-path='" + attach.stuploadPath + "' data-uuid='" + attach.stuuid + "' data-filename='" + attach.stfileName + "' data-type='" + attach.stfileType + "'>"
					+  "	<div>"
					+  "		<img style='width:100px; height:100px;' src='/display?fileName=" + fileCallPath + "'>"
					+  "	</div>"
					+  "</div>";
					
				$(".img" + attach.sno).prepend(str);
			});
			
		}); //end getJSON
	})();
});	

$("#moveBasket").on("click",function(e){
	
	var zim = $(this).closest(".row");
	
	console.log(zim);
	
	var price = zim.find("input[name='price']");
	var amount = zim.find("input[name='amount']");
	var sno = zim.find("input[name='sno']");
	var cid = zim.find("input[name='cid']");
	
	console.log(price.val());
	console.log(amount.val());
	console.log(sno.val());
	console.log(cid.val());
	
	var basketProduct = {
		cid:cid.val(),
		sno: sno.val(),
		bprice:price.val(),
		bamount:amount.val()
	};
    
	$.ajax({ 
		//전송유형
		type: 'post', 
		//컨트롤러 메소드 호출 URL
		url: '/board/basket', 
		//브라우저가 서버에게 보내는 데이터유형
		//data 키에 설정되는 값은 컨트롤러 메소드의 consumes 속성 설정 값의 데이터유형과 일치
		data: JSON.stringify(basketProduct), 
		//서버에게 보내는 데이터 유형(MIME 타입)
		contentType: "application/json; charset=utf-8", 
		//xhr(XML Http Request)
		beforeSend: function(xhr){
	    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	    },
		success: function(result, status, xhr){ 
			alert("장바구니에 추가됐습니다.");
		}
	})
	
});

</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>

