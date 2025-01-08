<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp" %>
<style>
ul{
   list-style:none;
}
</style>

<script src="https://kit.fontawesome.com/3929e16ef5.js"></script>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active"><a href="/board/saleBoard">판매게시판</a></li>
	  </ol>
	</nav>

	<section class="d-flex align-items-center justify-content-center">
		<div class="container">
			<div class="basket row">
				<div class="col-md-6">
					<div id="${sale.sno }">
		
					</div>
				</div>		
				<div class="col-md-6">
					<c:out value="${sale.stitle }"></c:out>	
					<hr>
					<div class="form-group">
              			<label>가격</label> 
              			<input class="form-control" value='${sale.sprice }' readonly="readonly">
            		</div>      
            		<div class="form-group">
              			<label>남은 수량</label> 
              			<input class="form-control" value='${sale.samount }' readonly="readonly">
            		</div>
				</div>		
				
			</div><!-- row close -->
		</div> <!-- container close -->
	</section>
	
	<hr class="my-hr3">
	
	<section>
		<div class="container">
			<form id="frmRegister" action="/replies/modify" method="post" >
				<div class="form-group">
            		<!-- <label>별점</label>  -->
            		<div id="star_grade" style="color: orange;">
		                <c:forEach begin="1" end="5" step="1" varStatus="status">
		                	<c:choose>
			                	<c:when test="${status.count <= reply.rstar }">
			                		<i class='fas fa-star'></i>
			                	</c:when>
			                	<c:otherwise>
			                		<i class='far fa-star'></i>
			                	</c:otherwise>
		                	</c:choose>
		                </c:forEach>
			        </div>
           		</div>      
           		<div class="form-group">
             		<!-- <label>작성자</label>  -->
             		<input class="form-control" type="text" name="rwriter" value='${reply.rwriter }' readonly="readonly">
           		</div>
				<div class="form-group">
             		<!-- <label>내용</label>  -->
             		<textarea id="rcontent" class="form-control" rows="10" name='rcontent' placeholder="제품의 리뷰를 작성해주세요.">${reply.rcontent }</textarea>
           		</div>
           		
           		<button type="submit" id="btnSubmit"  class="btn btn-success" style="background-color:#009970;">수정</button>
				<button type="reset" class="btn btn-outline-success" style="color:#009970;">다시입력</button>
           		<input type="hidden" value="${sale.sno }" name="sno">
           		<input type="hidden" value="${reply.rno }" name="rno">
           		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</section>
	
	<section id="fileUpload" class="d-flex align-items-center">	
	<div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="0">
		<div class="row">
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
		</div><!-- END row-->
	</div><!-- End container -->
	</section><!-- End fileUpload  -->
	
<script type="text/javascript" src="/resources/customjs/basket.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
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
	
	var frmRegister = $("#frmRegister");

	$("#btnSubmit").on("click", function(e){
		
		e.preventDefault();
		
		var _rcontent = $("#rcontent").val();
		
		if (_rcontent.length == 0 || _rcontent == "") {
        	
            alert("내용을 작성해주세요.");
            return false;
            
        }
		
		console.log("submit clicked");
		var str = "";

	 	$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj); 
			str += "<input type='hidden' name='attachList[" + i + "].rfileName' value='"+ jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList[" + i + "].ruuid' value='"+ jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList[" + i + "].ruploadPath' value='"+ jobj.data("path")+"'>";
		});
		
	 	/* var star = $('.fas').length; */
		str += "<input type='hidden' name='rstar' value='" + $('.fas').length + "'>";
	 	
		frmRegister.append(str).submit();
		//alert("str : " + str);
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
		var uploadUL = $(".uploadResult ul");
		var str ="";
		$(uploadResultArr).each(function(i, obj){
			
			if(obj.image){
				var fileCallPath = encodeURIComponent( obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
	            
				str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='I'>";
	            str += "	<div>";        
	            /* str += "		<span> " + obj.fileName + "</span>"; */
   	            str += "		<img src='/display?fileName=" + fileCallPath + "'>";
	            str += "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
	            str += "			<i class='fa fa-times'></i>";
	            str += "		</button><br>";
	            str += "	</div>";
	            str += "</li>";
	         } else {
	            var fileCallPath = encodeURIComponent( obj.uploadPath + "/" + obj.uuid +"_" + obj.fileName);
	            var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
	            
	            str +="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='F'>";
				str += "	<div>";
				str += "		<img src='/resources/assets/img/icon-attach.png'>";
				str += "		<span> " + obj.fileName + "</span>";
				str += "		<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'>";
				str += "			<i class='fa fa-times'></i>";
				str += "		</button><br>";
				str += "	</div>";
				str += "</li>";
			}//END if
		});//END each function
		uploadUL.append(str);
	}//END showUploadResult

	$(document).ready(function() {
		(function() {
			
			var rnoStr = '<c:out value="${reply.rno}"/>';
			
			$.getJSON("/replies/getReplyImageList", {rnoStr: rnoStr}, function(arr) {
	
				var str = "";
				
				$(arr).each(function(i, attach) { 
					
					var fileCallPath = encodeURIComponent(attach.ruploadPath + "/s_" + attach.ruuid + "_" + attach.rfileName);
					
					str = "<li class='imagePath' data-path='" + attach.ruploadPath + "' data-uuid='" + attach.ruuid + "' data-filename='" + attach.rfileName + "' data-type='" + attach.rfileType + "'>"
						+  "	<div style='width: 100%; height: 150px'>"
						+  "		<img src='/display?fileName=" + fileCallPath + "'>"
						+ "		<button type='button' data-file=\'"+ fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'>"
			        	+ "			<i class='fa fa-times'></i>"
			        	+ "		</button>"
						+  "	</div>"
						+  "</li>";
						
					$(".uploadResult ul").append(str);
				});
				
			}); //end getJSON
		})();
	});
	
	//파일삭제
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");

		var targetLi = $(this).closest("li");
		
		targetLi.remove();
	})//END function uploadResult
	
	$('#star_grade i').click(function(){
        $(this).parent().children("i").removeClass("fas").addClass("far");  /* 별점의 on 클래스 전부 제거 */ 
        $(this).addClass("fas").prevAll("i").addClass("fas"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
        return false;
    });
</script>
<%@include file="/WEB-INF/views/include/footer.jsp" %>


