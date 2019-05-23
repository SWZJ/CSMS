<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<%
    //获取手机号验证信息
	request.setCharacterEncoding("UTF-8");
	String operation = request.getParameter("operation")==null?"":request.getParameter("operation");
    String phone = request.getParameter("user_phone")==null?"":request.getParameter("user_phone");
    Integer user_id = request.getParameter("id")==null?0:Integer.valueOf(request.getParameter("id"));
    
%>

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
<%
String sendCode = request.getParameter("sendCode")==null?"":request.getParameter("sendCode");
String phoneCode="";
int result = 0;
if(sendCode.length()!=0){
	if(user.isExist_phone(phone)&&!phone.equals(user.getPhone())){
		result=2;
	}else{
		phoneCode = User.getPhoneCode();
		session.setAttribute("phonecode",phoneCode);
		if(user.sendPhoneCode(phone, phoneCode))	result=1;
	}
}
String tobin = request.getParameter("tobin")==null?"":request.getParameter("tobin");
%>
<div class="container">
	<div class="col-md-8 col-md-offset-2" style="padding: 100px 70px 0 70px;">
		<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
			<div class="panel-heading">
           		<h3 class="panel-title">邮箱验证通知</h3>
        	</div>
			<div class="panel-body">
			<% 
				switch(operation){
		    	case "bindPhone":%>
		    		<%if(user.updateUserPhone(user.queryUserByID(user_id), phone)){%>
		    			<div>
							<h1>手机号验证成功</h1><hr>
							<h3>您已成功绑定手机号&ensp;<%= phone %></h3>
						</div>
						<br><a class="btn btn-primary" href="/CSMS/SWZJ/user/userCenter.jsp" >转到个人中心</a>
		    		<% }else{%>
		    			<div>
							<h1>手机号验证失败</h1><hr>
							<h3>遇到未知错误，绑定手机号&ensp;<%= phone %>&ensp;失败</h3>
						</div>
						<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
		    		<%}
		    		session.removeAttribute("phonecode");
		    		break;
		    	case "tobindPhone":
		    		if(tobin.length()==0){if(phone.equals(user.getPhone())) phone=""; %>
		    			<form class="form-horizontal" role="form" method="post" action="?operation=tobindPhone&id=<%=user.getID()%>" onsubmit="return checkAll()">
							<br>
							<div class="form-group" id="user_phone_class">
								<label for="user_email" class="control-label"><a class="text-danger"></a>手&ensp;机&ensp;号</label><hr>
								<input type="text" class="form-control" id="user_phone" name="user_phone" 
								placeholder="请输入要改绑的手机号" value="<%=phone %>" autocomplete="off"
								oninput="Inputing(document.getElementById('user_phone_span'),document.getElementById('user_phone_class'))">
								<input type="hidden" name="tobin" value="1">
								<span id="user_phone_span"></span>
							</div>
							<br>
							<div class="form-group" id="phonecode_class">
								<label for="phonecode" class="col-sm-2 control-label"><a class="text-danger"></a>验证码</label>
								<div class="col-md-10 col-sm-10 col-lg-10">
									<div class="input-group">
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
								<button type="submit" id="phoneBtn" title="绑定手机号" class="btn btn-primary">改绑手机号</button>
							</div>	
						</form>
		    		<%}else{
						if(user.updateUserPhone(user.queryUserByID(user_id), phone)){%>
			    			<div>
								<h1>手机号验证成功</h1><hr>
								<h3>您已成功改绑手机号&ensp;<%= phone %></h3>
							</div>
							<br><a class="btn btn-primary" href="/CSMS/SWZJ/user/userCenter.jsp" >转到个人中心</a>
			    		<% }else{%>
			    			<div>
								<h1>邮箱验证失败</h1><hr>
								<h3>遇到未知错误，改绑手机号&ensp;<%= phone %>&ensp;失败</h3>
							</div>
							<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
			    		<%}
			    		session.removeAttribute("phonecode");
		    		}
		    		break;
		    	case "unbindPhone":
		    		if(user.updateUserPhone(user.queryUserByID(user_id), "")){%>
		    			<div>
							<h1>手机号验证成功</h1><hr>
							<h3>您已成功解绑手机号&ensp;<%= phone %></h3>
						</div>
						<br><a class="btn btn-primary" href="/CSMS/SWZJ/user/userCenter.jsp" >转到个人中心</a>
		    		<% }else{%>
		    			<div>
							<h1>手机号验证失败</h1><hr>
							<h3>遇到未知错误，解绑手机号&ensp;<%= phone %>&ensp;失败</h3>
						</div>
						<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
		    		<%}
		    		session.removeAttribute("phonecode");
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
<script>
//获取验证码倒计时（邮箱）
var countdown = 120;
<%if(sendCode.length()!=0){%>
	window.history.pushState(null,"","validatePhone.jsp")
	var obj = $("#phonecodeBtn");
	document.getElementById("phonecode_class").className = "form-group";
	<%if(result==1){%>  
		document.getElementById("phonecode_span").innerHTML = "<label class=\"control-label text-success left\" for=\"phonecode\">验证码已成功发送到您的手机！如长时间未收到请重新发送。</label>";  
		$("#phonecode").attr('disabled', false);
		settime(obj);
	<%}else if(result==0){%>
		document.getElementById("phonecode_span").innerHTML = "<label class=\"control-label text-danger left\" for=\"phonecode\">验证码发送失败！原因可能是发送过于频繁或次数超限。</label>";  
		settime(obj);
	<%}else if(result==2){%>
		var field = document.getElementById("user_phone").value;
    	var spanNode = document.getElementById("user_phone_span");
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_phone\">该手机号已被绑定！</label>";  
        document.getElementById("user_phone_class").className = "form-group has-error";
	<%}%>
<%}%>
$('#phonecodeBtn').on('click',function(){
	var user_phone = checkUser_phone();
	if(user_phone==false)	return;
	var phone = $("#user_phone").val();
	var id = '${user.getID()}';
	window.location.href="?sendCode=1&operation=tobindPhone&id="+id+"&user_phone="+phone;
})
function settime(obj) { //发送验证码倒计时
if (countdown == 0) {
	obj.attr('disabled', false);
	//obj.removeattr("disabled");
	obj.html("免费获取验证码");
	countdown = 120;
	return;
} else {
	obj.attr('disabled', true);
	obj.html("重新发送(" + countdown + ")");
	countdown--;
}
setTimeout(function () {settime(obj)}, 1000)
}
</script>

<!-- 手机验证码验证JS -->
<script>
function checkPhoneCode(){
    var field = document.getElementById("phonecode").value;
    var spanNode = document.getElementById("phonecode_span");
	if(field.length == 0){
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"phonecode\">验证码不能为空！</label>";  
        document.getElementById("phonecode_class").className = "form-group has-error";    
        return false;
	}else{
		var phonecode = '${phonecode}';
		if(phonecode!=null&&field!=phonecode){
			spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"phonecode\">验证码错误！</label>";  
	        document.getElementById("phonecode_class").className = "form-group has-error";   
	        return false;
		}else{
			spanNode.innerHTML = "";
	        document.getElementById("phonecode_class").className = "form-group";   
	        return true;
		}
	}
}
</script>
<!-- 手机号验证JS -->
<script>
function checkUser_phone(){
    var field = document.getElementById("user_phone").value;
    var spanNode = document.getElementById("user_phone_span");
    //手机号的规则： 必填，手机号标准
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_phone\">手机号不能为空！</label>";  
        document.getElementById("user_phone_class").className = "form-group has-error";    
        return false;
	}else{
		/*var reg = /^[1]([3-9])[0-9]{9}$/;*/
		var reg = /^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_phone\">手机号输入不规范！</label>";  
	        document.getElementById("user_phone_class").className = "form-group has-error";    
	        return false;  
	    }else if(field=='${user.getPhone()}'){
			//不能为当前手机号
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_phone\">不能为当前手机号！</label>";  
	        document.getElementById("user_phone_class").className = "form-group has-error";    
	        return false;
		}else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("user_phone_class").className = "form-group";   
	        return true;  
		}
	}
}
</script>
<!-- 表单验证 -->
<script>
	function checkAll(){
		var user_phone = checkUser_phone();
		var user_phoneCode = checkPhoneCode();
		if(user_phone&&user_phoneCode){
			return true;
		}else{  
			return false;  
		}
	} 
</script>

</body>
</html>
