<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/chatcss.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%
	Date timeNow = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<title>Chat</title>
</head>

<body>
	<sec:authentication property='principal.username' var="id"/>
<div id="container">
	<div id="header">
		<h1>
		${ide } 채팅 
		<sec:authorize access="hasRole('ROLE_VENDOR')">
		<a target="blank" href="/board/conferDoc?cid=${ide}" title="주문서">
			<img src="/resources/assets/img/card-text.svg" width="30" height="30">
		</a>
		</sec:authorize>
		<a href="javascript:history.go(-1)">
			<img style="float: right;" src="/resources/assets/img/box-arrow-left.svg" alt="back" width="30" height="30">
		</a>
		</h1>
	</div>

	<input type="hidden" id="sessionId" value="">
	<input type="hidden" id="roomNumber" value="${roomNumber}">
	<input type="hidden" name="userName" id="userName" value="${id }">
	
	<div id="chating" class="chat-messages">
		<c:forEach items="${msgList}" var="msgList">
			<c:if test="${msgList.id == id}">
			<div class="message">
				<div class="bubble" style='float: right;'>
					<c:out value="${msgList.msg }"/>
					<div class="corner"></div>
					<%-- <c:out value="${msgList.msgread} "/> --%>
					<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${msgList.msgdate }"/></span>
				</div>
			</div>
			</c:if>
			<c:if test="${msgList.id != id}">
			<div class="message right">
				<img style="float: left; margin-left: 20px; margin-bottom: 10px;" src='/resources/assets/img/person-circle.svg' width='40' height='40'>
				<div class="bubble" style="float: left; margin: 10px 20px 30px 40px;">
					<c:out value="${msgList.id }"/>: 
					<c:out value="${msgList.msg }"/>
					<div class="corner" style="float:left;"></div>
					<%-- <c:out value="${msgList.msgread} "/> --%>
					<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${msgList.msgdate }"/></span>
				</div>
			</div>
			</c:if>
		</c:forEach>
	</div>
	
</div>
	<footer>
       <div id="sendmessage">
       	<input type="text" id="chatting" placeholder="메시지를 입력하세요.">
           <button onclick="send()" id="sendBtn"><img style="float: left; margin-left: 20px; margin-bottom: 10px;" src='/resources/assets/img/arrow-return-left.svg' width='20' height='20'></button>
       </div>
	</footer>

<script type="text/javascript">

    var chating = document.getElementById('chating');
    chating.scrollTop = chating.scrollHeight;
    
    var ws;
    
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";

    $(document).ajaxSend(function(e, xhr, options) {
       xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
    })
    
 	window.onload = function(){
		wsOpen();
	}
	
	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/${roomno}");
		wsEvt();
	}

	function wsEvt() {
		//소켓이 열리면 동작	
		ws.onopen = function(data){
		}
		
		//메시지를 받으면 동작
		ws.onmessage = function(data) {
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				
				console.log(msg);
				
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					
					if(d.sessionId == $("#sessionId").val()){
						$("#chating").append("<div class='message'><div class='bubble' style='float: right;'>" 
											+ d.msg 
 											+ "<div class='corner'></div>"
											+ "<span><%= sf.format(timeNow) %></span>"
											+ "</div></div>");	
					}else{
						$("#chating").append("<div class='message right'><img style='float: left; margin-left: 20px; margin-bottom: 10px;' src='/resources/assets/img/person-circle.svg' width='40' height='40'><div class='bubble' style='float: left; margin: 10px 20px 30px 40px;'>" 
											+ d.userName 
											+ " :" 
											+ d.msg 
 											+ "<div class='corner'></div>"
 											+ "<span><%= sf.format(timeNow) %></span>"
											+ "</div></div>");
					}
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}else{
					console.warn("unknown type!");
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){
				send();
			}
		});
	}
	
	function send() {
		var option ={
			type: "message",
			roomNumber: '${roomno}',
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
	
</script>
</body>
</html>