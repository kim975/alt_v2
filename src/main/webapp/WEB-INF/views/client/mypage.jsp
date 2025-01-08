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
              <p>당신이 작성한 것에 대해서 모든것을 한번에 확인해보세요.</p>
            </div>
          </div><!-- End col-lg-4 -->

            <div class="row">
              <div class="col-lg-6 mt-4">
                <div class="info">
                  <i class="bi bi-exclamation-circle"></i>
                  <h4><a href="/client/mypage_info?cid=${memberVO.cid}">내 정보</a></h4>
              	  <p>나의 정보를 확인하거나 수정합니다.</p>
                </div>
              </div>
              <div class="col-lg-6 mt-4">
                <div class="info">
                  <i class="bx bx-file"></i>
                  <h4><a href="/client/mypage_zimlist?cid=${memberVO.cid}">찜 목록</a></h4>
                  <p>나의 찜 목록을 확인합니다.</p>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="info w-100 mt-4">
                  <i class="bi bi-receipt"></i>
                  <h4><a href="/client/mypage_orderlist?cid=${memberVO.cid}">주문 목록</a></h4>
                  <p>나의 대한 주문 목록을 확인하고 결제 여부를 확인하세요.</p>
                </div>
              </div>
               <div class="col-lg-6">
                <div class="info w-100 mt-4">
                  <i class="bi bi-box-arrow-right"></i>
                  <h4><a href="/client/mypage_delete?cid=${memberVO.cid}">탈퇴</a></h4>
                  <p>ALT를 떠나시려면 여기버튼을 선택하세요.</p>
                </div>
              </div><!-- End col-lg-6 -->
            </div><!-- End row -->

      </div><!-- End row -->
    </div><!-- End container -->
</section><!-- End mypage -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>