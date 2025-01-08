<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<section id="notice" class="contact">
    <div class="container position-relative" data-aos="fade-in" data-aos-delay="200">
    
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>게시글 수정</h2>
            </div>
          </div><!-- End col-lg-4 -->
        </div><!-- End row -->
			
		<div class="row justify-content-center">	
			<div class="col-sm-12">
			
<form id="frmModify" action="/notice/modify" method="post">
          	<div class="form-group">
          		<label>글번호</label> <input class="form-control" name='nno' value='<c:out value="${notice.nno }"/>' readonly="readonly">
        	</div>
        	
	        <div class="form-group">
	          <label>제목</label> <input class="form-control" name='ntitle' value='<c:out value="${notice.ntitle }"/>'>
	        </div>
	
	        <div class="form-group">
	          <label>내용</label>
	          <textarea class="form-control" rows="10" name='ncontent'><c:out value="${notice.ncontent}" /></textarea>
	        </div>
	
	        <div class="form-group">
	          <label>작성자</label> <input class="form-control" name='nwriter' value='<c:out value="${notice.nwriter }"/>' readonly="readonly">
	        </div> 
			
			<div class="form-group">
				<label>작성일</label> <input class="form-control" name='nwritedate' value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${notice.nwriteDate }"/>' readonly="readonly">
			</div>
				
			<div class="form-group">
				<label>수정일</label> <input class="form-control" name='nupdateDate' value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${notice.nupdateDate }"/>' readonly="readonly">
			</div>
			
			<!-- 수정/삭제 페이징 데이터 -->
			<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
			<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
			<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
			<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>

		<!-- 첨부파일 -->
	    <div class="col-lg-12">
	            <h5>File upload[파일첨부]</h5>
	               <div class="form-group uploadDiv">
	                  <input type="file" id="uploadFile" name='uploadFile' multiple>
	               </div><!-- END form-group uploadDiv-->
	               <div class='uploadResult'>
	                  <ul>
	                     <!-- 업로드 결과 표시 -->
	                  </ul>
				   </div><!-- END uploadResult-->
		</div><!-- END col-lg-12-->

						<button type="button" id="btnModify" data-oper="modify" class="btn btn-success" style="background-color:#009970">수정</button>
			<button type="button" id="btnRemove" data-oper="remove" class="btn btn-danger">삭제</button>
			<button type="button" id="btnList" data-oper="list" class="btn btn-info">글 목록</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
			</div>
  		</div><!-- /.row -->
  	</div><!-- End container -->
</section><!-- End about Section -->  	

</main><!-- End #main -->

<script type="text/javascript">

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ajaxSend(function(e, xhr, options) {
   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
});

var formObj = $("#frmModify");

//지영
//버튼동작
$('button').on("click", function(e) {
	e.preventDefault();
	
	var operation = $(this).data("oper");
	console.log("operation : " + operation);
	
	if(operation=="remove") {
		formObj.attr("action", "/notice/remove");
//		alert("글이 정상적으로 삭제되었습니다.");
	} else if(operation=="list") {
		formObj.attr("action", "/notice/list").attr("method","get");
		
 		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var typeTag = $("input[name='type']").clone();
		var keywordTag = $("input[name='keyword']").clone();
		
		formObj.empty();
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		formObj.append(typeTag);
		formObj.append(keywordTag); 
	} else if(operation=="modify"){
		console.log("modify submit clicked");
		var str = "<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>";
	 	$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj); 
			str += "<input type='hidden' name='noticeAllAttach[" + i + "].nfileName' value='"+ jobj.data("filename")+"'>";
			str += "<input type='hidden' name='noticeAllAttach[" + i + "].nuuid' value='"+ jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='noticeAllAttach[" + i + "].nuploadPath' value='"+ jobj.data("path")+"'>";
			str += "<input type='hidden' name='noticeAllAttach[" + i + "].nfileType' value='"+ jobj.data("type")+"'>";
		});
		formObj.append(str).submit();
//		alert("게시글을 정상적으로 수정했습니다.");
	}//END if
	formObj.submit();
});//END button

//지영
//첨부파일 추가
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880; //5MB

function checkExtension(fileName, fileSize){
  
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
  
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
  return true;
}//END checkExtention

