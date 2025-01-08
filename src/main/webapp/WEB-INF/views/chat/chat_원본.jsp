<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>Chatting</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.chating{
			background-color: lightgray;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating .me{
			color: #F6F6F6;
			text-align: right;
		}
		.chating .others{
			color: #FFE400;
			text-align: left;
		}
		input{
			width: 330px;
			height: 25px;
		}
	</style>
</head>


<body>
	<sec:authentication property='principal.username' var="id"/>
	<div id="container" class="container">
		<h1>${id}의 채팅방</h1>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
		
		<div id="chating" class="chating">
			<c:forEach items="${msgList}" var="msgList">
				<c:if test="${msgList.id == id}">
				<div class="me">
					<c:out value="${msgList.msg }"/>
				</div>
				</c:if>
				<c:if test="${msgList.id != id}">
				<div class="other">
					<c:out value="${msgList.id }"/>: 
					<c:out value="${msgList.msg }"/>
				</div>
				</c:if>
			</c:forEach>
		</div>
		
		<input type="hidden" name="userName" id="userName" value="${id }">
		
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
	
	
	<script type="text/javascript">
	var ws;
	
	window.onload = function(){
		wsOpen();
	}

	
	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/${roomno}");
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
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
						$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");	
					}else{
						$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
					}
						
				}else{
					console.warn("unknown type!")
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
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
	
	// 메세지 전송
/* 	$('#notifySendBtn').click(function(e){
	    let modal = $('.modal-content').has(e.target);
	    let type = '70';
	    let target = modal.find('.modal-body input').val();
	    let content = modal.find('.modal-body textarea').val();
	    let url = '${contextPath}/member/notify.do';
	    // 전송한 정보를 db에 저장	
	    $.ajax({
	        type: 'post',
	        url: '${contextPath}/member/saveNotify.do',
	        dataType: 'text',
	        data: {
	            target: target,
	            content: content,
	            type: type,
	            url: url
	        },
	        success: function(){    // db전송 성공시 실시간 알림 전송
	            // 소켓에 전달되는 메시지
	            // 위에 기술한 EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
	            socket.send("관리자,"+target+","+content+","+url);	
	        }
	    });
	    modal.find('.modal-body textarea').val('');	// textarea 초기화
	}); */
	
</script>
</body>
</html>