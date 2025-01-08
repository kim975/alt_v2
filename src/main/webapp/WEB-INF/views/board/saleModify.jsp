<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/include/header.jsp" %>

<style type="text/css">
	.uploadResult{ width:100%; background-color:gray;}
	.uploadResult ul{ display:flex; flex-flow:column; justify-content:center; align-items:center;}
 	.uploadResult ul li{ list-style:none; padding:10px;}
	.uploadResult ul li img{ width:20px;}
	.uploadResult ul li span{color:white;}
	.bigPictureWrapper {position:absolute; disply:none; justify-content:center; align-items:center;
						top:0%; width:100%; height:100%; backgeound-color:gray; z-index:100; background:rgda(255,255,255,0.5);}
	.bigPicture {position:relative; display:flex; justify-content:center; align-items:center;}
	.bigPicture img {width:600px;}
	
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

ul{
   list-style:none;
}
	
</style>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active"><a href="/board/saleBoard">판매게시판</a></li>
	  </ol>
	</nav>

<main id="main">
 
   <!-- ======= about Section ======= -->
<section id="titleSection" class="d-flex align-items-center">
    <div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="200">
        <div class="row">
        	<div class="col-sm-12">
				<h1>상품 등록</h1>
			</div><!-- End col-sm-12-->
  		</div><!-- /.row -->
  	</div><!-- End container -->
</section><!-- End titleSection -->
  
<section id="about" class="d-flex align-items-center">	
    <div class="container">
  	  <form id="frmRegister" action="/board/saleModify" method="post">
    	    <div class="row">
    	    	<div class="col-lg-12">
  	  				<button type="submit" id="btnSubmit" class="btn btn-success" style="background-color:#009970;">수정</button>
					<button type="reset" class="btn btn-outline-success" style="color:#009970;">다시입력</button>
					<a id="btnList" class="btn btn-danger" href="/board/saleDetail?sno=${sale.sno }">취소</a>
				</div>
        		<div class="col-lg-6">
					<h5>썸네일</h5>
					
					<div class='thumbUploadResult uploadImage' style="border: 1px solid black; height: 400px;">
						<ul>
						
	                     <!-- 업로드 결과 표시 -->
	                     
						</ul>
				   </div><!-- END uploadResult-->
				   <div class="form-group uploadDiv">
						<input type="file" id="thumbUploadFile" name='thumbUploadFile'>
				   </div><!-- END form-group uploadDiv-->
        		</div>
				<div class="col-lg-6">
					<div class="form-group">
						<h5><label>제목</label></h5>
						<input id="stitle" class="form-control" name='stitle' value="${sale.stitle }">
					</div>
					<div class="form-group">
						<h5><label>품목</label></h5>
						<select name="pcode">
							<c:forEach items="${product }" var="product">
								<option value="${product.pcode }">${product.pname }</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<h5><label>재고 수량</label></h5>
						<input id="samount" type="number" min="0" class="form-control" name='samount' value='${sale.samount }' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					</div>
					<div class="form-group">
						<h5><label>가격</label></h5>
						<input id="sprice" type="number" min="0" class="form-control" name='sprice' value='${sale.sprice }' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					</div>	
				</div>
				<div class="col-lg-12">
					<div class="form-group">
						<h5><label>설명</label></h5>
						<textarea  id="sinfo" class="form-control" rows="10" name='sinfo'>${sale.sinfo }</textarea>
					</div>
				</div>
				<input type="hidden" name="sno" value="${sale.sno }">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  		</div><!-- /.row -->
  		</form>
  	</div><!-- End container -->
</section><!-- End about Section -->  	
<!-- 첨부파일 -->

<section id="fileUpload" class="d-flex align-items-center">	
<div class="container text-center position-relative">
	<div class="row">
	    <div class="col-lg-12">
	            <h5>상세 설명 이미지</h5>
	               <div class="form-group uploadDiv">
	                  <input type="file" id="uploadFile" name='uploadFile' multiple>
	               </div><!-- END form-group uploadDiv-->
	               <div class='attachImage uploadImage'>
	                  <ul>
	                     <!-- 업로드 결과 표시 -->
	                  </ul>
				   </div><!-- END uploadResult-->
		</div><!-- END col-lg-12-->
	</div><!-- END row-->
</div><!-- End container -->
</section><!-- End fileUpload  -->

</main><!-- End #main -->

<script type="text/javascript">

var frmRegister = $("#frmRegister");

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ajaxSend(function(e, xhr, options) {
   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
})

$("#btnSubmit").on("click", function(e){
	
	e.preventDefault();
	
	var _stitle = $("#stitle").val();
	var _sprice = $("#sprice").val();
	var _samount = $("#samount").val();
	var _sinfo = $("#sinfo").val();
	
	if (_stitle.length == 0 || _stitle == "") {

	    alert("제목을 적어주세요");
	    return false;

	}  else if (_samount.length == 0 || _samount == "") {

		alert("수량을 적어주세요");
	    return false;

	} else if (_sprice.length == 0 || _sprice == "") {

		alert("가격을 적어주세요");
	    return false;
	} else if (_sinfo.length == 0 || _sinfo == "") {

		alert("설명을 적어주세요");
	    return false;

	}
	
	console.log("submit clicked");
	var str = "";
	
	$(".thumbUploadResult ul li").each(function(i, obj){
		var jobj = $(obj);
		console.dir(jobj); 
		str += "<input type='hidden' name='thumbImg.stfileName' value='"+ jobj.data("filename")+"'>";
		str += "<input type='hidden' name='thumbImg.stuuid' value='"+ jobj.data("uuid")+"'>";
		str += "<input type='hidden' name='thumbImg.stuploadPath' value='"+ jobj.data("path")+"'>";
		
	});
	
 	$(".attachImage ul li").each(function(i, obj){
		var jobj = $(obj);
		console.dir(jobj); 
		str += "<input type='hidden' name='attachList[" + i + "].sfileName' value='"+ jobj.data("filename")+"'>";
		str += "<input type='hidden' name='attachList[" + i + "].suuid' value='"+ jobj.data("uuid")+"'>";
		str += "<input type='hidden' name='attachList[" + i + "].suploadPath' value='"+ jobj.data("path")+"'>";
	});
	
	frmRegister.append(str).submit();
});

