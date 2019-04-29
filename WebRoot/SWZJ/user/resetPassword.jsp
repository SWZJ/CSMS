<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<%
User user = new User();
//获取上一个页面传递过来的数据
request.setCharacterEncoding("UTF-8");
String user_account = request.getParameter("user_account")==null?"":request.getParameter("user_account");
if(user_account.equals(""))	return;
user = user.queryUserByAccount(user_account);
/* String code = request.getParameter("code")==null?"":request.getParameter("code");
if(!code.equals(session.getAttribute("code"))){
	out.print("<script>alert(\"验证码错误！\");window.history.back(-1);</script>");return;
} */

%>
<!-- 密码验证 -->
<!-- 密码验证JS -->
<script src="/CSMS/ValidateJS/User/user_password.js"></script>
<script>
function checkUser_passwords(){
	var field = document.getElementById("user_password").value;
    var field2 = document.getElementById("user_passwords").value;
    var spanNode = document.getElementById("user_passwords_span");
	if(field!=field2){
		spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_passwords\">两次密码不相同！</label>";  
        document.getElementById("user_passwords_class").className = "form-group has-error";    
        return false;
	}else{
        spanNode.innerHTML = "";  
        document.getElementById("user_passwords_class").className = "form-group";   
        return true;  
	}
}
</script>
<!-- 表单验证 -->
<script>
	function checkAll(){
		var user_password = checkUser_password();  
		if(user_password){
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
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="brand">
		<a href="/CSMS/login.jsp"><img src="/CSMS/public/assets/img/logo-dark.png" alt="Klorofil Logo" class="img-responsive logo"></a>
	</div>
	<div class="container-fluid">
		<div id="navbar-menu">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="/CSMS/login.jsp">登录</a></li>
				<li><a href="/CSMS/SWZJ/user/logon.jsp">注册</a></li>
			</ul>
		</div>
	</div>
</nav>
<!-- END 导航栏 -->

<!-- 内容区域 -->
<!-- MAIN CONTENT -->
<div class="main-content">

<div class="container">
	<div class="col-md-8 col-md-offset-2">
		<div class="panel panel-default" style="text-align:center">
			<div class="panel-heading">
           		<h3 class="panel-title">重置密码</h3>
        	</div>
			<div class="panel-body">
				<form id="form" class="form-horizontal" role="form" method="post" action="resetPasswordDo.jsp" onsubmit="return checkAll()">
				
					<br>
					<div class="form-group" id="user_password_class">
						<label for="user_password" class="col-sm-2 control-label"><a class="text-danger">*</a>密码</label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="user_password" name="user_password" 
							placeholder="请输入新密码" value="" oninput="checkUser_password()">
							<span id="user_password_span"></span>
						</div>
						<img id="eyeImg" onclick="hideShowPsw()" height="35" width="35" src="/CSMS/public/assets/img/invisible.png" alt="密码是否可见">
					</div>
					
					<div class="form-group" id="user_passwords_class">
						<label for="user_passwords" class="col-sm-2 control-label"><a class="text-danger">*</a>重复密码</label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="user_passwords" name="user_passwords" 
							placeholder="请再次输入密码" value="" oninput="checkUser_passwords()">
							<span id="user_passwords_span"></span>
						</div>
					</div>
					
					<input type="hidden" name="id" value="<%=user.getID() %>">
					<div class="form-group">
						<button type="submit" class="btn btn-primary">提交</button>
					</div>
					
					<p>使用即代表您已同意<a href="/CSMS/SWZJ/user/userAgreement.jsp">《神葳总局用户协议》</a><a href="/CSMS/SWZJ/user/privacyPolicy.jsp">《神葳总局隐私政策》</a></p>
					
				</form>
           	</div>
		</div>
	</div>
</div>

</div>
<!-- END MAIN CONTENT -->
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/HTML/foot.html" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/HTML/javaScript.html" %>
<script type="text/javascript">
    var eyeImg = document.getElementById("eyeImg");
    var passwordInput = document.getElementById("user_password");
    var passwordInput2 = document.getElementById("user_passwords");
    function hideShowPsw(){
        if (passwordInput.type == "password") {
            passwordInput.type = "text";
            passwordInput2.type = "text";
            eyeImg.src = "/CSMS/public/assets/img/visible.png";
        }else {
            passwordInput.type = "password";
            passwordInput2.type = "password";
            eyeImg.src = "/CSMS/public/assets/img/invisible.png";
        }
    }
</script>

</body>
</html>
