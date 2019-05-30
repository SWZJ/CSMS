<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<!-- 密码验证JS -->
<script src="/CSMS/ValidateJS/User/user_password.js"></script>
<!-- 密保问题答案验证JS -->
<script src="/CSMS/ValidateJS/User/user_answer.js"></script>
<!-- 邮箱验证码验证JS -->
<script src="/CSMS/ValidateJS/User/user_email.js"></script>
<!-- 手机验证码验证JS -->
<script src="/CSMS/ValidateJS/User/user_phone.js"></script>
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
	<div class="col-md-8 col-md-offset-2" style="padding: 100px 0 0 0;">
		<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
			<div class="panel-heading">
				<h3 class="panel-title">找回密码</h3>
			</div>
			<div class="panel-body">
				<!-- 填写账号 -->
				<form id="accountForm" class="form-horizontal">
					<h4>第一步：填写账号</h4><hr>
					<div class="form-group" id="user_account_class">
						<label for="user_account" class="col-sm-2 control-label"><a class="text-danger">*</a>账号</label>
						<div class="col-sm-9">
							<input type="text" autocomplete="off" class="form-control" id="user_account" name="user_account" placeholder="请输入需要找回密码的账号"
							 onkeypress="if(event.keyCode==13) {accountbtn.click();return false;}" value=""
							 oninput="Inputing(document.getElementById('user_account_span'),document.getElementById('user_account_class'))">
							<span id="user_account_span"></span>
						</div>
					</div>
					<br>
					<div class="form-group">
						<button type="button" class="btn btn-primary" id="accountbtn">提交</button>
						<a class="btn btn-primary" href="#" onClick="history.back(-1)">取消</a>
					</div>
				</form>
				<!-- 选择验证方式 -->
				<form id="modeForm" class="form-horizontal" style="display:none">
					<h4>第二步：选择验证方式</h4><hr>
					<div class="form-group" id="selectMode_class">
	                    <label for="selectMode" class="col-sm-2 control-label"><a class="text-danger">*</a>验证方式</label>
	                    <div class="col-sm-9">
	                        <select class="form-control" id="selectMode" name="selectMode">
		                        <option value = "0" id="default_mode">--请选择验证方式--</option>
		                        <option value = "1" id="user_question_mode" style="display:none">密保问题验证</option>
	                          	<option value = "2" id="user_email_mode" style="display:none"></option>
								<option value = "3" id="user_phone_mode" style="display:none"></option>
	                        </select>
	                        <span id="selectMode_span"></span>
						</div>
					</div>
					<br>
					<div class="form-group">
						<a class="btn btn-primary" href="#" onClick="history.back(-1)">取消</a>
					</div>
				</form>
				<!-- 密保问题验证 -->
				<form id="questionForm" class="form-horizontal" style="display:none">
					<h4>第三步：填写验证信息</h4><hr>
					<div class="form-group" id="user_answer_class">
						<p>密保问题：<span id="user_question"></span></p>
						<label for="user_answer" class="col-sm-2 control-label"><a class="text-danger">*</a>答案</label>
						<div class="col-sm-9">
							<input type="hidden" name="answer" id="answer" value="">
							<input type="text" class="form-control" id="user_answer" name="user_answer"  onkeypress="if(event.keyCode==13) {answerBtn.click();return false;}"
							placeholder="填写密保问题答案" value="" autocomplete="off" 
							oninput="Inputing(document.getElementById('user_answer_span'),document.getElementById('user_answer_class'))">
							<span id="user_answer_span"></span>
						</div>
					</div>
					<br>
					<div class="form-group">
						<button type="button" class="btn btn-primary" id="answerBtn">提交</button>
						<button type="button" class="btn btn-primary" id="backMode1">返回</button>
					</div>
				</form>
				<!-- 邮箱验证 -->
				<form id="emailForm" class="form-horizontal" style="display:none">
					<h4>第三步：填写验证信息</h4><hr>
					<div class="form-group" id="emailcode_class">
						<label for="emailcode" class="col-sm-2 control-label"><a class="text-danger">*</a>验证码</label>
						<div class="col-md-9 col-sm-9 col-lg-9">
							<div class="input-group">
								<input type="hidden" name="email_code" id="email_code" value="">
								<input type="text" class="form-control" id="emailcode" name="emailcode" disabled="disabled" onkeypress="if(event.keyCode==13) {emailBtn.click();return false;}"
								placeholder="填写邮箱验证码" value="" autocomplete="off" 
								oninput="Inputing(document.getElementById('emailcode_span'),document.getElementById('emailcode_class'))">
								<span class="input-group-btn"><button type="button" class="btn btn-primary" id="emailcodeBtn">免费获取验证码</button></span>
							</div>
							<span id="emailcode_span"></span>
						</div>
					</div>
					<br>
					<div class="form-group">
						<button type="button" class="btn btn-primary" id="emailBtn">提交</button>
						<button type="button" class="btn btn-primary" id="backMode2">返回</button>
					</div>
				</form>
				<!-- 手机短信验证 -->
				<form id="phoneForm" class="form-horizontal" style="display:none">
					<h4>第三步：填写验证信息</h4><hr>
					<div class="form-group" id="phonecode_class">
						<label for="phonecode" class="col-sm-2 control-label"><a class="text-danger">*</a>验证码</label>
						<div class="col-md-9 col-sm-9 col-lg-9">
							<div class="input-group">
								<input type="hidden" name="phone_code" id="phone_code" value="">
								<input type="text" class="form-control" id="phonecode" name="phonecode" disabled="disabled" onkeypress="if(event.keyCode==13) {phoneBtn.click();return false;}"
								placeholder="填写手机短信验证码" value="" autocomplete="off" 
								oninput="Inputing(document.getElementById('phonecode_span'),document.getElementById('phonecode_class'))">
								<span class="input-group-btn"><button type="button" class="btn btn-primary" id="phonecodeBtn">免费获取验证码</button></span>
							</div>
							<span id="phonecode_span"></span>
						</div>
					</div>
					<br>
					<div class="form-group">
						<button type="button" class="btn btn-primary" id="phoneBtn">提交</button>
						<button type="button" class="btn btn-primary" id="backMode3">返回</button>
					</div>
				</form>
				<!-- 填写新密码 -->
				<form id="passwordForm" class="form-horizontal" style="display: none;">
					<h4>第三步：填写新密码</h4><hr>

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
						<button type="button" class="btn btn-primary" id="resetBtn">重置密码</button>
					</div>
				</form>
				
				<p>使用即代表您已同意<a href="/CSMS/SWZJ/user/userAgreement.jsp">《神葳总局用户协议》</a><a href="/CSMS/SWZJ/user/privacyPolicy.jsp">《神葳总局隐私政策》</a></p>
           	</div>
		</div>
	</div>
