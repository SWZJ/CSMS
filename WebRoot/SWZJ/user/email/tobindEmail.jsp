<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

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
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>

</body>
</html>