//지영
//파일 업로드	
//$("input[type='file']").change(function(e){
$("#uploadFile").change(function(e){
	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;	
	
	for(var i = 0; i < files.length; i++){
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
		formData.append("uploadFile", files[i]);
	}//END for
   
	$.ajax({
		url: '/uploadAjaxAction',
        processData: false,
        contentType: false, 
        data:formData, 
        type: 'POST',
        dataType:'json',
        success: function(result){
        	alert("첨부파일 업로드가 완료되었습니다.");
			console.log(result);
			$(".uploadDiv #inputFile").val("");
            showUploadResult(result);
		}
	});	//END ajax
});//END change function

//지영
//파일존재여부확인
function showUploadResult(uploadResultArr) {
	if(!uploadResultArr || uploadResultArr.length==0) { return;}
	var uploadUL = $(".uploadResult ul");
	var str = "";
	$(uploadResultArr).each(function(i, obj){
		
		if(obj.image){
			var fileCallPath = encodeURIComponent( obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
            
			str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='I'>";
            str += "	<div>";        
            str += "		<img src='/display?fileName=" + fileCallPath + "'>";
/*             str += "		<span> " + obj.fileName + "</span>"; */
            str += "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
            str += "			<i class='fa fa-times'>x</i>";
            str += "		</button><br>";
            str += "	</div>";
            str += "</li>";
         } else {
            var fileCallPath = encodeURIComponent( obj.uploadPath + "/" + obj.uuid +"_" + obj.fileName);
            var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
            
            str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='F'>";
			str += "	<div>";
			str += "		<img src='/resources/assets/img/icon-attach.png' style='width:50px; height:50px;'>";
			str += "		<span> " + obj.fileName + "</span>";
			str += "		<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'>";
			str += "			<i class='fa fa-times'>x</i>";
			str += "		</button><br>";
			str += "	</div>";
			str += "</li>";
		}//END if
	});//END each function
	uploadUL.append(str);
}//END showUploadResult

//지영
//게시물 이미지 보여주거나 다운로드
$(".uploadResult").on("click","li img,span", function(e){
	console.log("view image");
    var liObj = $(this);
	var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	if(liObj.data("type")=="I" || liObj.data("type")==true){
		showImage(path.replace(new RegExp(/\\/g),"/"));
	} else {
		//download 
		self.location ="/download?fileName="+path
	}
	console.log("if문 : " + liObj.data);
});//END uploadResult

//지영
//다운로드된 원본이미지 표시 함수  
function showImage(fileCallPath){
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"' >")
		.animate({width:'100%', height: '100%'}, 1000);
}

$(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		}, 1000);
});

//지영
//파일삭제 
$(".uploadResult").on("click", "button", function(e){
	console.log("delete file");
	if(confirm("정말로 삭제하시겠습니까?")) {
		var targetLi = $(this).closest("li");
		targetLi.remove();
		alert("파일 삭제되었습니다.");
	}
});//END function uploadResult	

//지영
//첨부파일의 데이터를 가져옴
$(document).ready(function() {
		(function() {		
			var nno = '<c:out value="${notice.nno}"/>';
			$.getJSON("/notice/getAttachList", {nno:nno}, function(arr) {	
				console.log(arr);
				var str= "";
				$(arr).each(function(i, attach) {
					
					if(attach.nfileType == "I") {
						//var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						var fileCallPath = encodeURIComponent(attach.nuploadPath + "\\s_" + attach.nuuid + "_" + attach.nfileName);
						
						str += "<li data-path='" + attach.nuploadPath + "' data-uuid='" + attach.nuuid + "' data-filename='" + attach.nfileName + "' data-type='" + attach.nfileType + "'>";
						str += "		<div>";
						str += "			<img src='/display?fileName=" + fileCallPath + "'>";
						/* str += "			<span> " + attach.nfileName + "</span><br>"; */
						str += "			<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'>";
						str += "				<i class='fa fa-times'>x</i>";
						str += "			</button><br>";
						str += "		</div>";
						str += "</li>";
					} else {
						str += "<li data-path='" + attach.nuploadPath + "' data-uuid='" + attach.nuuid + "' data-filename='" + attach.nfileName + "' data-type='" + attach.nfileType + "'>";
						str += "		<div>";
						str += "		<img src='/resources/assets/img/icon-attach.png' style='width:50px; height:50px;'>";
						str += "			<span> " + attach.nfileName + "</span><br>";
						str += "			<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'>";
						str += "				<i class='fa fa-times'>x</i>";
						str += "			</button><br>";
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