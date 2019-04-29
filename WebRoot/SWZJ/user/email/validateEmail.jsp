<!DOCTYPE html>
<html>
<head>
<%
    //获取邮箱验证信息
	request.setCharacterEncoding("UTF-8");
	String _token = request.getParameter("_token");
	String operation = request.getParameter("operation");
    String email = request.getParameter("email");
    String account = request.getParameter("account");
    Integer user_id = Integer.valueOf(request.getParameter("id"));
    Long hqtime = Long.valueOf(request.getParameter("poke"));
    Long lag = (System.currentTimeMillis() - hqtime) / (1000 * 60);
%>
<%if(lag>60*24){%>
	<script>alert("该邮件已过期！");</script>
<%return;} %>
<%if(session.getAttribute("user") == null){session.setAttribute("user",new User().queryUserByID(user_id));}%>
<%@ page language="java" import="java.util.*,JZW.*,emailController.*" pageEncoding="utf-8"%>

<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<!-- 邮箱验证JS -->
<script src="/CSMS/ValidateJS/User/user_email.js"></script>

<style>
form input {
    appearance: none;
    outline: 0;
    border: 1px solid rgba(255, 255, 255, 0.4);
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 3px;
    padding: 10px 15px;
    margin: 0 auto 10px auto;
    display: block;
    text-align: center;
    -webkit-transition-duration: 0.25s;
    transition-duration: 0.25s;
}
form input:hover {
    background-color: rgba(255, 255, 255, 0.4);
}
form input:focus {
    background-color: white;
    width: 450px;
    color: #2B3743;
}
</style>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var user_email = checkUser_email();
		if(user_email){
			return true;
		}else{  
			return false;  
		}
	} 
</script>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<!-- 导航栏 -->
<% User user = new User().queryUserByID(((User)session.getAttribute("user")).getID());	List<Message> mesList = new Message().queryMessageOfNew(user.getID(),false);	int messageCount = mesList.size(); %>
<%if(!account.equals(user.getAccount())||user_id!=user.getID()||!_token.equals("lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV")){%>	<!-- 防止篡改url -->
	<script>alert("篡改URL是非法操作！")</script>
<% request.getSession().invalidate();return;} %>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="brand">
    	<a href="/CSMS/index.jsp"><img src="/CSMS/public/assets/img/logo-dark.png" alt="Klorofil Logo" class="img-responsive logo"></a>
    </div>
    <div class="container-fluid">
        <div class="navbar-btn">
            <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
        </div>
        <div id="navbar-menu">
        <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
		        <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
		            <i class="lnr lnr-alarm"></i>
		            <span class="badge bg-danger" id="alarm_count"><%= messageCount==0?"":messageCount %></span>
		        </a>
		        <ul class="dropdown-menu notifications" id="message_menu">
<%
	for(int i =0;i < messageCount;i++){
		out.print("<li><a href=\"/CSMS/SWZJ/message/myMessage.jsp?id="+mesList.get(i).getID()+"\" class=\"notification-item\"><span class=\"dot "+mesList.get(i).getType()+"\"></span>"+mesList.get(i).getSummary()+"</a></li>");
	}
	if(messageCount != 0){
		out.print("<li><a href=\"/CSMS/SWZJ/message/myMessage.jsp\" class=\"more\">查看所有通知</a></li>");
	}else{
		out.print("<li><a href=\"#\" class=\"more\">未收到通知</a></li>");
	}
%>
		        </ul>
	    	</li>
	        <li class="dropdown">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                <img src="/CSMS/public/assets/img/jzw.jpg" class="img-circle" alt="Avatar">
	                <span id="user_昵称">${user.getName()}</span>
	                <i class="icon-submenu lnr lnr-chevron-down"></i>
	            </a>
	            <ul class="dropdown-menu">
	                <li><a href="/CSMS/SWZJ/user/userCenter.jsp"><i class="lnr lnr-user"></i> <span>个人中心</span></a></li>
	                <!-- <li><a href="/CSMS/SWZJ/message/myMessage.jsp"><i class="lnr lnr-bubble"></i> <span>Message</span></a></li> -->
	                <li><a href="/CSMS/SWZJ/user/set/userSet.jsp" target="_blank"><i class="lnr lnr-cog"></i> <span>设置</span></a></li>
	                <li><a href="/CSMS/logout.jsp?user_id=${user.getID()}&user_name=${user.getName()}"><i class="lnr lnr-exit"></i> <span>注销</span></a></li>
	            </ul>
	        </li>
        </ul>
    	</div>
    </div>