//페이징 고려
$("#btnList").on("click", function(e) {
	operForm.find("#nno").remove();
	operForm.attr("action","/notice/list").submit(); 
});


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

//썸네일 업로드	
$("#thumbUploadFile").change(function(e){
	var formData = new FormData();
	var inputFile = $("input[name='thumbUploadFile']");
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
        beforeSend: function(xhr){
        	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function(result){
			console.log(result);
            showThumbUploadResult(result); //업로드 결과 처리 함수
		}
	});	//END ajax
});//END change function

function showThumbUploadResult(uploadResultArr){
	if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	var uploadUL = $(".thumbUploadResult ul");
	var str ="";
	$(uploadResultArr).each(function(i, obj){
		
		var fileCallPath = encodeURIComponent( obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
           
		str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'>";
		str += "	<div>";        
       	str += "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
       	str += "			<i class='fa fa-times'>X</i>";
       	str += "		</button><br>";
       	str += "		<img  style='width: 340px; height: 340px;' src='/display?fileName=" + fileCallPath + "'>";
       	str += "	</div>";
       	str += "</li>";
        
	});//END each function
	uploadUL.append(str);
}//END showUploadResult

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
        data:formData, 
        type: 'POST',
        dataType:'json',
        beforeSend: function(xhr){
        	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        success: function(result){
			console.log(result);
            showUploadResult(result); //업로드 결과 처리 함수
		}
	});	//END ajax
});//END change function

function showUploadResult(uploadResultArr){
	if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	var uploadUL = $(".attachImage ul");
	var str ="";
	$(uploadResultArr).each(function(i, obj){
		
		if(obj.image){
			var fileCallPath = encodeURIComponent( obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
            
			str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='I'>";
            str += "	<div class='uploadImage'>";        
            str += "		<span> " + obj.fileName + "</span>";
            str += "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
            str += "			<i class='fa fa-times'>X</i>";
            str += "		</button><br>";
            str += "		<img  src='/display?fileName=" + fileCallPath + "'>";
            str += "	</div>";
            str += "</li>";
         } else {
            var fileCallPath = encodeURIComponent( obj.uploadPath + "/" + obj.uuid +"_" + obj.fileName);
            var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
            
            str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='F'>";
			str += "	<div class='uploadImage'>";
			str += "		<img src='/resources/assets/img/icon-attach.png'>";
			str += "		<span> " + obj.fileName + "</span>";
			str += "		<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'>";
			str += "			<i class='fa fa-times'>X</i>";
			str += "		</button><br>";
			str += "	</div>";
			str += "</li>";
		}//END if
	});//END each function
	uploadUL.append(str);
}//END showUploadResult

//파일삭제
$(".uploadImage").on("click", "button", function(e){
	
	$(this).closest("li").remove();

})//END function uploadResult

$("#thumbUploadFile").on("click", function() {
	
	$(".thumbUploadResult ul li").remove();
	
})


////처음 이미지 보이게/////////////////////////////////////////////////////

/* 썸네일 이미지 디테일의 좌상단 이미지 */
	$(document).ready(function() {
		(function() {
			
			var snoStr = '<c:out value="${sale.sno }"/>';
	
			$.getJSON("/board/getThumbList", {snoStr: snoStr}, function(arr) {
	
				var str = "";
				
				$(arr).each(function(i, attach) { 
					
						
					var fileCallPath = encodeURIComponent(attach.stuploadPath + "/" + attach.stuuid + "_" + attach.stfileName);
					
					str = "<li data-path='" + attach.stuploadPath + "' data-uuid='" + attach.stuuid + "' data-filename='" + attach.stfileName + "' data-type='" + attach.stfileType + "'>"
						+ "	<div>"
						+ "		<img style='width: 370px; height: 370px;' src='/display?fileName=" + fileCallPath + "'>"
						+ "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
			        	+ "			<i class='fa fa-times'>X</i>"
			        	+ "		</button>"
						+ "	</div>"
						+ "</li>";
						
					$(".thumbUploadResult ul").append(str);
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
				
				str = "<li data-path='" + attach.suploadPath + "' data-uuid='" + attach.suuid + "' data-filename='" + attach.sfileName + "' data-type='" + attach.sfileType + "'>"
					+ "	<div>"
					+ "		<img style='width: 200px; height: 100%;' src='/display?fileName=" + fileCallPath + "'>"
					+ "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
		        	+ "			<i class='fa fa-times'>X</i>"
		        	+ "		</button>"
					+ "	</div>"
					+ "</li>";
					
				$(".attachImage ul").append(str);
			});
			
		}); //end getJSON
	})();
});
</script>

<%@include file="/WEB-INF/views/include/footer.jsp" %>