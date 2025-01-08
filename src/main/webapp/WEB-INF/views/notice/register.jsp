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
<section id="notice" class="d-flex align-items-center">	
    <div class="container position-relative" data-aos="fade-in" data-aos-delay="200">
    
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>게시글 작성</h2>
            </div>
          </div><!-- End col-lg-4 -->
        </div><!-- End row -->

        <div class="row">
			<div class="col-sm-12">
			
		<form id="frmRegister" action="/notice/register" method="post">
			<div class="form-group">
				<!-- <h5><label>제목</label></h5> -->
				<input class="form-control" name='ntitle' placeholder="제목">
			</div>
			
			<div class="form-group">
				<!-- <h5><label>내용</label></h5> -->
				<textarea class="form-control" rows="10" name='ncontent' placeholder="내용"></textarea>
			</div>
			<div class="form-group">
				<!-- <h5><label>작성자</label></h5> --><!-- ////////////작성자를 따로 로그인한 admin으로 올수있게 수정 -->
				<input class="form-control" name='nwriter' value='${memberVO.cid }' readonly="readonly">
			</div>    

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
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			
			<button type="submit" id="btnSubmit" class="btn btn-success" style="background-color:#009970">등록</button>
			<button type="reset" class="btn btn-outline-success" style="color:#009970">다시입력</button>
			<button type="button" id="btnList" class="btn btn-success" onclick="location.href='/notice/list'">글목록</button>  
		</form>
		</div>
  		
  		</div><!-- /.row -->
  	</div><!-- End container -->
</section><!-- End about Section -->  	

</main><!-- End #main -->

<script type="text/javascript">

var frmRegister = $("#frmRegister");


//지영
//첨부파일 버튼동작
$("#btnSubmit").on("click", function(e){
	e.preventDefault();
	console.log("submit clicked");
	var str = "<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>";

 	$(".uploadResult ul li").each(function(i, obj){
		var jobj = $(obj);
		console.dir(jobj); 
		str += "<input type='hidden' name='noticeAllAttach[" + i + "].nfileName' value='"+ jobj.data("filename")+"'>";
		str += "<input type='hidden' name='noticeAllAttach[" + i + "].nuuid' value='"+ jobj.data("uuid")+"'>";
		str += "<input type='hidden' name='noticeAllAttach[" + i + "].nuploadPath' value='"+ jobj.data("path")+"'>";
		str += "<input type='hidden' name='noticeAllAttach[" + i + "].nfileType' value='"+ jobj.data("type")+"'>";
	});
	
	frmRegister.append(str).submit();
	//alert("str : " + str);
});

//지영
//페이징 고려
$("#btnList").on("click", function(e) {
	operForm.find("#nno").remove();
	operForm.attr("action","/notice/list").submit(); 
});

//지영
//파일업로드시 고려사항
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

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

console.log("token의 값 ---> " + token);
console.log("header의 값 ---> " + header);

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

console.log("csrfHeaderName의 값 ---> " + csrfHeaderName);
console.log("csrfTokenValue의 값 ---> " + csrfTokenValue);

//지영
//파일 업로드	
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
        data: formData, 
        type: 'POST',
        dataType:'json',
         beforeSend: function(xhr){
	    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	      },
        success: function(result){
        	alert("첨부파일 업로드가 완료되었습니다.");
			console.log(result);
            showUploadResult(result); //업로드 결과 처리 함수
		},error : function(request,status,error) {
	          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	     }
	});	//END ajax
});//END change function

function showUploadResult(uploadResultArr){
	if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	var uploadUL = $(".uploadResult ul");
	var str ="";
	$(uploadResultArr).each(function(i, obj){
		
		if(obj.image){
			var fileCallPath = encodeURIComponent( obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
            
			str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='I'>";
            str += "	<div>";
            str += "		<img src='/display?fileName=" + fileCallPath + "' width='100%', height='100%'>";
            /* str += "		<span> " + obj.fileName + "</span>"; */
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
//파일삭제
$(".uploadResult").on("click", "button", function(e){
	console.log("delete file");
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	var targetLi = $(this).closest("li");
	$.ajax({
		url : '/deleteFile',
		data : {fileName:targetFile, type:type},
		dataType : 'text',
/* 		beforeSend: function(xhr){
	    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	      }, */
		type : 'POST',
		success : function(result){
        	alert(result);
			targetLi.remove();
		}
	});//END ajax
})//END function uploadResult

</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>