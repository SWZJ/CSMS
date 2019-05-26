<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>
<!-- 密码验证JS -->
<script src="/CSMS/ValidateJS/User/user_password.js"></script>
<!-- 验证两次密码是否相同 -->
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
		var user_passwords = checkUser_passwords();  
		if(user_password&&user_passwords){
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
<!-- 左侧边栏 -->
<%@include file="/CommonView/userLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
        
     <div class="container">
		<div class="col-md-8 col-md-offset-2" style="padding: 50px 0px 0 0px;">
			<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
				<div class="panel-heading">
					<h3 class="panel-title">修改密码</h3>
				</div>
				<div class="panel-body">
				
					<!-- 填写原密码 -->
					<form id="oldform" class="form-horizontal">
						<h4>第一步：填写原密码</h4><hr>
						<br>
						<div class="form-group" id="oldpassword_class">
							<label for="oldpassword" class="col-sm-2 control-label"><a class="text-danger">*</a>原密码</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="oldpassword" name="oldpassword" value="" placeholder="请输入原密码"
								onkeypress="if(event.keyCode==13) {oldbtn.click();return false;}"
								oninput="Inputing(document.getElementById('oldpassword_span'),document.getElementById('oldpassword_class'))">
								<span id="oldpassword_span"></span>
							</div>
						</div>

						<br>
						<div class="form-group">
							<button type="button" class="btn btn-primary" id="oldbtn">提交</button>
						</div>
					</form>

					<!-- 填写新密码 -->
					<form id="newForm" class="form-horizontal" style="display: none;" method="post" action="updatePasswordDo.jsp?id=<%=user.getID()%>" onsubmit="return checkAll();">
						<h4>第二步：填写新密码</h4><hr>
	
						<div class="form-group" id="user_password_class">
							<label for="user_password" class="col-sm-2 control-label"><a class="text-danger">*</a>新密码</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="user_password" name="user_password" placeholder="6~18位字符,必须包含数字、字母或特殊字符其中两项及以上"
								 value="" oninput="checkUser_password()">
								<span id="user_password_span"></span>
							</div>
							<img id="eyeImg" onclick="hideShowPsw()" height="35" width="35" src="/CSMS/public/assets/img/invisible.png" alt="密码是否可见">
						</div>
					
						<br>
						<div class="form-group" id="user_passwords_class">
							<label for="user_passwords" class="col-sm-2 control-label"><a class="text-danger">*</a>重复密码</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="user_passwords" name="user_passwords" placeholder="请再次输入密码"
								 value="" oninput="checkUser_passwords()" onkeypress="if(event.keyCode==13) {resetBtn.click();return false;}">
								<span id="user_passwords_span"></span>
							</div>
						</div>
					
						<br>
						<div class="form-group">
							<button type="submit" class="btn btn-primary" id="resetBtn">修改密码</button>
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
<!-- 判断原密码是否正确 -->
<script>
	$("#oldbtn").click(function() {
		if($("#oldpassword").val()=='<%=user.getPassword()%>'){
			$("#oldform").slideToggle();
			$("#newForm").slideToggle();
		}else{
			$("#oldpassword_span").html("<label class=\"control-label text-danger\" for=\"oldpassword\">原密码错误！</label>")
			$("#oldpassword_class").attr("class","form-group has-error");
		}
	});
</script>
<!-- 密码是否可见 -->
<script type="text/javascript">
function hideShowPsw(){
	var eyeImg = document.getElementById("eyeImg");
	var passwordInput = document.getElementById("user_password");
	var passwordInput2 = document.getElementById("user_passwords");
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