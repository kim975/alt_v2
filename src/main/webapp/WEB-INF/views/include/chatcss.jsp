<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberVO" var="memberVO"/>
	</sec:authorize>

<style type="text/css">
* { margin: 0px;}
body {
	background: #f0f1f2;
}

#chatbox{
	/* width:400px; */
	background:#fff;
	border-radius:6px;
	overflow:hidden;
	height:800px;
	top:20px;
	left:5%;
  margin: 0 auto;
}

#friendslist{
	top:0;
	left:0;
	width:100%;
	height:100%;
}
#topmenu{
	height:69px;
	width:100%;
	border-bottom:1px solid #d8dfe3;	
}
#topmenu span{
	float: left;	
	width: 120px;
    height: 70px;
    background: url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/top-menu.png") -3px -118px no-repeat;
}

#topmenu span.friends{margin-bottom:-1px;}

.friend{
	height:70px;
	border-bottom:1px solid #e7ebee;		
	position:relative;
	text-decoration:none;
}
.friend:hover{
	background:#f1f4f6;
	cursor:pointer;
}
.friend img{
	width:40px;
	border-radius:50%;
	margin:15px;
	float:left;
}
.floatingImg{
	width:40px;
	border-radius:50%;
	position:absolute;
	top:0;
	left:12px;
	border:3px solid #fff;
}

.friend strong{
  	font-size:27px;
	color:#597a96;  

}
.chat-messages div.message{
	padding:0 0 30px 58px;
	clear:both;
	margin-bottom:45px;
}
.chat-messages div.message.right{
	  padding: 0 58px 30px 0;
	  margin-right: -19px;
	  margin-left: 19px;
}
.chat-messages .message img{
	  float: left;
	  margin-left: -38px;
	  border-radius: 50%;
	  width: 30px;
	  margin-top: 12px;
}
.chat-messages div.message.right img{
	float: right;	
    margin-left: 0;
	margin-right: -38px;	
}
.message .bubble{	
	background:#ffffff;
	font-size:13px;
	font-weight:600;
	padding:12px 13px;
	border-radius:5px 5px 5px 0px;
	color:#8495a3;
	position:relative;
	float:left;
}
.chat-messages div.message.right .bubble{
	float:right;
	border-radius:5px 5px 0px 5px ;
}
.bubble .corner{
	background:url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/bubble-corner.png") 0 0 no-repeat;
	position:absolute;
	width:7px;
	height:7px;
	left:-5px;
	bottom:0;
}
div.message.right .corner{
	background:url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/bubble-cornerR.png") 0 0 no-repeat;
	left:auto;
	right:-5px;
}
.bubble span{
	  color: #8495a3;
	  font-size: 11px;
	  position: absolute;
	  right: 0;
	  bottom: -22px;
}

footer{ 
	position:fixed; 
	left:0px; 
	bottom:0px; 
	height:60px; 
	width:100%; 
	background:grey; 
	color: white; 
}

#sendmessage{
	height:60px;
	border-top:1px solid #e7ebee;	
	position:absolute;
	bottom:0;
	right:0px;
	width:100%;
	background:#fff;
	padding-bottm:50px;
}

#sendmessage input{
	background:#fff;
	margin:21px 0 0 21px;
	border:none;
	padding:0;
	font-size:14px;
	font-family:"Open Sans", sans-serif; 
	font-weight:400px;
	color:#aab8c2;
}
#sendmessage input:focus{
	 outline: 0;
}
#sendmessage button{
	background:#fff 0 -41px no-repeat;
	width:40px;
	height:30px;
	position:absolute;
	right: 15px;
	top: 23px;
	border:none; 
}
#sendmessage button:hover{
	cursor:pointer;
	background-position: 0 0 ;
}
#sendmessage button:focus{
	 outline: 0;	 
}

#close{
	position:absolute;
	top: 8px;	
	opacity:0.8;
 	right: 10px;
	width:20px;
	height:20px;
	cursor:pointer;
}
#close:hover{
	opacity:1;
}

#chatview, #sendmessage { 
overflow:hidden; 
border-radius:6px; 
}

#header{
	margin: 20px; 
	padding: 20px; 
	position : fixed;
	left:0;
	top:0;
	width:90%;
	z-index:4;
}

body{
    overflow: hidden;
    position: relative;
    height: 100%;
}

#chating{
	background-color: f6fff6;
	margin-top:100px;
	width: 100%;
	height: 530px;
	overflow: auto;
    overflow: hidden;
    overflow-y: scroll;
	-ms-overflow-style: none;  /* IE and Edge */
  	scrollbar-width: none;
}

::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-thumb {
  background: #8fb8b3;
  border-radius: 10px;
}


</style>
