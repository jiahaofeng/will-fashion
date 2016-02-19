<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="path" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
<link href="assets/css/bui-min.css" rel="stylesheet" type="text/css" />
<link href="assets/css/main-min.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body>

	<div class="header">

		<div class="dl-title">
			<img src="assets/img/top.png">
		</div>

		<div class="dl-log">
			欢迎您，<span class="dl-log-user">root</span><a
				href="/chinapost/index.php?m=Public&a=logout" title="退出系统"
				class="dl-log-quit">[退出]</a>
		</div>
	</div>
	<div class="content">
		<div class="dl-main-nav">
			<div class="dl-inform">
				<div class="dl-inform-title">
					<s class="dl-inform-icon dl-up"></s>
				</div>
			</div>
			<ul id="J_Nav" class="nav-list ks-clear">
				<li class="nav-item dl-selected"><div
						class="nav-item-inner nav-home">系统管理</div></li>
				<li class="nav-item dl-selected"><div
						class="nav-item-inner nav-order">业务管理</div></li>

			</ul>
		</div>
		<ul id="J_NavContent" class="dl-tab-conten">

		</ul>
	</div>
	<script type="text/javascript" src="assets/js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="assets/js/bui-min.js"></script>
	<script type="text/javascript" src="assets/js/common/main-min.js"></script>
	<script type="text/javascript" src="assets/js/config-min.js"></script>
	<script>
		BUI.use('common/main', function() {
			var config = [ {
				id : '1',
				menu : [ {
					text : '系统管理',
					items : [ {
						id : '12',
						text : '机构管理',
						href : 'Node/index.html'
					}, {
						id : '3',
						text : '角色管理',
						href : 'Role/index.html'
					}, {
						id : '4',
						text : '用户管理',
						href : '${path}/User/UserList.jsp'
					}, {
						id : '6',
						text : '菜单管理',
						href : 'Menu/index.html'
					} ]
				} ]
			}, {
				id : '7',
				homePage : '9',
				menu : [ {
					text : '业务管理',
					items : [ {
						id : '9',
						text : '查询业务',
						href : 'Node/index.html'
					} ]
				} ]
			} ];
			new PageUtil.MainPage({
				modulesConfig : config
			});
		});
	</script>
	<div style="text-align: center;">
		<p>
			来源：<a href="http://www.mycodes.net/" target="_blank">源码之家</a>
		</p>
	</div>
</body>
</html>