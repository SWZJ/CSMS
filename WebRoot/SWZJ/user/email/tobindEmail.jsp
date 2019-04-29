<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var email = document.getElementById("user_email").value;
		if(email==null||email.length==0){
			return false;
		}else{  
			return true;  
		}
	}
</script>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<!-- 导航栏 -->
<% User user = new User().queryUserByID(((User)session.getAttribute("user")).getID());	List<Message> mesList = new Message().queryMessageOfNew(user.getID(),false);	int messageCount = mesList.size(); %>
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
           		<h3 class="panel-title">邮箱改绑</h3>
        	</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" method="post" action="/CSMS/SWZJ/user/email/tobindEmailDo.jsp" onsubmit="return checkAll()">
					<br>
					<div class="form-group" id="user_email_class">
						<%if(user.getEmail()!=null&&user.getEmail().length()!=0){%>
							<h3>您已绑定邮箱&ensp;<%=user.getEmail() %></h3>
							<input type="hidden" id="user_email" name="user_email" value="<%= user.getEmail() %>">
						<%}else{ %>
							<h3>您还未绑定邮箱</h3>
						<%} %>
					</div>
					<br>
					<div class="form-group">
						<%if(user.getEmail()!=null&&user.getEmail().length()!=0){%>
						<button type="submit" title="发送验证邮件改绑邮箱" class="btn btn-primary">改绑邮箱</button>
						<%}else{ %>
						<a href="bindEmail.jsp" title="转到邮箱绑定页面" type="button" class="btn btn-primary">邮箱绑定</a>
						<%} %>
					</div>
				</form>
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
