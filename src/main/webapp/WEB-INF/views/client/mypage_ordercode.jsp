<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
	table{width:100%; auto; text-align:center; background-color:white;}
</style>
	
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/client/mypage">마이페이지</a></li>
	    <li class="breadcrumb-item"><a href="/client/mypage_orderlist?cid=${memberVO.cid}">내 주문 목록</a></li>
	    <li class="breadcrumb-item active" aria-current="page">주문 상세 내역</li>
	  </ol>
	</nav>
	
	<!-- ======= mypage Section ======= -->
<section id="mypage" class="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>주문 상세 내역</h2>
              <p>주문하신 물품 상세 내역입니다<br>만약 문의가 있다면 문의하기로 업체와 직접 커뮤니케이션 하세요.</p>
            </div>
          </div><!-- End col-lg-4 -->
       </div><!-- END row --> 
 <div style="text-align:right">
   <div style="font-weight: bold">주문번호: ${ocode }
   </div>
 </div>
 <!-- <div style="margin-bottom: 10px;">
                   <hr style="border: 0; height: 4px; background: #009970;"> -->
 <!-- </div> -->	
 <div class="row aos-init aos-animate" data-aos="fade-up" data-aos-delay="200">
 
	        <div class="col-lg-12 d-flex justify-content-center">
				<table class="table table-hover">
					<thead>
					    <tr>
					       	<th style= "border-top-color:#009970; border-top-width: thick;">상품번호</th>
					        <th style= "border-top-color:#009970; border-top-width: thick;">상품사진</th>
					        <th style=" border-top-color:#009970; border-top-width: thick;">상품명</th>
					        <th bgcolor="#EAEAEA" align=center style= "border-top-color:#009970; border-top-width: thick;">수량</th>
					        <th bgcolor="#EAEAEA" align=center style= "border-top-color:#009970; border-top-width: thick;">판매가</th>
					        <th style= "border-top-color:#009970; border-top-width: thick;">리뷰작성</th>
					        <th style=" border-top-color:#009970; border-top-width: thick;"><b>결제여부</b></th>
					    </tr>
					</thead>		
					<tbody>				
					 <c:forEach items="${ordlistproduct }" var="list">	
					 	<tr>	
							<td> <c:out value="${list.PCODE }"/>  </td>     
						    <%-- <td> <c:out value="${list.SNO }"/> </td> --%>	
						    <td> <div id="${list.SNO }"></div></td>
							<td> <a href="/board/saleDetail?sno=${list.SNO }" style="color:black; font-weight:bold;"> <c:out value="${list.STITLE }"/></a> </td>
							<td bgcolor="#EAEAEA" align=center> <c:out value="${list.OAMOUNT }"/> </td>				
						    <td bgcolor="#EAEAEA" align=center> <c:out value="${list.OPRICE }"/> </td>	
						    
						    <td> 
						    <c:if test="${list.OPPAY == 'Y'}">
						    	<a type="button" class="btn btn-outline-success btn-xs" href="/replies/replyRegister?sno=${list.SNO}">리뷰쓰기</a>
						    </c:if>
						    <c:if test="${list.OPPAY == 'N'}">
						    	<a type="button" class="btn btn-outline-danger btn-xs" onclick="fn_review()">결제 진행중</a>
						    </c:if>
						     </td>
						   	
                 			<c:if test="${list.OPPAY == 'N'}">
								<td style="color: red;"> <b>입금 대기</b> </td>
							</c:if>
							<c:if test="${list.OPPAY == 'Y'}">
								<td style="color: #009970;"> <b>결제 완료</b> </td>
							</c:if>
						  </tr>
						</c:forEach>
					</tbody>
               </table>
</div>
</div>
</div><!-- End container -->


      <div class="container">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h4><Strong>배송지 정보</Strong></h4>
            </div>
          </div><!-- End col-lg-4 -->
       </div><!-- END row --> 
       
        <div class="row">       
       <%-- <table class="table table-hover">
       	 <c:forEach items="${ordlistproduct }" var="list">
             <tr>
                 <th bgcolor="#EAEAEA" align=center style= "border-top-color:#009970; border-top-width: thick;"><b>주문자</b></th>
                 <td style= "border-top-color:#009970; border-top-width: thick;"><c:out value="${list.CID}"/></td>
             </tr>

             <tr>
                 <th bgcolor="#EAEAEA" align=center><b>배송지주소</b></th>
                 <td><c:out value="${list.OADDRESS}"/></td>
             </tr>

             <tr>
                 <th bgcolor="#EAEAEA" align=center><b>연락처</b></th>
                 <td><c:out value="${list.OPHONE}"/></td>
             </tr>
             <tr>
                 <th bgcolor="#EAEAEA" align=center><b>결제여부</b></th>
                 <c:if test="${list.opay == 'N'}">
					<td style="color: red;"> <b><c:out value="${list.OPAY }"/></b> </td>
				</c:if>
				<c:if test="${list.opay == 'Y'}">
					<td style="color: #009970;"> <b><c:out value="${list.OPAY }"/></b> </td>
				</c:if>
             </tr>
         </c:forEach>
       </table> --%>
       <table class="table table-hover">
             <tr>
                 <th bgcolor="#EAEAEA" align=center style= "border-top-color:#009970; border-top-width: thick;"><b>주문자</b></th>
                 <td style= "border-top-color:#009970; border-top-width: thick;"><%-- <c:out value="${ordlistproduct[0].CNAME}"/> --%><c:out value="${memberVO.cname}"/></td>
             </tr>

             <tr>
                 <th bgcolor="#EAEAEA" align=center><b>배송지주소</b></th>
                 <td><c:out value="${ordlistproduct[0].OADDRESS}"/></td>
             </tr>

             <tr>
                 <th bgcolor="#EAEAEA" align=center><b>연락처</b></th>
                 <td><c:out value="${ordlistproduct[0].OPHONE}"/></td>
             </tr>
             <tr>
                 
             </tr>
       </table>
		</div>
       </div>

</section><!-- End mypage -->


 <script>
 
 $(document).ready(function() {
		(function() {
			
			var snoList = '<c:out value="${snoList}"/>';
			
			$.getJSON("/board/getThumbList", {snoStr: snoList}, function(arr) {
	
				var str = "";
				
				$(arr).each(function(i, attach) { 
					
						
					var fileCallPath = encodeURIComponent(attach.stuploadPath + "/s_" + attach.stuuid + "_" + attach.stfileName);
					
					str = "<div data-path='" + attach.stuploadPath + "' data-uuid='" + attach.stuuid + "' data-filename='" + attach.stfileName + "' data-type='" + attach.stfileType + "'>"
						+  "	<div style='width: 100%; height: 150px'>"
						+  "		<img src='/display?fileName=" + fileCallPath + "'>"
						+  "	</div>"
						+  "</div>";
						
					$("#" + attach.sno).prepend(str);
				});
				
			}); //end getJSON
		})();
	});
 

 
 
//지영
// dropdown 메뉴가 보이기 직후에 호출되는 이벤트
$('.event-dropdown').on('shown.bs.dropdown', function () {
});

//지영
// dropdown 메뉴가 사라진 직후에 호출되는 이벤트
$('.event-dropdown').on('hidden.bs.dropdown ', function () {
});



</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>