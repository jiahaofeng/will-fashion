<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="path" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>后台管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${path}/views/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${path}/views/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${path}/views/Css/style.css" />
    <script type="text/javascript" src="${path}/views/Js/jquery.js"></script>
    <script type="text/javascript" src="${path}/views/Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="${path}/views/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${path}/views/Js/ckform.js"></script>
    <script type="text/javascript" src="${path}/views/Js/common.js"></script>
<style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            max-width: 300px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }

        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }

    </style>  
</head>
<body>
	<div class="container">

    <form class="form-signin" method="post" action="">
      
        <center><h2 class="form-signin-heading">登录系统</h2></center>
        <div id="loginInfo" class="alert alert-error" hidden="true">用户名或密码错误，请重新登录！</div>
        <div id="loginInfoNull" class="alert alert-error" hidden="true">用户名或密码不能为空！</div>
        <input type="text" name="username" id="loginName" class="input-block-level" placeholder="账号">  
       	<div id="nameInfo" class="alert alert-error" hidden="true">用户名不能为空！</div>
        <input type="password" name="password" id="loginPwd" class="input-block-level" placeholder="密码">
         <div id="pwdInfo" class="alert alert-error" hidden="true">密码不能为空！</div>
        <p><a class="btn btn-large btn-primary" type="submit" id="loginSubmit">登录</a></p>
    </form>

</div>
</body>
<script type="text/javascript">

	$(function() {
		
	});
	
	
 	$("#loginSubmit").click(function(){
 		$("#nameInfo").attr("hidden",true);
 		$("#pwdInfo").attr("hidden",true);
 		$("#loginInfo").attr("hidden",true);
 		$("#loginInfoNull").attr("hidden",true);
		var loginName = $("#loginName").val();
		var loginPwd = $("#loginPwd").val();
		if (loginName=="") {
			$("#nameInfo").removeAttr("hidden");
			return false;
		}
		if (loginPwd=="") {
			$("#pwdInfo").removeAttr("hidden");
			return false;
		} 
		$.ajax({
			url:"${path}/users/usersLogin",
			type: "POST",
			data:{"loginName":loginName,"loginPwd":loginPwd},
			dataType :"json",
			success :function(data){
				if (data!=null&&data!="") {
					if (data.status=="0") {
						$("#loginInfoNull").removeAttr("hidden");
						return false;
					}
					if (data.status=="2") {
						$("#loginInfo").removeAttr("hidden");
						return false;
					}
					if (data.status=="1") {
						window.location.href = "${path}/views/index.jsp?loginName="+data.loginName;
					}
				}
			},
			error:function(){
				alert("系统登录错误");
			} 
		}); 
	}); 
</script>
</html>