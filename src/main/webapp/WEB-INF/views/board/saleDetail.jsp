<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>
<script src="https://kit.fontawesome.com/3929e16ef5.js"></script>

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
   border-color: LightGreen;
   background-color:rgba(211, 211, 211, 0.2);
}
	
	.chat div{
		margin-bottom: 7px;
		
	}
	
	.h_container{
	    background-color: #cac7c7;
	    border-radius: 20px;
	    box-shadow: 0 2px 8px rgba(0,0,0,.1);
	    display: inline-block;
	    width:35px;
	    height:35px;
	    text-align:center;
	    line-height:45px;
		color: red;
	}
	#heart{
		
	    font-size: 25px;
	}
	#heart:hover{
	    color:red;
	}

	.bigPictureWrapper {
		position: fixed;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background: rgba(255, 255, 255, 0.5);
	}
	
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		width: 700px;
		/* height: 100%; */
		max-width: 100%;
		/* width: auto; */
		overflow: hidden;
	} 
	
	ul {
		width: 100%px;
	} 
	
	ul li {
		width: 100%px;
	} 
	
	.page ul li {list-style-type: none; float: left;}
	
	.page-item.active .page-link {
	    z-index: 3;
	    color: #fff;
	    background-color: green;
	    border-color: green;
	}
	
	.page-link {
	    color: green;
	}
</style>
	
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active"><a href="/board/saleBoard">판매게시판</a></li>
	  </ol>
	</nav>
	
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberVO" var="memberVO"/>
	</sec:authorize>
	
	<section class="d-flex align-items-center justify-content-center">
		<div class="container">
			<div class="basket row">
				<div class="col-md-6">
					<div id="${sale.sno }">
						
						<!-- 썸네일 이미지 표시 -->
						
					</div>
				</div>		
				<div class="col-md-6">
					<span style="font-size: 33px;"><c:out value="${sale.stitle }"></c:out></span>
					<button id='doZim' type="button" style="border: 0; outline: 0; color: red; background-color: white;">
						<div class="h_container">
							<i id="heart" class="far fa-heart"></i>
						</div>
					</button>
					<sec:authorize access="isAuthenticated()">
           				<c:if test="${sale.vid==memberVO.vid }">
							<a href="/board/saleModify?sno=${sale.sno }" class="btn btn-success" style="background-color: #009970;">수정</a>
							<a href="/board/saleDelete?sno=${sale.sno }" class="btn btn-danger">삭제</a>
						</c:if>
					</sec:authorize>	
					<hr>
					<div class="form-group">
              			<label><b>------ 가격</b></label><br>
              			<span style="font-size: x-large;"><fmt:formatNumber value="${sale.sprice }" pattern="###,###"/> 원</span>
              			<input type="hidden" name='price' value='${sale.sprice }'>
            		</div>      
            		<div class="form-group">
              			<label><b>------ 남은 수량</b></label><br>
              			<span style="font-size: x-large;"><fmt:formatNumber value="${sale.samount }" pattern="###,###"/> 개</span>
              			<input type="hidden" value='${sale.samount }'>
            		</div>
					<div class="form-group">
					<label><b>------ 구매 수량</b></label><br>
              			<input style="width: 20%; margin-right: 10px;" class="form-control" type="number" name='amount' value="1" min="0"><br>
              			<sec:authorize access="hasAnyRole('ROLE_CLIENT','ROLE_VENDOR')">
            			<button style="margin-right: 5px;" id='moveBasket' type="button" class="btn btn-outline-success" style="color: #009970;">장바구니</button>
						<a href="" class="btn btn-success" style="background-color: #009970;" onclick="javascript:window.open('/chat?vid=${sale.vid}','new','left=50, top=50, width=600, height=800')">판매자와 연락하기</a>           				
            			</sec:authorize>
            		</div>
            		<sec:authorize access="isAnonymous()">
            			<p style="color: gray;"><b>* 회원이 아닐 경우 채팅 기능과 장바구니 기능이 활성화 되지 않습니다.<br>&nbsp;&nbsp;&nbsp;채팅으로 문의를 원하신다면 가입을 진행해주세요.</b></p>
					</sec:authorize>
					<div class="form-group">
              			<label><b>------ 상세 설명</b></label>
              			<pre style='white-space: pre-wrap;'> ${sale.sinfo }</pre> 
            		</div>
				</div>		
				<input type="hidden" name='clientId' value='${memberVO.cid }'>
				<input type="hidden" name='sno' value='${sale.sno }'>
			</div><!-- row close -->
		</div> <!-- container close -->
		
	</section>
	
	<hr class="my-hr3">
	
	<section>
		<div class="container" style="align-items: center;">
			<div class="attachImage row" style="width: 780px;">
				
			</div>
		</div>		
	</section>
	
	<%-- <section>
		<div class="container">
			<c:set var="rstar" value="${countRstar }"/>
			<c:out value="${rstar[0].RSTAR}"></c:out>
			<c:forEach var="i" begin="1" end="5" step="1">
				
				 
			</c:forEach>
		</div>
	</section> --%>
	
	<section>
		<div class="container" style="align-items: center;">
			<div style="width: 1100px;">
				<div style="width: 100%;" class="text-right"><div><input type="button" class="replyWrite btn btn-success" style="background-color: #009970;" value="댓글 작성"/></div></div>
				<ul class="chat" style="list-style:none; width: 100%;"><!--  start reply -->
					
	    		</ul><!-- ./ end ul -->		
	    		<div class="panel-footer" id="replyPagingNum">
	    		
	    		</div><!-- /.end panel-footer -->	
			</div>
		</div>		
	</section>
	
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		
		</div>
	</div>
			
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
	
	<%-- beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	 		},
	      
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}"; --%>
	
