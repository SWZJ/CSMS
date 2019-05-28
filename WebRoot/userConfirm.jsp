<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html class="fullscreen-bg">
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

</head>

<body>
	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box lockscreen clearfix">
					<div class="content">
						<!-- <div class="logo text-center"><img src="/CSMS/public/assets/img/logo-dark.png" alt="Klorofil Logo"></div> -->
						<div class="logo text-center"><h3 style="text-align:center">这是危险操作需要验证密码</h3></div><hr>
						<div class="user text-center">
							<img src="/CSMS/public/userAvatar/${user.getID()}.jpg?temp=<%=Math.random()%>" class="img-circle" alt="Avatar" width="100" height="100"
							onerror="this.src='/CSMS/public/userAvatar/<%=user.getRoot()==0?new Student().queryStudentByID(user.getStudentID()).getSex():"未知"%>.jpg';this.onerror=null">
							<h2 class="name">${user.getName() }</h2>
						</div>
						<form action="#" method="post" >
							<div class="input-group">
								<input type="password" class="form-control" placeholder="输入你的密码...">
								<span class="input-group-btn"><button type="submit" class="btn btn-primary"><i class="fa fa-arrow-right"></i></button></span>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
</body>

</html>