</nav>
<!-- END 导航栏 -->
<!-- 左侧边栏 -->
<%@include file="/HTML/userLeftSidebar.html" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<div class="container">
	<div class="col-md-8 col-md-offset-2" style="padding: 100px 70px 0 70px;">
		<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
			<div class="panel-heading">
           		<h3 class="panel-title">邮箱验证通知</h3>
        	</div>
			<div class="panel-body">
			<% 
				switch(operation){
		    	case "bindEmail":%>
		    		<%if(user.updateUserEmail(user.queryUserByID(user_id), email)){%>
		    			<div>
							<h1>邮箱验证成功</h1><hr>
							<h3>您已成功绑定邮箱&ensp;<%= email %></h3>
						</div>
						<br><a class="btn btn-primary" href="/CSMS/SWZJ/user/userCenter.jsp" >转到个人中心</a>
		    		<% }else{%>
		    			<div>
							<h1>邮箱验证失败</h1><hr>
							<h3>遇到未知错误，绑定邮箱&ensp;<%= email %>&ensp;失败</h3>
						</div>
						<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
		    		<%}
		    		break;
		    	case "tobindEmail":
		    		if(email.equals(user.getEmail())){%>
		    			<form class="form-horizontal" role="form" method="post" action="/CSMS/SWZJ/user/email/tobindEmailDo.jsp" onsubmit="return checkAll()">
							<br>
							<div class="form-group" id="user_email_class">
								<label for="user_email" class="control-label"><a class="text-danger"></a>邮&ensp;箱</label><hr>
								<input type="text" class="form-control" id="user_email" name="user_email" 
								placeholder="请输入要改绑的邮箱" value="" autocomplete="off" onblur="checkUser_email()">
								<input type="hidden" name="tobin" value="1">
								<span id="user_email_span"></span>
							</div>
							<br>
							<div class="form-group">
								<button type="submit" title="发送验证邮件绑定邮箱" class="btn btn-primary">改绑邮箱</button>
							</div>	
						</form>
		    		<%}else{
						if(user.updateUserEmail(user.queryUserByID(user_id), email)){%>
			    			<div>
								<h1>邮箱验证成功</h1><hr>
								<h3>您已成功改绑邮箱&ensp;<%= email %></h3>
							</div>
							<br><a class="btn btn-primary" href="/CSMS/SWZJ/user/userCenter.jsp" >转到个人中心</a>
			    		<% }else{%>
			    			<div>
								<h1>邮箱验证失败</h1><hr>
								<h3>遇到未知错误，改绑邮箱&ensp;<%= email %>&ensp;失败</h3>
							</div>
							<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
			    		<%}
		    		}
		    		break;
		    	case "unbindEmail":
		    		if(user.updateUserEmail(user.queryUserByID(user_id), "")){%>
		    			<div>
							<h1>邮箱验证成功</h1><hr>
							<h3>您已成功解绑邮箱&ensp;<%= email %></h3>
						</div>
						<br><a class="btn btn-primary" href="/CSMS/SWZJ/user/userCenter.jsp" >转到个人中心</a>
		    		<% }else{%>
		    			<div>
							<h1>邮箱验证失败</h1><hr>
							<h3>遇到未知错误，解绑邮箱&ensp;<%= email %>&ensp;失败</h3>
						</div>
						<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
		    		<%}
		    		break;
			    }
			%>
           	</div>
		</div>
	</div>
</div>

</div>
<!-- END MAIN CONTENT -->
</div>
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/HTML/foot.html" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/HTML/javaScript.html" %>

</body>
</html>
