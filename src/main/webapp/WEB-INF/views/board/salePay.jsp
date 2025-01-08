<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp" %>
	
<style>

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

ul{
   list-style:none;
   display:inline=block;
   li{ 
   		float:left;
   		left:-100px;
   	  }
   }
.container pro{
	text-align:center;
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
	
	<section class="d-flex align-items-center justify-content-center" style="padding-bottom: 20px; overflow: hidden;">
		<div class="container">
     	    <div class="row">
	          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
	            <div class="section-title">
	              <h2>결제페이지</h2>
	            </div>
	          </div><!-- End col-lg-4 -->
	       </div><!-- END row -->
	     </div>
	 </section> 
	
	
	<section class="d-flex align-items-center justify-content-center" style="padding: 0 0 0 500px; overflow: hidden;">
     <div class="container pro">
          <ul class="progressbar">
            <li class="active">장바구니</li>
            <li class="active">결제페이지</li>
          </ul>
      </div>
	</section>	
	
	<section class="d-flex align-items-center justify-content-center" style="padding: 60px 0 60px 0; overflow: hidden;">
		<div class="container">
			<c:choose>
				<c:when test="${basketList != null}">
					<ul>
					<form name="pay" action="/board/pay" method="post">
						<c:forEach items="${basketList }" var="board">
						    <div class="container h-100">
						    <div class="d-flex justify-content-center align-items-center h-100" style="margin-bottom: 20px; width: 100%;">
						    	<div class="card" style="width:100%;">
						            <div class="row sno">
						            	<a style='width:100px; height:100px;' href="/board/saleDetail?sno=${board.SNO }">
											<div class="col-lg-2 img${board.SNO }">
											
											</div>
										</a>
						                <div class="col-lg-4 card-body">
						                	<%-- <a href="/board/saleDetail?sno=${board.sno }">
						                    	<h5 class="card-title">상품 : <c:out value="${board.stitle }"/></h5>
						                    </a> --%>
						                    <p class="card-text"><b>상품 :</b>  <c:out value="${board.STITLE }"/></p>
						                    <p class="card-text"><b>가격 :</b> <fmt:formatNumber value="${board.BPRICE }" pattern="###,###"/>원</p>
						                </div>
						                <div class="col-lg-4 card-body">
						                	<%-- <a href="/board/saleDetail?sno=${board.sno }">
						                    	<h5 class="card-title">상품 : <c:out value="${board.stitle }"/></h5>
						                    </a> --%>
						                    <p class="card-text"><b>개수 :</b> <c:out value="${board.BAMOUNT }"/></p>
						                    <p class="card-text"><b>총 가격 :</b> <fmt:formatNumber value="${board.BPRICE*board.BAMOUNT }" pattern="###,###"/>원</p>
						                </div>
						            </div>
								</div>
						    </div>
						</div>
						</c:forEach>
	    				<div style="padding: 20px;">
		    				<p style="width: 1050px; font-weight:bold; font-size:20px" class="totalPrice text-right" >
								총가격: <b><fmt:formatNumber value="${totalPrice }" pattern="###,###"/></b> 원
							</p>
	    				</div>
	    				<hr>
	    				<h2 style="color: lightgray;"><b> * 결제를 위해 배송 받을 주소와 전화번호를 입력해주세요.</b></h2>
                        <div style="align-content: center; padding:20px">
                        	<p><b>택배 위탁 주소</b></p>
					        <input class="intext" style="width:520px;" type="text" id="roadFullAddr" name="oaddress" placeholder="배송지를 정확히 입력해주세요.">
					        <input type="button" class="btn btn-success" style="background-color:#009970;" onClick="goPopup();" value="우편검색" />
		    				<br><br>
		    				<p><b>본인 명의 전화번호</b></p>
		    				<input id="phoneNumber" class="intext" type="text" name="ophone" placeholder="휴대폰 번호를 입력해주세요.">
		    				<input class="btn btn-success" style="background-color:#009970;" type="submit" id="pay" value="결제하기">
	    				</div>
	    				<div class="row text-center" style="width: 100%">
	    					
	    				</div>
	    				
	    				<input type="hidden" name="cid" value="${memberVO.cid}">
	    				<input type="hidden" name="totalPrice" value="${totalPrice }">
	    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    				</form>
    				</ul>
   				</c:when>
   				
				<c:otherwise>
   					<tr>
    					<td>존재하지 않습니다.</td>
   					</tr>
  				</c:otherwise>
  			</c:choose>	
			
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
					
					str = "<div data-path='" + attach.stuploadPath + "' data-uuid='" + attach.stuuid + "' data-filename='" + attach.stfileName + "' data-type='" + attach.stfileType + "'"
						+  "	<div>"
						+  "		<img style='width:100px; height:100px;' src='/display?fileName=" + fileCallPath + "'>"
						+  "	</div>"
						+  "</div>";
						
					$(".img" + attach.sno).prepend(str);
				});
				
			}); //end getJSON
		})();
	});
	
	$("#pay").on("click", function(e) {
		
		
		
		var form = document.pay;
		
		var oadd = form.roadFullAddr.value;
		var ophone = form.ophone.value;
		e.preventDefault();
		
		if (oadd =='') {
			
			alert("주소를 입력해주세요.");
			return;
		}
		
		if (ophone =='') {
			
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}
		
		form.submit();
		
	})
	
	$(document).on("keyup", "#phoneNumber", function() {
       $(this).val($(this).val().replace(/[^0-9]/g, "")
           .replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3")
           .replace("--", "-"));
   }); 
	
	 //국가 도로명주소 API
    //opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
    /* zdocument.domain = "abc.go.kr"; */
    function goPopup() {
        // 주소검색을 수행할 팝업 페이지를 호출합니다.
        // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        var pop = window.open("/juso/jusoPopup", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");

        // 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
    }


    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo) {
        // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
        $("#roadFullAddr").val(roadFullAddr);

    }
	
</script>
<%@include file="/WEB-INF/views/include/footer.jsp" %>