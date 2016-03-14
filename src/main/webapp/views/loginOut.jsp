<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isELIgnored="false" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="path" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${path}/views/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${path}/views/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${path}/views/Css/style.css" />
    <script type="text/javascript" src="${path}/views/Js/jquery.js"></script>
    <script type="text/javascript" src="${path}/views/Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="${path}/views/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${path}/views/Js/ckform.js"></script>
    <script type="text/javascript" src="${path}/views/Js/common.js"></script>
    <script type="text/javascript" src="${path}/views/Js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${path}/views/Js/myCommon.js"></script>
<title>退出登录</title>
</head>
<body>
<%
   //使session失效
   session.invalidate();
%> 

<center>
	<h1>注销成功！</h1>3秒后跳转到登录页面<p> 如果没有跳转，请点<a href="login.jsp">这里</a>
	<%
	  response.setHeader("refresh","3;URL=login.jsp");
	%>
</center> 
</body> 
<script type="text/javascript">
$(function(){
   if(new trimStr().trimchar($.cookie("loginName"))!=""){
	   alert($.cookie("loginName"));
	   $.cookie('loginName',null);
	   alert($.cookie("loginName"));
   }; 
});
</script>
</html>