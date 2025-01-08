<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>  

<%@ include file="/WEB-INF/views/include/header.jsp" %>


<body>

  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex align-items-center">
    <div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="200">
      	<h1>(접근 제한) 홈페이지에 엑세스가 거부 되었습니다.</h1>
		<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
		<h2>Error Code : <c:out value="${msg}"/></h2>
		<h2>접근이 제한된 페이지로 이동하셨습니다. 메인 페이지로 돌아가세요.</h2>
      <a href="/" class="btn-get-started scrollto">홈페이지로 가기</a>
    </div>
  </section><!-- End Hero -->
<!-- ======= Hero Section ======= -->

	


</body>
</html>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>