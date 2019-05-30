<!DOCTYPE html>
<html>
<head>
<%
    //获取邮箱验证信息
	request.setCharacterEncoding("UTF-8");
	String _token = request.getParameter("_token")==null?"":request.getParameter("_token");
	String operation = request.getParameter("operation")==null?"":request.getParameter("operation");
    String email = request.getParameter("email")==null?"":request.getParameter("email");
    String account = request.getParameter("account")==null?"":request.getParameter("account");
    Integer user_id = request.getParameter("id")==null?0:Integer.valueOf(request.getParameter("id"));
    Long hqtime = request.getParameter("poke")==null?0:Long.valueOf(request.getParameter("poke"));
    Long lag = (System.currentTimeMillis() - hqtime) / (1000 * 60);
%>
<%if(lag>60*24){%>
	<script>alert("该邮件已过期！");</script>
<%return;} %>
<%if(session.getAttribute("user") == null){session.setAttribute("user",new User().queryUserByID(user_id));}%>
<%@ page language="java" import="java.util.*,JZW.*,emailController.*" pageEncoding="utf-8"%>

<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

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
<%if(!account.equals(user.getAccount())||user_id!=user.getID()||!_token.equals("lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV")){%>	<!-- 防止篡改url -->
	<script>alert("篡改URL是非法操作！")</script>
<% request.getSession().invalidate();return;} %>
<%@include file="/CommonView/navbar.jsp" %>
<!-- 左侧边栏 -->
<%@include file="/CommonView/userLeftSidebar.jsp" %>

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
								placeholder="请输入要改绑的邮箱" value="" autocomplete="off" onchange="checkUser_email()"
								oninput="Inputing(document.getElementById('user_email_span'),document.getElementById('user_email_class'))">
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
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>

</body>
</html>
