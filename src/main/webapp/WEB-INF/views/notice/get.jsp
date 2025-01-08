<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>

<style>
	.uploadResult{ width:100%; background-color:#F0FFF0;}
	.uploadResult ul{ display:flex; flex-flow:column; justify-content:center; align-items:center;}
 	.uploadResult ul li{ list-style:none; padding:10px;}
	.uploadResult ul li img{ width:150px; height:150px;}
	.uploadResult ul li span{color:black;}
	.bigPictureWrapper {position:absolute; disply:none; justify-content:center; align-items:center;
						top:0%; width:100%; height:100%; backgeound-color:#F0FFF0; z-index:100; background:rgda(255,255,255,0.5);}
	.bigPicture {position:relative; display:flex; justify-content:center; align-items:center;}
	.bigPicture img {height:100%; max-width:100%; width:auto; overflow:hidden;}
</style> 

<main id="main">

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item"><a href="/notice/list">공지사항</a></li>
	  </ol>
	</nav>

   <!-- ======= notice Section ======= -->
<section id="notice" class="d-flex align-items-center">
    <div class="container position-relative" data-aos="fade-in" data-aos-delay="200">
    
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>게시글 상세</h2>
            </div>
          </div><!-- End col-lg-4 -->
        </div><!-- End row -->
        
		<div class="row justify-content-center">		
			<div class="col-sm-12">
			
	          	<div class="form-group">
	          		<!-- <label>글번호</label> --> <input class="form-control" name='nno' value='<c:out value="${notice.nno }"/>' readonly="readonly">
	        	</div>
	        	
		        <div class="form-group">
		          <!-- <label>제목</label> --> <input class="form-control" name='ntitle' value='<c:out value="${notice.ntitle }"/>' readonly="readonly">
		        </div>
		
		        <div class="form-group">
		          <!-- <label>내용</label> -->
		          <textarea class="form-control" rows="10" name='ncontent' readonly="readonly"><c:out value="${notice.ncontent}" /></textarea>
		        </div>
		
		        <div class="form-group">
		          <!-- <label>작성자</label> --> <input class="form-control" name='nwriter' value='<c:out value="${notice.nwriter }"/>' readonly="readonly">
		        </div> 
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">		
				<button type="button" id="btnModify" class="btn btn-success" style="background-color:#009970" onclick="location.href='/notice/modify?nno=<c:out value="${notice.nno }"/>'">수정</button>
			</sec:authorize>
			<button type="button" id="btnList" class="btn btn-success" onclick="location.href='/notice/list'">글목록</button> 
		
 		<form id="frmToModify" action="/notice/modify" method="get">
			<input type="hidden" id="nno" name='nno' value='<c:out value="${notice.nno }"/>'>
			<input type="hidden" id="pageNum" name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
			<input type="hidden" id="amount" name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
			<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
		</form>
		
			</div><!-- /.col-sm-12 -->
  		</div><!-- /.row -->
  		
<!-- 첨부파일 -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><!-- Files[파일] --></div><!-- /.panel-heading -->
            <div class="panel-body">
               	<div class="bigPictureWrapper"><!-- 이미지파일 표시되는 DIV -->
					<div class="bigPicture">
					</div>
				</div>
				<div class="uploadResult">
					<ul>
						<!-- 업로드 후 결과가 표시되는 화면 위치 -->
					</ul>
				</div><!-- END uploadResult-->
			</div><!-- END panel-body-->
		</div><!-- END panel panel-default-->
	</div><!-- END col-lg-12-->
</div><!-- END row-->	
  		
   </div><!-- /.container -->
</section><!--/.about  -->

</main><!-- End #main -->

<script type="text/javascript">

//지영
//게시글 동작처리
var frmToModify = $("#frmToModify");

//지영
//수정버튼
$("#btnModify").on("click", function(e) {
	operForm.attr("action","/notice/modify").submit();
});

//지영
//페이징 고려
$("#btnModify").on("click", function(e) {
	operForm.find("#nno").remove();
	operForm.attr("action","/notice/list").submit(); 
});

//지영
//첨부파일
//게시물 이미지 보여주거나 다운로드
$(".uploadResult").on("click","li", function(e){
	console.log("view image");
    var liObj = $(this);
	var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	if(liObj.data("type")=="I"){
		showImage(path.replace(new RegExp(/\\/g),"/"));
	} else {
		self.location ="/download?fileName="+path
	}
});//END uploadResult

//지영
//다운로드된 원본이미지 표시 함수  
function showImage(fileCallPath){
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"' >")
		.animate({width:'300px', height: '300px'}, 1000);
}

$(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		}, 1000);
});

//지영
//첨부파일의 데이터를 가져옴(즉시실행 함수로 처리)
$(document).ready(function() {
	(function() {		
		var nno = '<c:out value="${notice.nno}"/>';
		$.getJSON("/notice/getAttachList", {nno:nno}, function(arr) {	
			console.log(arr);
			var str= "";
			$(arr).each(function(i, attach) {
				
				console.log("if문 : " + attach.nfileType);
				if(attach.nfileType == "I") {
					//var fileCallPath = encodeURIComponent(attach.nuploadPath + "/s_" + attach.nuuid + "_" + attach.nfileName);
					var fileCallPath = encodeURIComponent(attach.nuploadPath + "\\s_" + attach.nuuid + "_" + attach.nfileName);
					
					str += "<li data-path='" + attach.nuploadPath + "' data-uuid='" + attach.nuuid + "' data-filename='" + attach.nfileName + "' data-type='" + attach.nfileType + "'>";
					str += "		<div>";
					str += "			<img src='/display?fileName=" + fileCallPath + "' width='100%', height='100%'>";
					str += "		</div>";
					str += "</li>";
				} else {
					str += "<li data-path='" + attach.nuploadPath + "' data-uuid='" + attach.nuuid + "' data-filename='" + attach.nfileName + "' data-type='" + attach.nfileType + "'>";
					str += "		<div>";
					str += "		<img src='/resources/assets/img/icon-attach.png' style='width:50px; height:50px;'>";
					str += "			<span> " + attach.nfileName + "</span><br>";
					str += "		</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});//END getJSON
	})();//END 반모듈화(변수에 담지않음)된 function
});//END document function

</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>