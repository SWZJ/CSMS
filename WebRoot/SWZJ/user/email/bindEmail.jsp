<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
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
<%@include file="/CommonView/navbar.jsp" %>
<!-- END 导航栏 -->
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
           		<h3 class="panel-title">邮箱绑定</h3>
        	</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" method="post" action="/CSMS/SWZJ/user/email/bindEmailDo.jsp" onsubmit="return checkAll()">
					<br>
					<div class="form-group" id="user_email_class">
						<%if(user.getEmail()!=null&&user.getEmail().length()!=0){%>
							<h3>您已绑定邮箱&ensp;<%=user.getEmail() %></h3>
						<%}else{ %>
							<label for="user_email" class="control-label"><a class="text-danger"></a>邮&ensp;箱</label><hr>
							<input type="text" class="form-control" id="user_email" name="user_email" 
							placeholder="请输入邮箱" value="" autocomplete="off" onchange="checkUser_email()"
							oninput="Inputing(document.getElementById('user_email_span'),document.getElementById('user_email_class'))">
							<span id="user_email_span"></span>
						<%} %>
					</div>
					<br>
					<div class="form-group">
						<%if(user.getEmail()!=null&&user.getEmail().length()!=0){%>
						<a href="unbindEmail.jsp" title="转到邮箱解绑页面" type="button" class="btn btn-primary">邮箱解绑</a>
						<%}else{ %>
						<button type="submit" title="发送验证邮件绑定邮箱" class="btn btn-primary">绑定邮箱</button>
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
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>

</body>
</html>