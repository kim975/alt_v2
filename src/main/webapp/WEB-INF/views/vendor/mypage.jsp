<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp" %>

	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
	  <ol class="breadcrumb" style="padding-left:200px;">
	    <li class="breadcrumb-item"><a href="/">홈</a></li>
	    <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
	  </ol>
	</nav>

<!-- ======= mypage Section ======= -->
<section id="mypage" class="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 aos-init aos-animate" data-aos="fade-right">
            <div class="section-title">
              <h2>마이페이지</h2>
            </div>
          </div><!-- End col-lg-4 -->

            <div class="row">
              <div class="col-lg-6 mt-4">
                <div class="info">
                  <i class="bi bi-exclamation-circle"></i>
                  <h4><a href="/vendor/mypage_info?vid=${memberVO.vid}">내정보</a></h4>
              	  <p>나의 정보를 확인하거나 수정합니다.</p>
                </div>
              </div>
              <div class="col-lg-6 mt-4">
                <div class="info">
                  <i class="bx bx-file"></i>
                  <h4><a href="/vendor/mypage_salelist?vid=${memberVO.vid}">판매글 목록</a></h4>
                  <p>나의 판매 목록을 확인합니다.</p>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="info w-100 mt-4">
                  <i class="bi bi-receipt"></i>
                  <h4><a href="/vendor/mypage_orderlist?vid=${memberVO.vid}">주문 목록</a></h4>
                  <p>나의 판매글에 대한 주문 목록을 확인하고 결제를 확인하세요.</p>
                </div>
              </div>
               <div class="col-lg-6">
                <div class="info w-100 mt-4">
                  <i class="bi bi-box-arrow-right"></i>
                  <h4><a href="/vendor/mypage_delete?vid=${memberVO.vid}">탈퇴</a></h4>
                  <p>ALT를 떠나시려면 여기버튼을 선택하세요.</p>
                </div>
              </div><!-- End col-lg-6 -->
            </div><!-- End row -->

      </div><!-- End row -->
    </div><!-- End container -->
</section><!-- End mypage -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>