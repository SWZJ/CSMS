<%@ page language="java" import="java.util.*,JZW.*,java.net.URLDecoder" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<!-- 账号验证JS -->
<script src="/CSMS/ValidateJS/User/user_account.js"></script>
<!-- 密码验证JS -->
<script src="/CSMS/ValidateJS/User/user_password.js"></script>
<!-- 用户名验证JS -->
<script src="/CSMS/ValidateJS/User/user_name.js"></script>
<!-- 授权码验证JS -->
<script src="/CSMS/ValidateJS/User/user_authCode.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var user_account = checkUser_account();
		var user_password = checkUser_password();
		var user_name = checkUser_name();
		var user_authCode = checkUser_authCode();
		if(user_account&&user_password&&user_name&&user_authCode){
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
           		<h3 class="panel-title">用户注册</h3>
        	</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" method="post" action="logonDo.jsp" onsubmit="return checkAll()">
				
					<br>
					<div class="form-group" id="user_account_class">
						<label for="user_account" class="col-sm-2 control-label"><a class="text-danger">*</a>账号</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="user_account" name="user_account" 
							placeholder="账号（6~18位字符,只能包含英文字母、数字、下划线）" value="" onblur="checkUser_account()">
							<span id="user_account_span"></span>
						</div>
					</div>
					
					<div class="form-group" id="user_password_class">
						<label for="user_password" class="col-sm-2 control-label"><a class="text-danger">*</a>密码</label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="user_password" name="user_password" 
							placeholder="密码（6~18位字符,必须包含数字、字母或特殊字符其中两项）" value="" onblur="checkUser_password()">
							<span id="user_password_span"></span>
						</div>
						<img id="eyeImg" onclick="hideShowPsw()" height="35" width="35" src="/CSMS/public/assets/img/invisible.png" alt="密码是否可见">
					</div>
					
					<div class="form-group" id="user_name_class">
						<label for="user_name" class="col-sm-2 control-label"><a class="text-danger">*</a>用户名</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="user_name" name="user_name" 
							placeholder="用户名（只能为汉字、字母或数字，长度为2-5）" value="" onblur="checkUser_name()">
							<span id="user_name_span"></span>
						</div>
					</div>
					
					<div class="form-group" id="user_authCode_class">
						<label for="user_authCode" class="col-sm-2 control-label"><a class="text-danger"></a>授权码</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="user_authCode" name="user_authCode" 
							placeholder="授权码（用于注册超级管理员，不填写授权码则默认注册为教师）" value="" onblur="checkUser_authCode()">
							<span id="user_authCode_span"></span>
						</div>
					</div>
					
					<div class="form-group">
						<button type="submit" class="btn btn-primary">注册</button>
						<a class="btn btn-primary" href="#" onClick="history.back(-1)">取消</a>
					</div>
					
					<p>注册即代表您已同意<a href="/CSMS/SWZJ/user/userAgreement.jsp">《神葳总局用户协议》</a><a href="/CSMS/SWZJ/user/privacyPolicy.jsp">《神葳总局隐私政策》</a></p>
					<br><br>
					<div class="form-group">
						<h3><strong>说 明</strong></h3><hr>
						<p><span style="color:#00A0F0">授权码：</span>通过神葳总局获得，使用正确的授权码注册的用户将拥有<span style="color:#D4AF37">超级管理员</span>权限。</p>
						<h4>用户权限等级</h4>
						<p><span style="color:#884898">学生：</span>可选择、退选课题，上传课题报告，下载选择的课题所属教师发布的课题要求文档。</p>
						<p><span style="color:#E308E4">教师：</span>可创建并管理自己的课题，上传课题要求，查看选题学生以及下载学生上传的课题报告。</p>
						<p>教师职称等级分为助教、讲师、副教授、教授和博士生导师，不同等级所拥有的课题数量不同。</p>
						<p><span style="color:#D4AF37">超级管理员：</span>可管理所有<span style="color:#884898">学生</span>、<span style="color:#E308E4">教师</span>、课题、班级、专业、学院信息以及课题的审核。</p>
					</div>
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
    function hideShowPsw(){
        if (passwordInput.type == "password") {
            passwordInput.type = "text";
            eyeImg.src = "/CSMS/public/assets/img/visible.png";
        }else {
            passwordInput.type = "password";
            eyeImg.src = "/CSMS/public/assets/img/invisible.png";
        }
    }
</script>

</body>

</html>