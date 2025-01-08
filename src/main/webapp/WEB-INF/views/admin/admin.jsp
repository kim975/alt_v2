<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
  <%@ include file="/WEB-INF/views/include/admin_header.jsp" %>        
<% request.setCharacterEncoding("utf-8"); %>
  

<!DOCTYPE html>
<html lang="en">

<head>
	<style>
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
</head>
	  <!-- Content Row -->
                    <div class="row">
                        <!-- 회원수 Card  -->
                        <div class="col-xl-3 col-md-6 mb-4" >
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                       <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1"> 회원수</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800" >${clientCount}
                                        </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
					  
                        <!-- 업체수 Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1"> 업체수</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${vendorCount}</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 회원 & 업체 탈퇴 수 Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                              <div class="text-xs font-weight-bold text-success text-uppercase mb-1"> 회원 & 업체 탈퇴 수 </div>
                                              <div class="h5 mb-0 font-weight-bold text-gray-800">	${deleteSum}</div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 회원 & 업체 신고 수 Card -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                		회원 & 업체 신고 수</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${reportSum}</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--카드 끝  -->

                     <div class="row">
                         <!-- 주문량 차트 -->                        
                        <div class="col-xl-6 col-md-9 mb-8">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-success">주문 량</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        </a>
                                         
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                     <div style="width:100%;">
											<canvas id="canvas"></canvas>
									 </div>
                                </div>
                            </div>
                         </div> 
                        <!-- 회원 차트 -->
                        <div class="col-xl-6 col-md-9 mb-8">
                            <div class="card shadow mb-4">
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-success">매출</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        </a>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                     <div style="width:100%;">
											<canvas id="totalPrice"></canvas>
									</div>
                               </div>
                        </div>   
                    </div>
                </div> <!-- 첫번째 차트줄 끝 -->
                    
           
                          <div class="row">
                         <!-- 업체 차트 -->                        
                        <div class="col-xl-6 col-md-9 mb-8">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-success">업체</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        </a>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                     <div style="width:100%;">
											<canvas id="vendorChart"></canvas>
										</div>
                                </div>
                                
                            </div>
                        </div> 
                         <!-- 업체 차트 -->                        
                        <div class="col-xl-6 col-md-9 mb-8">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-success">회원</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        </a>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                     <div style="width:100%;">
											<canvas id="clientChart"></canvas>
										</div>
                                </div>
                                
                            </div>
                        </div> 
                        
                        </div> <!-- 두번째 차트줄 끝 -->
                          <div class="col-xl-6 col-md-9 mb-8">
                            <div class="card shadow mb-4">  
                                <!-- Card Header - Dropdown -->
                             
                                <!-- Card Body -->
                           <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-success">업체 지역별 (%)</h6>
                              </div>  
                                
                                 <div class="container text-center position-relative" >  	
      							<div class="row">
                                        <table class="table table-striped table-bordered table-hover">
                                  			 <thead>
                                                <tr>
                                                    <th>지역</th>
                                                    <th>지역 수</th>
                                                    <th>비율(%)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                             <c:forEach items="${vendorRto }" var="Rto">
                                                <tr>
                                                    <td>${Rto.cityNm}</td>
                                                    <td>${Rto.nvl2}</td>
                                                    <td>${Rto.rto}</td>
                                                </tr>
                                               </c:forEach> 
                                                 </tbody>
                                        </table>
                                    </div>
                                    <!-- /.table-responsive -->
                                </div>  
                            </div>
                        </div>
    <script>
    /* 주문수 */
	var labels =[];

	var data =[];
	
	<c:forEach items="${orderChart}" var="orderChart" >

		labels.push("${orderChart.ordDt}");

		data.push("${orderChart.oamount}");

	</c:forEach>
	
	/* 주문수 */
	var totalPriceLabels =[];

	var totalPriceData =[];
	
	<c:forEach items="${totalPrice}" var="totalPrice" >

	totalPriceLabels.push("${totalPrice.odate}");

	totalPriceData.push("${totalPrice.totalPrice}");

	</c:forEach>
	
	
	
	
	
	/* 회원수, 삭제수 */
	var clientChartLabels =[];

	var clientChartDate =[];
	var clientChartDateD =[];
	
	<c:forEach items="${clientChart}" var="clientChart" >
		clientChartLabels.push("${clientChart.cjoindate}");
		clientChartDate.push("${clientChart.cid}");
	</c:forEach>	
		
	<c:forEach items="${clientChartD}" var="clientChartD" >	
	//	clientChartDate.push("${clientChartD.cjoindate}");
		clientChartDateD.push("${clientChartD.cdelete}");
	</c:forEach>
	
	/* vendor 수  삭제수*/
	var vendorChartLabels =[];

	var vendorChartDate =[];
	var vendorChartDateD =[];
	
	<c:forEach items="${vendorChart}" var="vendorChart" >
		vendorChartLabels.push("${vendorChart.vjoindate}");
		vendorChartDate.push("${vendorChart.vid}");
	</c:forEach>
	<c:forEach items="${vendorChartD}" var="vendorChartD" >	
	//	vendorChartDate.push("${vendorChartD.vjoindate}");
		vendorChartDateD.push("${vendorChartD.vdelete}");
	</c:forEach>

	
	
	
	
    
    </script>                    
                    
    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

     
    <!-- Page level plugins -->
    <script src="/resources/vendor/chart.js/Chart.min.js"></script>
      <!-- <script src="/resources/vendor/chart.js/ClinetChart.min.js"></script> -->

    <!-- Page level custom scripts -->
    <script src="/resources/js/demo/chartTest.js"></script>
<!-- 	<script src="/resources/vendor/chart.js/Chart.min.js"></script> -->
	<script src="https://www.chartjs.org/samples/latest/utils.js"></script>
		
	
      
 <%@ include file="/WEB-INF/views/include/admin_footer.jsp" %>  
 