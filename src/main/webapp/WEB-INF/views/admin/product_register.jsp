<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

  <%@ include file="/WEB-INF/views/include/admin_header.jsp" %>       

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
</style>

<main id="main">
 
   <!-- ======= about Section ======= -->
<section id="titleSection" class="d-flex align-items-center">
    <div class="container text-center position-relative" >
        <div class="row">
        	<div class="col-sm-12">
				<h1>제품 코드 부여 등록</h1>
			</div><!-- End col-sm-12-->
  		</div><!-- /.row -->
  	</div><!-- End container -->
</section><!-- End titleSection -->
  
<section id="about" class="d-flex align-items-center">	
    <div class="container">
  	  <form id="frmRegister" action="/admin/registerProduct" method="post">
    	    <div class="row">
    	    	
        		 
				<div class="col-lg-6">
					
					
				<!-- 	<div class="form-group">
						<h5><label>제품코드</label></h5>
						<input class="form-control" style="border: 3px solid green;" name='pcode'>
					</div> -->
					<div class="form-group">
						<h5><label>이름</label></h5>
						<input class="form-control"style="border: 3px solid green;" name='pname'>
					</div>	
					 <div class="form-group">
					<div class="col-lg-12">
  	  				<button type="submit" id="btnSubmit"class="btn btn-success" style="background-color:#009970">등록</button>
					<button type="reset"class="btn btn-success" style="background-color:#009970">다시입력</button>
					<button type="button" id="btnList" class="btn btn-success" style="background-color:#009970" onclick="location.href='/admin/productList'">글목록</button>
				</div><br><br>
					</div>
				</div>
				
				 
				 
	  		</div><!-- /.row -->
	  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  		</form>
  	</div><!-- End container -->
</section><!-- End about Section -->  	
 
 


<%@include file="/WEB-INF/views/include/admin_footer.jsp" %>