<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/chatcss.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<title>Room</title>

</head>

<body>
	<div class="container">
	
	<div id="chatbox">
		<div id="friendslist">
	    	<div id="topmenu">
	        	<span class="friends"></span>
	        </div>
	        
	        <div id="friends">
	        </div>                
	        
	    </div>	
	</div>
	</div>
	
<script type="text/javascript">
	var ws;
	
	var myCid = '<c:out value="${memberVO.cid }"></c:out>';
	var myVid = '<c:out value="${memberVO.vid }"></c:out>';
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	$(document).ajaxSend(function(e, xhr, options) {
	   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);   
	})
	
	
	window.onload = function(){
		getRoom();
		createRoom();
	}

	function getRoom(){
		
		var vid = 'idvendor1';
		
		$.ajax({
			url: '/getRoom',
			data: vid,
			type: 'post',
			dataType: "JSON",
			success: function (res) {
				createChatingRoom(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
	
	function createRoom(){
		$("#createRoom").click(function(){
			var msg = {	roomName : $('#roomName').val()	};

			commonAjax('/createRoom', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}
	
	function goRoom(number){
		location.href="/moveChating?roomno="+number;
	}
	
	function createChatingRoom(res){
		if(res != null){
			var tag = "";
			res.forEach(function(d, idx){
				var rn = d.roomno;
				
					if(d.cid != myCid) {
						tag += "<a class='friend' style='width: 100%; height: 100%;' href='/moveChating?roomno=" + rn + "&ide=" + d.cid + "'>";
					} else {
						tag += "<a class='friend' style='width: 100%; height: 100%;' href='/moveChating?roomno=" + rn + "&ide=" + d.vid + "'>";
					}

				tag += "	<div class='friend go'>"
					+  "	<img src='/resources/assets/img/person-circle.svg' width='40' height='40'>";
					
 					if(d.cid != myCid) {
 						tag +=  "		<strong>"+ d.cid +"</strong>";
					} else {
						tag +=  "		<strong>"+ d.vid +"</strong>";
					}
					tag +=  "	</div>"
					+  "</a>";	
			});
			$("#friends").empty().append(tag);
		}
	}
	
	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			dataType: "JSON",
			success: function (res) {
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
</script>
</body>
</html>