</div>

</div>
<!-- END MAIN CONTENT -->
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>
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
<!-- 输入框切换 -->
<script>
//判断账号是否存在
$("#accountbtn").click(function() {
	var user_account = $("#user_account").val();
	if(user_account.length==0){
		$("#user_account_span").html("<label class=\"control-label text-danger\" for=\"user_account\">账号不能为空！</label>");
		$("#user_account_class").attr("class","form-group has-error");
		return;
	}
	$.ajax({
		type:"post",
		url:"/CSMS/manageInfo/UserIsAccountExist",
		datatype: "json",
		async:false,
		data:{
			"user_account":user_account,
		},
		success:function(result) {
			var r = JSON.parse(result);
			if(r.isExist==true){//账号存在
				var user = r.user;
				if((user.user_question==null||user.user_question.length==0)&&(user.user_email==null||user.user_email.length==0)&&(user.user_phone==null||user.user_phone.length==0)){
					$("#default_mode").html("您没有可用的验证方式！请联系管理员。");
				}else{
					if(user.user_question!=null&&user.user_question.length!=0){
						$("#answer").val(user.user_answer);
						$("#user_question_mode").show();
					}
					if(user.user_email!=null&&user.user_email.length!=0){
						$("#user_email_mode").show();
						$("#user_email_mode").html("邮箱验证&emsp;&emsp;&emsp;&emsp;"+HideEmail(user.user_email));
					}
					if(user.user_phone!=null&&user.user_phone.length!=0){
						$("#user_phone_mode").show();
						$("#user_phone_mode").html("手机短信验证&emsp;&emsp;"+HidePhone(user.user_phone));
					}
				}
				$("#accountForm").slideToggle();
				$("#modeForm").slideToggle();
			}else{//账号不存在。
				$("#user_account_span").html("<label class=\"control-label text-danger\" for=\"user_account\">账号 "+user_account+" 不存在！</label>");
				$("#user_account_class").attr("class","form-group has-error");
				return;
			}
		},
		error:function(){
			alert("回调出错！");
		}
	});
});