<script type="text/javascript" src="/resources/customjs/basket.js"></script>
<script type="text/javascript" src="/resources/customjs/customReply.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">



var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var _cid = '<c:out value="${memberVO.cid}"></c:out>'; 

$(document).ajaxSend(function(e, xhr, options) {
   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
})
	/* 썸네일 이미지 디테일의 좌상단 이미지 */
	$(document).ready(function() {
		(function() {
			
			var snoStr = '<c:out value="${sale.sno }"/>';
	
			$.getJSON("/board/getThumbList", {snoStr: snoStr}, function(arr) {
	
				var str = "";
				
				$(arr).each(function(i, attach) { 
					
						
					var fileCallPath = encodeURIComponent(attach.stuploadPath + "/" + attach.stuuid + "_" + attach.stfileName);
					
					str = "<div data-path='" + attach.stuploadPath + "' data-uuid='" + attach.stuuid + "' data-filename='" + attach.stfileName + "' data-type='" + attach.stfileType + "'>"
						+  "	<div>"
						+  "		<img  style='width: 100%; height: 100%;' src='/display?fileName=" + fileCallPath + "'>"
						+  "	</div>"
						+  "</div>";
						
					$("#" + attach.sno).prepend(str);
				});
				
			}); //end getJSON
			
		})();
	});
	
	/* 메인 이미지 */
	$(document).ready(function() {
		(function() {
			
			var snoStr = '<c:out value="${sale.sno }"/>';
			
			$.getJSON("/board/getImageList", {sno: snoStr}, function(arr) {
				
				var str = "";
				
				$(arr).each(function(i, attach) { 
						
					var fileCallPath = encodeURIComponent(attach.suploadPath + "/" + attach.suuid + "_" + attach.sfileName);
					
					str = "<div data-path='" + attach.suploadPath + "' data-uuid='" + attach.suuid + "' data-filename='" + attach.sfileName + "' data-type='" + attach.sfileType + "'>"
						+  "	<div>"
						+  "		<img  style='width: 100%; height: 100%;' src='/display?fileName=" + fileCallPath + "'>"
						+  "	</div>"
						+  "</div>";
						
					$(".attachImage").append(str);
				});
				
			}); //end getJSON
		})();
	});
	
	var snoValue = '<c:out value="${sale.sno}"/>';
  	var replyUL = $(".chat");
  
	 
	function showList(page){
		 
		 console.log("show list " + page);
	    
		 replyService.getList({sno:snoValue,page: page|| 1 }, function(replyCnt, list, replyImgVO) {
		     
			 console.log("data.replyImgVO: " + replyImgVO);
	       	 console.log("replyCnt: "+ replyCnt );
	       	 console.log("list: " + list);
	        
	      	 if(page == -1){
	         	pageNum = Math.ceil(replyCnt/10.0);
	       	 	showList(pageNum);
	       	 	return;
	       	 }
		    	
		     var str="";
		     
		     if(list == null || list.length == 0){
		    	 replyUL.html("<li style='text-align: center'>댓글이 존재하지 않습니다.</li>");
		      	 return;
		     }
		     
		     for (var i = 0, len = list.length || 0; i < len; i++) {
			    str += "<li style='width:100%;' class='left clearfix' data-rno='"+list[i].rno+"'>"
			       	 + "  <div style='width:100%;'>"
			       	 + "    <span class='primary-font'>"+list[i].rwriter+"</span>"
			       	 + "	<div style='color:orange;'>";
			       	 
				for (var j = 0; j < 5; j++) {
					if(j < list[i].rstar) {
						str += "<i class='fas fa-star'></i>";	
					} else {
						str += "<i class='far fa-star'></i>";
					}
				}
			       	 
			    str += " 	</div>"   	 
			    	 + "    <div style='width:100%;' class='header d-flex img" + list[i].rno + "'>"
  			       	 + "    </div>"
  			       	 + "    <pre style='white-space: pre-wrap;'>"+list[i].rcontent+"</pre>";
  			       	 
  			    if (list[i].rwriter == _cid) {
  			    	str += "	<a class='btn btn-success' style='background-color:#009970;' href='/replies/replyModify?sno=${sale.sno}&rno="+ list[i].rno +"'>수정</a>"
  			    		+ "		<a class='btn btn-outline-success' style='color:#009970;' onclick='deleteCheck()' href='/replies/replyDelete?sno=${sale.sno}&rno="+ list[i].rno +"'>삭제</a>";
				}   	 
  			       			 
				str += "  </div>"
			       	 + "</li>"
			       	 + "<hr>";
			       	 
		     }
		     
		     replyUL.html(str);
		     
		     if (replyImgVO != null) {
	    	 	for (var i = 0, imgLen = replyImgVO.length || 0; i < imgLen; i++) {
						
					var fileCallPath = encodeURIComponent(replyImgVO[i].ruploadPath + "/s_" + replyImgVO[i].ruuid + "_" + replyImgVO[i].rfileName);
					str =  "<div class='uploadResult'>"					
					 	+  "	<div class='imagePath' data-path='" + replyImgVO[i].ruploadPath + "' data-uuid='" + replyImgVO[i].ruuid + "' data-filename='" + replyImgVO[i].rfileName + "' data-type='" + replyImgVO[i].rfileType + "'>"
						+  "			<img style='width: 90px; height:90px;' src='/display?fileName=" + fileCallPath + "'>"
						+  "	</div>"
						+  "</div>";
						
					$(".img" + replyImgVO[i].rno).append(str);
			 	}	
			 }
		     
		     showReplyPage(replyCnt);
	 
	    });//end function    
	 }//end showList
	
	 function deleteCheck() {
		
		 var message = confirm("삭제하시겠습니까?");

			if(message == true){

				return true;
			}else{
				
				event.preventDefault();
				return false;
			}
		 
	}
	 
	 var pageNum = 1;
	   var replyPageFooter = $("#replyPagingNum");
	   var pagingNumCnt = 10; //표시되는 페이징 번호의 개수
	    
	       function showReplyPage(replyCnt){ //특정 게시물의 댓글 개수를 매개변수 replyCnt(매개변수)로 받음
	            
	          //끝 페이지 번호 : 아래에서 10.0과 10은 표시되는 페이징 번호의 개수
	            var endNum = Math.ceil(pageNum / (pagingNumCnt * 1.0)) * 10;  
	           //시작 페이지 번호 : 아래에서 -9는 페이징번호 개수가 10일때 (10-1)한 값
	          var startNum = endNum - (pagingNumCnt - 1);
	      		
	            var prev = startNum != 1;
	            var next = false;
	      
	            if(endNum * 10 >= replyCnt){ //10은 표시되는 페이징 번호 개수
	             endNum = Math.ceil(replyCnt / (pagingNumCnt*1.0)); 
	            //10.0은 표시되는 페이지 번호의 개수
	            }
	      
	            //next = endNum * 10 < replyCnt;
	           if(endNum * 10 < replyCnt){
	              next = true;
	            }
	      
	            var str = "<div class='page'><ul class='pagination pull-right'  style='display: table; margin-left: auto; margin-right: auto;'>";
	      
	            if(prev){
	              str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>이전</a></li>";
	            }
	      
	            for(var i = startNum ; i <= endNum; i++){
	              //부트스트랩의 클래스 이름.
	              
	              var active = pageNum == i? "active":"";
	        
	              str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	              
	            }
	      
	            if(next){
	              str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>다음</a></li>";
	            }
	      
	            str += "</ul></div>";
	      
	            //console.log(str);
	      
	            replyPageFooter.html(str);
	       }
  
		//페이징 번호 클릭 시 새로운 댓글 목록을 가지고오기
		//이벤트 전파기능 이용
	 	replyPageFooter.on("click","li a", function(e){
		    e.preventDefault();
		    //console.log("page click");
		    
		    var targetPageNum = $(this).attr("href");
		    
		    //console.log("targetPageNum: " + targetPageNum);
		    
		    pageNum = targetPageNum;
		    
		    showList(pageNum);
		});      
	 
	$(document).ready(function() {
		 
		 showList(1);
	});
	
	var basket = $(".basket");
	var price = basket.find("input[name='price']");
	var amount = basket.find("input[name='amount']");
	var sno = basket.find("input[name='sno']");
	var cid = '<c:out value="${memberVO.cid}"></c:out>'
	var vid = '<c:out value="${memberVO.vid}"></c:out>';
	
	$("#moveBasket").on("click",function(e){
		
         if (vid != '') {

             alert("개인 회원만 이용 가능합니다.");
			 return;
         }
         
         if (cid == '') {

             alert("로그인 후 사용이 가능합니다.");
			 return;
         }
		
		var basketProduct = {
			cid:cid,
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
				//callback 매개변수에 함수가 있으면 참, 없으면 거짓
				alert("장바구니에 추가됐습니다.");
			}
		})
		
	});
	
	$("#doZim").on("click",function(e){
		
		if (vid != '') {

            alert("개인 회원만 이용 가능합니다.");
			 return;
        }
        
        if (cid == '') {

            alert("로그인 후 사용이 가능합니다.");
			 return;
        }
		
		
		var zimProduct = {
			cid:cid,
			sno: sno.val()
		};
	    
		$.ajax({ 
			type: 'post',
			async:false,
			url: '/board/doZim', 
			data: JSON.stringify(zimProduct), 
			contentType: "application/json; charset=utf-8",
			dataType:"json",
			beforeSend: function(xhr){
		    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    },
			success: function(result, status, xhr){ 
				if(result == 1) {
					var str = '<i id="heart" class="fas fa-heart"></i>';
					$(".h_container").html(str);
					alert("찜 목록에 추가 되었습니다.");
				} else {
					var str = '<i id="heart" class="far fa-heart"></i>';
					$(".h_container").html(str);
					alert("찜 목록에 제거 되었습니다.");
				}
			}
		})

	});
	
	$(".replyWrite").on('click', function(e){
		
		if (vid != '') {

            alert("개인 회원만 작성 가능합니다.");
			return;
        }
		
		if (cid == '') {

            alert("로그인 후 사용이 가능합니다.");
			return;
        }
		
		
		
		 location.href="/replies/replyRegister?sno=${sale.sno }";
		
	});

	
	$(document).on('click', '.imagePath', function(e){
		
		console.log("view image");
		
		var liObj = $(this);
		
		var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
		
			
		showImage(path.replace(new RegExp(/\\/g), "/"));

	});
	
	function showImage(fileCallPath) {
		
		/* alert(fileCallPath); */
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName=" + fileCallPath + "'>");
		/* .animate({width:'100%', height: '100%'}, 0); */
	}
	
	$(".bigPictureWrapper").on("click", function(e) {
		
		/* $(".bigPicture").animate({width:'0%', height: '0%'}, 0); */
		
		setTimeout(function() {
			
			$(".bigPictureWrapper").hide();
		}, 0);
	})
	
	/* 디자인  */
	$(document).ready(function() {
	    
		var zimProduct = {
			cid:cid,
			sno: sno.val()
		};
		
		$.ajax({ 
			type: 'post',
			async:false,
			url: '/board/checkZim', 
			data: JSON.stringify(zimProduct), 
			contentType: "application/json; charset=utf-8",
			dataType:"json",
			beforeSend: function(xhr){
		    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    },
			success: function(result, status, xhr){ 
				
				
				if(result == 1) {
					var str = '<i id="heart" class="fas fa-heart"></i>';
					$(".h_container").html(str);
				} else {
					var str = '<i id="heart" class="far fa-heart"></i>';
					$(".h_container").html(str);
				}
			},
			error: function() {
				alert("asd");
			}
		})

	});
	
</script>
<%@include file="/WEB-INF/views/include/footer.jsp" %>


