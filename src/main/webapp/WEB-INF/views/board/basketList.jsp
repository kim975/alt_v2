<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
<!--
.inbutton {
    width:100px;
    background-color: #ff0000;
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
   border-color: LightGreen;
   background-color:rgba(211, 211, 211, 0.2);
}
-->
ul{
   list-style:none;
   }
.container pro{
     width: 35%;
    position: absolute;
    z-index: 1;
    margin-top: 20px;
}
.progressbar{
  counter-reset: step;
}
.progressbar li{
  float: left;
  width: 200px;
  position: relative;
  text-align: center;
}
.progressbar li:before {
    content: counter(step);
    counter-increment: step;
    width: 40px;
    height: 40px;
    border: 2px solid #bebebe;
    display: block;
    margin: 0 auto 10px auto;
    border-radius: 50%;
    line-height: 27px;
    background: white;
    color: #bebebe;
    text-align: center;
    font-weight: bold;
    font-size: x-large;
    text-align: -webkit-match-parent;
    padding-top: 5px;
}
.progressbar li:after{
  content: '';
  position: absolute;
  width:100%;
  height: 3px;
  background: #979797;
  top: 15px;
  left: -50%;
  z-index: -1;
}
.progressbar li.active:before{
 border-color: #3aac5d;
 background: #3aac5d;
 color: white
}
.progressbar li.active:after{
 background: #3aac5d;
}
.progressbar li.active - li:after{
 background: #3aac5d;
}
.progressbar li.active - li:before{
border-color: #3aac5d;
background: #3aac5d;
color: white
}
.progressbar li:first-child:after{
 content: none;
}
</style>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active" aria-current="page">장바구니</li>
	  </ol>
	</nav>
	
	<section class="d-flex align-items-center justify-content-center" style="padding-bottom: 20px; overflow: hidden;">
		<div class="container">
     	    <div class="row">
	          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
	            <div class="section-title">
	              <h2>장바구니</h2>
	            </div>
	          </div><!-- End col-lg-4 -->
	       </div><!-- END row -->
	     </div>
	 </section> 
	
	<section class="d-flex align-items-center justify-content-center" style="padding: 20px 0 0 500px; overflow: hidden;">
     <div class="container pro">
          <ul class="progressbar">
            <li class="active">장바구니</li>
            <li>결제페이지</li>
          </ul>
      </div>
	</section>
	
	<section class="d-flex align-items-center justify-content-center">
		<div class="container">
			<c:choose>
				<c:when test="${basketList != null}">
					   <c:forEach items="${basketList }" var="board">
					    <div class="container h-100 content">
					    <div class="d-flex justify-content-center align-items-center h-100" style="margin-bottom: 20px; width: 100%;">
					    	<div class="card" style="width:100%;">
					            <div class="row sno">
					            	<a style='width:100px; height:100px;' href="/board/saleDetail?sno=${board.SNO }">
										<div class="col-lg-2 img${board.SNO }">
										
										</div>
									</a>
					                <div class="col-lg-5 card-body">
					                	<%-- <a href="/board/saleDetail?sno=${board.sno }">
					                    	<h5 class="card-title">상품 : <c:out value="${board.stitle }"/></h5>
					                    </a> --%>
					                    <p class="card-text"><b>상품</b> : <c:out value="${board.STITLE }"/></p>
					                    <p class="card-text"><b>가격 :</b> <fmt:formatNumber value="${board.BPRICE }" pattern="###,###"/>원</p>
					                </div>
					                <div class="col-lg-5 card-body">
					                	<%-- <a href="/board/saleDetail?sno=${board.sno }">
					                    	<h5 class="card-title">상품 : <c:out value="${board.stitle }"/></h5>
					                    </a> --%>
					                    <p class="card-text"><b>개수 :</b> <c:out value="${board.BAMOUNT }"/></p>
					                    <p class="card-text"><b>총 가격 :</b> <fmt:formatNumber value="${board.BPRICE*board.BAMOUNT }" pattern="###,###"/>원</p>
					                </div>
					                	<input style="width: 50px; height: 25px; padding: 0;" class="inbutton removeBasket" type="button" style="background-color:#009970;" onclick="deleteBasket(${board.BCODE})" value="X">
					            </div>
							</div>
					    </div>
					</div>
					</c:forEach>
   				</c:when>
   				
				<c:otherwise>
   					<tr>
    					<td>존재하지 않습니다.</td>
   					</tr>
  				</c:otherwise>
  			</c:choose>	
			<div class="totalPrice" style="float: right; margin: 15px; font-weight:bold; font-size:20px">
				<span>총 가격: <b><fmt:formatNumber value="${totalPrice }" pattern="###,###"/></b>원</span>
			</div>
			<div style="margin-top:80px; margin-right:10px;">
			<a class="btn btn-success" style="background-color:#009970; float: right;" href="/board/salePay?cid=${memberVO.cid }">결제하기</a>
			</div>
		</div>
	</section>
<script type="text/javascript" src="/resources/customjs/basket.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options) {
	   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
	})
	
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
	
	function deleteBasket(_bcode) {
		
		$.ajax({
			type:"delete",
			async: false,
			url:"/board/basket/" + _bcode,
			dataType:"text",
			data:{bcode: _bcode},
			success:function (data, textStatus) {
				
			},
			error:function (data,textStatus) {
				alert("에러가 발생했습니다.");
			}
		});
	} 
	
	$(".removeBasket").on("click", function(e) {
		
		var _cid = "${memberVO.cid}";
		
		console.log("delete file");
			
		$.ajax({
			type:"get",
			async: false,
			url:"/board/basketTotalPrice",
			dataType:"json",
			data:{cid: _cid},
			success:function (data, textStatus) {
				var price = AddComma(data);
				
				$('.totalPrice').text("총 가격: " + price + "원");
			},
			error:function (data,textStatus) {
				alert("에러가 발생했습니다.");
			}
		});
		
		var targetLi = $(this).closest(".content");
		targetLi.remove();
		
	});
	
	function AddComma(num)
	{
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
</script>
<%@include file="/WEB-INF/views/include/footer.jsp" %>