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
<link rel="stylesheet" href="${path}/views/Css/jquery-ui.css">
<link rel="stylesheet" href="${path}/views/Css/jquery.pagination.css">

<script type="text/javascript" src="${path}/views/Js/jquery.js"></script>
<script type="text/javascript" src="${path}/views/Js/jquery.pagination.js"></script>
<script src="${path}/views/Js/jquery-ui.js"></script>
<%--  <script src="${path}/Js/jquery.shCircleLoader.js" type="text/javascript"></script> --%>
<script type="text/javascript" src="${path}/views/Js/jquery.sorted.js"></script>
<script type="text/javascript" src="${path}/views/Js/bootstrap.js"></script>
<script type="text/javascript" src="${path}/views/Js/ckform.js"></script>
<script type="text/javascript" src="${path}/views/Js/common.js"></script>
<script type="text/javascript" src="${path}/views/Js/myCommon.js"></script>

<style type="text/css">

body {
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

@media ( max-width : 980px) {
	/* Enable use of floated navbar text */
	.navbar-text.pull-right {
		float: none;
		padding-left: 5px;
		padding-right: 5px;
	}
}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="form-inline definewidth m20">
	<!-- Search Area -->
<div class="accordion">
    <div class="accordion-group">
        <form action="index" name="searchForm" style=" margin-bottom: 0px;margin-top: 10px; ">
            <!-- Accordion Heading -->
            <div class="accordion-heading" style="margin-left: 50px;">
                <div class="row">
                    <div class="form-horizontal">
                        <fieldset class="span3">
                            <div class="control-group">
                                <label class="control-middle-label" for="name">用户名： <input type="text" name="username" id="username"class="span2" placeholder="" value=""></label>
                            </div>
                        </fieldset>
                    </div>
                    <div class="form-horizontal">
                        <fieldset class="span3">
                            <div class="control-group">
                                <label class="control-middle-label" for="entryDate">邮箱： <input type="text" name="email" id="email"class="span2" placeholder="" value=""></label>
                            </div>
                        </fieldset>
                    </div>
                    <!-- <div class="form-horizontal">
                        <fieldset class="span3">
                            <div class="control-group">
                                <label class="control-middle-label" for="entryDate">手机号： <input type="text" name="telephone" id="telephone"class="span2" placeholder="" value=""></label>
                            </div>
                        </fieldset>
                    </div> -->
                     <div class="form-horizontal">
                        <fieldset class="span3">
                            <div class="control-group">
                                <label class="control-middle-label" for="entryDate">角色：
                                	 <select class="span2" id="roles">
                                	 	<option value="">全部</option>
                                		<option value="1">管理员</option>
                                		<option value="2">普通用户</option>
                                	</select>
                                </label>
                            </div>
                        </fieldset>
                    </div>
                </div>
                <div class="row">
                   
                	<div class="form-horizontal">
                        <fieldset class="span3">
                            <div class="control-group">
                               <label class="control-middle-label" for="entryDate">状态：
                                	 <select class="span2" id="status">
                                	 	<option value="">全部</option>
                                		<option value="1">活跃</option>
                                		<option value="0">禁用</option>
                                	</select>
                                </label>
                            </div>
                        </fieldset>
                    </div>
                    <div class="form-horizontal">
                        <fieldset class="span15" style="width: 350px;">
                            <div class="control-group">
                                <label class="control-middle-label" for="leaveDate">
                                	更新时间：<input type="text" id="datepickerStart" class="input-small">-<input type="text" id="datepickerEnd" class="input-small">
                                	<input class="btn btn-mini btn-inverse" type="button" onclick="cleanDateEmpty()" value="置空日期">
                                </label>
                            </div>
                        </fieldset>
                    </div>
                     <!-- Query Button & Dropdown Button -->
                        <button type="button" class="btn btn-primary" id="submitSearch" onclick="">查询</button>

               </div>
            </div>
        </form>
    </div>
</div>
		<button type="button" class="btn btn-success" id="addUser">新增</button> 
</div>
<!-- <div id="shclKeyframes"></div> -->
	<table class="table table-bordered table-hover definewidth m10" id="userListShow">
		<colgroup>
	        <col width="10%">
	        <col width="16%">
	        <col width="6%">
	        <col width="14%">
	        <col width="14%">
	        <col width="14%">
	        <col width="5%">
	        <col width="10%">
	    </colgroup>
		<thead>
			<tr>
				<th>用户名</th>
				<th>邮箱</th>
				<th>角色</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>最后登录时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
	</table>
	<div id="noData"></div>
	<input type="hidden" id="hideTotalCount" />
	<div id="pagination" class="scott"></div>
</body>
</html>
<script>
	var pageIndex = 0;     // 页面索引初始值
	var pageSize = 10;     //每页显示条数初始化，修改显示条数，修改这里即可
	$(function() {
		InitPage();
		initUserList(0); 
		addNewUsers();
		submitSearch();
	});
		
	function setCookie(sName,sValue){
		date = new Date();
		s = date.getDate();
		date.setDate(s+1);
		document.cookie = sName+"="+escape(sValue)+";expires="+date.toGMTString();
	}
	function getCookie(sName){
		var aCookie = document.cookie.split(";");
		for (var i = 0; i < aCookie.length; i++) {
			var aCrumb = aCookie[i].split("=");
			if (sName == new trimStr().trimchar(aCrumb[0])) { 
	            return unescape(aCrumb[1]);
	        } 
		}
	}
	
	function fnLoad() 
    { 
		document.documentElement.scrollWidth = getCookie("scrollLeft");
		document.documentElement.scrollTop = getCookie("scrollTop");
        
    } 

    function fnUnload() 
    { 
		setCookie("scrollLeft",document.documentElement.scrollWidth); 
        setCookie("scrollTop",document.documentElement.scrollTop);
        
    } 
    
    function InitPage(){
    	$("#username").val("");
    	$("#email").val("");
    	$("#telephone").val("");
    	$("#datepickerStart").val("");
    	$("#datepickerEnd").val("");
    	
    	//日期选择器
		$("#datepickerStart").datepicker({
			//appendText: "(yyyy-mm-dd)",
			autoSize: true,
			dateFormat: "yy-mm-dd",
			dayNames: [ "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi" ]
		});
		$("#datepickerEnd").datepicker({
			//appendText: "(yyyy-mm-dd)",
			autoSize: true,
			dateFormat: "yy-mm-dd",
			dayNames: [ "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi" ]
		});
		
		/* $("#datepickerStart").change(function(){
			var start = $("#datepickerStart").val();
			var end = $("#datepickerEnd").val();
			if(start=="")return;
			if(end < start){
				alert("结束时间必须大于开始时间");
				$("#datepickerEnd").val("");
			}
		}); */
		$("#datepickerEnd").change(function(){
			var start = $("#datepickerStart").val();
			var end = $("#datepickerEnd").val();
			if(end=="")return;
			if(start > end){
				alert("开始时间必须小于结束时间");
				$("#datepickerEnd").val("");
			}
		});
    }
	
	function initUserList(pageIndex){
		var userName = $("#username").val();
		var email = $("#email").val();
		var telephone = $("#telephone").val();
		var roles = $("#roles").val();
		var status = $("#status").val();
    	var startDate = $("#datepickerStart").val();
    	var endDate = $("#datepickerEnd").val();
	    $.ajax({
			url:"${path}/users/userList",
			type: "POST",
			data:{	pageIndex:pageIndex+1,
					pageSize:pageSize,
					userName:userName,
					email:email,
					roles:roles,
					status:status,
					startDate:startDate,
					endDate:endDate
				 },
			dataType :"json",
			ifModified : true,
			success :function(data){
				new volidateLogin().isLogin(data.status,data.isLogin);
				$("#noData").remove();
				$("#hideTotalCount").val(data.totalNum);
				var users = data.users;
					$("#userListShow tr:gt(0)").remove(); //移除Id为Result的表格里的行，从第二行开始（这里根据页面布局不同页变）
					for (var i = 0; i < users.length; i++) {
						$("#userListShow").append("<tr><td>"+users[i].userName
								+"</td><td>"+users[i].email
								+"</td><td>"+users[i].roles
								+"</td><td>"+new DateConvert().LongToString(users[i].createTime, 'yyyy-MM-dd HH:mm:ss')
								+"</td><td>"+new DateConvert().LongToString(users[i].updateTime, 'yyyy-MM-dd HH:mm:ss')
								+"</td><td>"+new DateConvert().LongToString(users[i].lastloginTime, 'yyyy-MM-dd HH:mm:ss')
								+"</td><td>"+users[i].status
								+"</td><td><button class='btn btn-mini' id='userEdit' onclick='editUser("+'"'+users[i].id+'"'+")'><i class='icon-edit'></i>编辑</button>"
								+"<button class='btn btn-mini' id='userEdit' onclick='editUser("+'"'+users[i].id+'"'+")'><i class='icon-remove-sign'></i>删除</button>"
								+"</td></tr>") 
					}
					fnLoad();
					pageInit(pageIndex);
			},
			error:function(data){
				console.log(data);
				$("#noData").html("<center><h3>出错了！</h3></center");
				//pagination();
			}
		});  
	}
	
	//分页 
	function pageInit(pageIndex){
	   var totalCount = $("#hideTotalCount").val();
       $("#pagination").pagination(totalCount, {
           callback: pageselectCallback,//PageCallback() 为翻页调用次函数。
           prev_text: " 上一页",
           next_text: "下一页 ",
           maxentries:totalCount,
           items_per_page: pageSize, //每页的数据个数
           num_display_entries: 4, //两侧首尾分页条目数
           current_page: pageIndex,  //当前页码
           num_edge_entries: 3, //连续分页主体部分分页条目数
       });
	}
	
	function pageselectCallback(index, jq) {
		fnUnload();
		initUserList(index);
    }
	
	//新增用户 
	function addNewUsers(){
		$('#addUser').click(function() {
			/* $('#shclKeyframes').shCircleLoader({keyframes:"0%{background:black}40%{background:transparent}60%{background:transparent}100%{background:black}"}); */
			window.location.href = "${path}/views/User/add.jsp";
		});
	}
	//清空日期选择 
	function cleanDateEmpty(){
		$("#datepickerStart").val("");
    	$("#datepickerEnd").val("");
	}
	
	//条件查询  
	function submitSearch(){
		$('#submitSearch').click(function() {
			initUserList(pageIndex);
		});
	}
	
	function editUser(id){
		alert(id);
	}
		
 
</script>