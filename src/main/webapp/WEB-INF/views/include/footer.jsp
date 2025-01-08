	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- ======= Footer ======= -->
  <footer id="footer">

    <div class="footer-top">
      <div class="container">
        <div class="row">

                    <div class="col-lg-3 col-md-6 footer-contact">
            <h3>A.L.T</h3>
            <p>
              130 Gurogu<br>
              Seoul, SE 1330<br>
              Republic of Korea <br><br>
              <strong>Phone:</strong> +82 1112 3334<br>
              <strong>Email:</strong> altadmin@gmail.com<br>
            </p>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="http://localhost:8080/">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="http://localhost:8080/">About us</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="">Services</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="">Terms of service</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="http://localhost:8080/notice/list">공지사항</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="http://localhost:8080/board/saleBoard">판매게시판</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="">장바구니</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="">마이페이지</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="">관리자문의</a></li>
            </ul>
          </div>

          <div class="col-lg-4 col-md-6 footer-newsletter">
            <h4>KAMIS 농축산물 유통 시세 정보 바로보기</h4>
            <p>농축산물 현재 시세에 대해서 알아보고 거래를 진행해 보세요.</p>
            <form action="https://www.kamis.or.kr/customer/main/main.do"  method="get">
              <input type="email" name="email" readonly="readonly" value="농수산물 시세 검색"><input type="submit" value="알아보러가기">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
          </div>

        </div>
      </div>
    </div>

    <div class="container d-md-flex py-4">

      <div class="mr-md-auto text-center text-md-left">
        <div class="copyright">
          &copy; Copyright <strong><span>Bethany</span></strong>. All Rights Reserved
        </div>
        <div class="credits">
          <!-- All the links in the footer should remain intact. -->
          <!-- You can delete the links only if you purchased the pro version. -->
          <!-- Licensing information: https://bootstrapmade.com/license/ -->
          <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/bethany-free-onepage-bootstrap-theme/ -->
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </div>
      <div class="social-links text-center text-md-right pt-3 pt-md-0">
        <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
        <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
        <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
        <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
        <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

  <!-- Vendor JS Files -->
  <!-- <script src="/resources/assets/vendor/jquery/jquery.min.js"></script> -->
  <script src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="/resources/assets/vendor/php-email-form/validate.js"></script>
  <script src="/resources/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
  <script src="/resources/assets/vendor/counterup/counterup.min.js"></script>
  <script src="/resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/resources/assets/vendor/venobox/venobox.min.js"></script>
  <script src="/resources/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
  <script src="/resources/assets/vendor/aos/aos.js"></script>

  <!-- Template Main JS File -->
  <script src="/resources/assets/js/main.js"></script>

</body>

</html>   