<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Insert title here</title>
<style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
</head>
<body>
<form action="${path}/users/addUser" method="post" class="definewidth m20">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">登录名</td>
        <td><input type="text" name="userName"/></td>
    </tr>
    <tr>
        <td class="tableleft">密码</td>
        <td><input type="password" name="pwd"/></td>
    </tr>
    <tr>
        <td class="tableleft">邮箱</td>
        <td><input type="text" name="email"/></td>
    </tr>
    <tr>
        <td class="tableleft">状态</td>
        <td>
           <input type="radio" name="status" value="1" checked/> 启用
           <input type="radio" name="status" value="0"/> 禁用
        </td>
    </tr>
    <tr>
        <td class="tableleft">角色</td>
        <td>
	        <select name="roles">
	        	<option value="1">管理员</option>
	        	<option value="2">普通用户</option>
	        </select>
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary" type="button">保存</button> &nbsp;&nbsp;
            <button type="button" class="btn btn-success" name="backid" id="backid">返回</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
$(function () {    
	
	$('#backid').click(function(){
			window.location.href="${path}/views/User/UserList.jsp";
	 });
	
	 var val=$('input:radio[name="status"]:checked').val();
	 $('input:radio[name="status"]').click(function(){
		if($(this).val()=="1"){
			$("#role").removeAttr("disabled");
		}else{			
			$("#role").attr({"disabled":"disabled"});
		}
	 });
	$(":submit").on("click",function(){
		//--------------
		$('form :input').trigger('blur');
		var numError = $('form .onError').length;
		if(numError){
			return false;
		} 
		alert("保存成功！~~");
	});
	//文本框失去焦点
    $('form :input').blur(function(){
         var $parent = $(this).parent();
         $parent.find(".formtips").remove();
         //验证用户名
         if( $(this).is('input[name=userName]') ){
                if( this.value=="" || ( this.value!="" && ! /^[a-zA-Z]\w{3,15}$/ig.test(this.value) )){
                    var errorMsg = '用户名长度至少为6位，必须以字母开头加数字，不能跟汉字和特殊字符.';
                    $parent.append('<span class="formtips onError">'+errorMsg+'</span>');
					
                }else{
                    var okMsg = '输入正确.';
                    $parent.append('<span class="formtips onSuccess">'+okMsg+'</span>');
					
                }
         };
		 //验证手机
         if( $(this).is('input[name=telephone]') ){
            if( this.value=="" || ( this.value!="" && !/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(this.value) ) ){
                  var errorMsg = '请输入正确的手机号码.';
                  $parent.append('<span class="formtips onError">'+errorMsg+'</span>');
				  
            }else{
                  var okMsg = '输入正确.';
                  $parent.append('<span class="formtips onSuccess">'+okMsg+'</span>');
				  
            }
         };
         //验证邮件
         if( $(this).is('input[name=email]') ){
            if( this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) ) ){
                  var errorMsg = '请输入正确的E-Mail地址.';
                  $parent.append('<span class="formtips onError">'+errorMsg+'</span>');
				  
            }else{
                  var okMsg = '输入正确.';
                  $parent.append('<span class="formtips onSuccess">'+okMsg+'</span>');
				  
            }
         };
    }).keyup(function(){
       $(this).triggerHandler("blur");
    }).focus(function(){
         $(this).triggerHandler("blur");
    });//end blur

});

</script>