//判断选择的验证方式
$("#selectMode").change(function(){
    if($("#selectMode").val()==1){
    	$("#modeForm").slideToggle();
		$("#questionForm").slideToggle();
    }
    if($("#selectMode").val()==2){
    	$("#modeForm").slideToggle();
		$("#emailForm").slideToggle();
    }
    if($("#selectMode").val()==3){
    	$("#modeForm").slideToggle();
		$("#phoneForm").slideToggle();
    }
});
//返回验证方式选择框
$("#backMode1").click(function(){
	$("#modeForm").slideToggle();
	$("#questionForm").slideToggle();
	$("#selectMode").val(0);
});
$("#backMode2").click(function(){
	$("#modeForm").slideToggle();
	$("#emailForm").slideToggle();
	$("#selectMode").val(0);
});
$("#backMode3").click(function(){
	$("#modeForm").slideToggle();
	$("#phoneForm").slideToggle();
	$("#selectMode").val(0);
});

//判断密保问题答案是否正确
$("#answerBtn").click(function() {
	var answer = checkUser_answer();
	if(answer == false)	return;
	$("#questionForm").slideToggle();
	$("#passwordForm").slideToggle();
});
//判断邮箱验证码是否正确
$("#emailBtn").click(function() {
	var email = checkEmailCode();
	if(email == false)	return;
	$("#emailForm").slideToggle();
	$("#passwordForm").slideToggle();
});
//判断手机验证码是否正确
$("#phoneBtn").click(function() {
	var phone = checkPhoneCode();
	if(phone == false)	return;
	$("#phoneForm").slideToggle();
	$("#passwordForm").slideToggle();
});
	
//判断是否成功重置密码
$("#resetBtn").click(function(){
	var password = checkAll();
	if(password == false) return;
	var user_account = $("#user_account").val();
	$.ajax({
		type:"post",
		url:"/CSMS/manageInfo/UserResetPassword",
		datatype: "json",
		async:false,
		data:{
			"user_account":user_account,
			"user_password":$("#user_password").val(),
		},
		success:function(result) {
			var r = JSON.parse(result);
			if(r.isOK==true){//重置密码成功
				alert(r.successMes);
				window.location.href="/CSMS/login.jsp";
			}else{//重置密码失败
				alert(r.errorMes);
			}
		},
		error:function(){
			alert("回调出错！");
		}
	});
});
</script>
<!-- 验证码倒计时 -->
<script>
var countdown = 120;
/* 发送邮箱验证码 */
$('#emailcodeBtn').on('click',function(){
	settime($('#emailcodeBtn'));
	document.getElementById("emailcode_class").className = "form-group";
	$("#emailcode_span").html("<label class=\"control-label text-primary left\" for=\"emailcode\">邮件正在发送中。。。</label>");
	var user_account = $("#user_account").val();
	$.ajax({
		type:"post",
		url:"/CSMS/code/EmailCode",
		datatype: "json",
		async:true,
		data:{
			"user_account":user_account,
		},
		success:function(result) {
			var r = JSON.parse(result);
			if(r.isSend==true){//邮箱验证码发送成功
				$("#emailcode_span").html("<label class=\"control-label text-success left\" for=\"emailcode\">"+r.successMes+"</label>");
				$("#email_code").val(r.code);
				$("#emailcode").attr('disabled', false);
			}else{//发送失败
				$("#emailcode_span").html("<label class=\"control-label text-danger left\" for=\"emailcode\">"+r.errorMes+"</label>");
			}
		},
		error:function(){
			alert("回调出错！");
		}
	});
})
/* 发送手机验证码 */
$('#phonecodeBtn').on('click',function(){
	settime($('#phonecodeBtn'));
	document.getElementById("phonecode_class").className = "form-group";
	$("#phonecode_span").html("<label class=\"control-label text-primary left\" for=\"emailcode\">短信正在发送中。。。</label>");
	var user_account = $("#user_account").val();
	$.ajax({
		type:"post",
		url:"/CSMS/code/PhoneCode",
		datatype: "json",
		async:true,
		data:{
			"user_account":user_account,
		},
		success:function(result) {
			var r = JSON.parse(result);
			if(r.isSend==true){//手机验证码发送成功
				$("#phonecode_span").html("<label class=\"control-label text-success left\" for=\"phonecode\">"+r.successMes+"</label>");
				$("#phone_code").val(r.code);
				$("#phonecode").attr('disabled', false);
			}else{//发送失败
				$("phonecode_span").html("<label class=\"control-label text-danger left\" for=\"phonecode\">"+r.errorMes+"</label>");
			}
		},
		error:function(){
			alert("回调出错！");
		}
	});
})
function settime(obj) { //发送验证码倒计时
if (countdown == 0) {
	obj.attr('disabled', false);
	obj.html("免费获取验证码");
	countdown = 120;
	return;
} else {
	$("#backMode1,#backMode2,#backMode3").attr('disabled', true);
	obj.attr('disabled', true);
	obj.html("重新发送(" + countdown + ")");
	countdown--;
}
setTimeout(function () {settime(obj)}, 1000)
}
</script>

</body>
</html>
