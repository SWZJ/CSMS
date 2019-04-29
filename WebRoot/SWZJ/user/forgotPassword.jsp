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
user = user.queryUserByAccount(user_account);
request.setAttribute("user",user);
boolean isExist_account = !user_account.equals("")&&user.getID()==0?false:true;
Integer selectMode = request.getParameter("selectMode")==null||!isExist_account?0:Integer.valueOf(request.getParameter("selectMode"));
String code = request.getParameter("code")==null?"":request.getParameter("code");
String answer = request.getParameter("user_answer")==null?"":request.getParameter("user_answer");

String sendCode = request.getParameter("sendCode")==null?"":request.getParameter("sendCode");

%>

<!-- 账号验证JS -->
<script>
function checkUser_account(){
    var field = document.getElementById("user_account").value;
    var spanNode = document.getElementById("user_account_span");
	if(field.length == 0){
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_account\">账号不能为空！</label>";  
        document.getElementById("user_account_class").className = "form-group has-error";    
        return false;
	}else{
	    spanNode.innerHTML = "";  
	    document.getElementById("user_account_class").className = "form-group";   
	    return true;
	}
}
</script>
<!-- 邮箱验证码验证JS -->
<script>
function checkCode(){
    var field = document.getElementById("code").value;
    var spanNode = document.getElementById("code_span");
	if(field.length == 0){
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"code\">验证码不能为空！</label>";  
        document.getElementById("code_class").className = "form-group has-error";    
        return false;
	}else{
		var code = '${code}';
		if(code!=null&&field!=code){
			spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"code\">验证码错误！</label>";  
	        document.getElementById("code_class").className = "form-group has-error";    
	        return false;
		}else{
			spanNode.innerHTML = "";  
	        document.getElementById("code_class").className = "form-group";   
	        return true;
		}
	}
}
</script>
<!-- 密保答案验证JS -->
<script>
	function checkUser_answer(){
    var field = document.getElementById("user_answer").value;
    var spanNode = document.getElementById("user_answer_span");
	if(field.length == 0){
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_answer\">密保答案不能为空！</label>";  
        document.getElementById("user_answer_class").className = "form-group has-error";    
        return false;
	}else{
		var answer = '${user.getAnswer()}';
		if(field!=answer){
			spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_answer\">答案错误！</label>";  
	        document.getElementById("user_answer_class").className = "form-group has-error";    
	        return false;
		}else{
			spanNode.innerHTML = "";  
	        document.getElementById("user_answer_class").className = "form-group";   
	        return true;
		}
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
           		<h3 class="panel-title">找回密码</h3>
        	</div>
			<div class="panel-body">
				<form id="form" class="form-horizontal" role="form" method="post" action="">
				
					<h4>第一步：填写账号</h4><hr>
					<div class="form-group" id="user_account_class">
						<label for="user_account" class="col-sm-2 control-label"><a class="text-danger">*</a>账号</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="user_account" name="user_account" 
							placeholder="请输入要找回密码的账号" value="<%=user_account %>" oninput="checkUser_account()">
							<span id="user_account_span"></span>
						</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary" onclick="return checkUser_account();">验证</button>
						<a class="btn btn-primary" href="#" onClick="history.back(-1)">取消</a>
					</div>
					<p>验证即代表您已同意<a href="/CSMS/SWZJ/user/userAgreement.jsp">《神葳总局用户协议》</a><a href="/CSMS/SWZJ/user/privacyPolicy.jsp">《神葳总局隐私政策》</a></p>
					
					<br><div id="selectModeDiv" style="display:none">
						<h4>第二步：选择验证方式</h4><hr>
						<div class="form-group" id="selectMode_class">
		                    <label for="selectMode" class="col-sm-2 control-label"><a class="text-danger"></a>验证方式</label>
		                    <div class="col-sm-9">
		                        <select class="form-control" id="selectMode" name="selectMode">
		                        	<%if(user.getEmail().length()==0&&user.getQuestion().length()==0){%>
		                        	<option value = "0">您没有可用的验证方式！请联系管理员。</option>
		                        	<%}else{%>
			                        <option value = "0">--请选择验证方式--</option>
			                        <%}%>
			                        <%if(user.getEmail().length()!=0){ %><option value = "1">邮箱验证</option><%}%>
									<%if(user.getQuestion().length()!=0){ %><option value = "2">密保问题验证</option><%}%>
		                        </select>
		                        <span id="selectMode_span"></span>
							</div>
						</div>
					</div>
					
					<br>
					<div id="writeModeDiv1" style="display:none">
						<h4>第三步：填写验证信息</h4><hr>
						<div class="form-group" id="code_class">
							<label for="code" class="col-sm-2 control-label"><a class="text-danger">*</a>验证码</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="code" name="code" disabled="disabled"
								placeholder="填写邮箱验证码" value="<%=code %>" onblur="checkCode()">
								<span id="code_span"></span>
							</div>
							<a href="getCode.jsp?id=<%=user.getID()%>" target="_blank" type="button" class="btn btn-primary" id="codeBtn">免费获取验证码</a>
						</div>
						<div class="form-group">
							<input type="hidden" name="sendCode" id="sendCode" value="">
							<button formaction="resetPassword.jsp" type="submit" class="btn btn-primary" onclick="return checkCode();">找回密码</button>
						</div>
					</div>
					
					<div id="writeModeDiv2" style="display:none">
						<h4>第三步：填写验证信息</h4><hr>
						<div class="form-group" id="user_answer_class">
							<p>密保问题：<%=user.getQuestion() %></p>
							<label for="user_answer" class="col-sm-2 control-label"><a class="text-danger">*</a>答案</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_answer" name="user_answer" 
								placeholder="填写密保问题答案" value="<%=answer %>" onblur="checkUser_answer()">
								<span id="user_answer_span"></span>
							</div>
						</div>
						<div class="form-group">
							<button formaction="resetPassword.jsp" type="submit" class="btn btn-primary" onclick="return checkUser_answer();">找回密码</button>
						</div>
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
<%if(!isExist_account){%>
	var spanNode = document.getElementById("user_account_span");
	spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_account\">账号不存在！</label>";  
    document.getElementById("user_account_class").className = "form-group has-error";     
<%}else if(isExist_account&&user_account.length()!=0){%>
	document.getElementById("selectModeDiv").style.display="";//显示验证选择区域
<%}%>
<%if(selectMode==1){%>
	document.getElementById("writeModeDiv1").style.display="";//显示验证填写区域1
<%}%>
<%if(selectMode==2){%>
	document.getElementById("writeModeDiv2").style.display="";//显示验证填写区域2
<%}%>
</script>

<script>
   $(document).ready(function(){
       $("#selectMode").change(function(){
           $("#form").submit();
       });
   });
</script>
<script>
	$("#selectMode option").each(function() {
    	if($(this).val()=='<%= selectMode %>'){
   			$(this).prop('selected',true);
   		}
	});
</script>

<script>
// 获取验证码倒计时
var countdown = 60;
<%if(sendCode.length()!=0){ %>
	countdown = 58;
	var obj = $("#codeBtn");
	settime(obj);
	$("#code").attr('disabled', false);
<%} %>
$('#codeBtn').on('click',function(){
	var obj = $("#codeBtn");
	$("#sendCode").val(1);
	setTimeout(function(){$("#form").submit();},2000);
	settime(obj);
})
function settime(obj) { //发送验证码倒计时
if (countdown == 0) {
	obj.attr('disabled', false);
	//obj.removeattr("disabled");
	obj.html("免费获取验证码");
	countdown = 60;
	return;
} else {
	obj.attr('disabled', true);
	obj.html("重新发送(" + countdown + ")");
	countdown--;
}
setTimeout(function () {settime(obj)}, 1000)
}
</script>

</body>
</html>
