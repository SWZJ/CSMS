<%@ page language="java" import="java.util.*,java.sql.*,JZW.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head lang="en">
    <!-- 头部 -->
	<%@include file="/CommonView/head.jsp" %>
	<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=0.5, maximum-scale=1.0, minimum-scale=0.5">
    <!-- login<css> -->
    <link rel="stylesheet" href="/CSMS/CommonView/loginStyle.css">
</head>
<body>
	<%
		int userID = 0;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if ("userID".equals(cookies[i].getName())) {
					userID = Integer.parseInt(cookies[i].getValue());
					user = user.queryUserByID(userID);
				}
			}
		}
		request.setAttribute("account",user.getAccount());
		request.setAttribute("password",user.getPassword());
	%>
	
	<div class="wrapper">
	    <div class="container">
	    	<h1>课 程 设 计 选 题 管 理 系 统</h1><hr><br>
	        <h1>Welcome</h1>
	        <form class="form" id="userForm" name="userForm" action="loginDo.jsp" onsubmit="return validateUserForm()" method="POST">
	            <input type="text" name="account" placeholder="User account" value="${account}">
            	<input type="password" name="password" placeholder="Password" value="${password}">
            	<div class="checkbox">
                    <label>
                        <input type="checkbox" id="remember" name="remember"> 下次自动登录
                    </label>
                </div>
	            <button type="submit" id="login-button">Login</button><br>
	        </form>
           	<a href="/CSMS/SWZJ/user/logon.jsp">用户注册</a>
           	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
           	<a href="/CSMS/SWZJ/user/forgotPassword.jsp">忘记密码?</a><br><br>
           	<p>登录即代表您已同意<a href="/CSMS/SWZJ/user/userAgreement.jsp">《神葳总局用户协议》</a><a href="/CSMS/SWZJ/user/privacyPolicy.jsp">《神葳总局隐私政策》</a></p>
	    </div>
	
	    <ul class="bg-bubbles">
	        <%for(int i=0;i<10;i++){%><li></li><%}%>
	    </ul>
	</div>
	
	<script type="text/javascript">
		function validateUserForm(){
			var isTrue = false;
			var userID=document.userForm.account.value;
			var password=document.userForm.password.value;
			if (password==null || password=="" || userID==null || userID==""){
				alert("账号或密码不能为空！");
				return false;
			}else{
				return true;
			}
		}
	</script>
	
	<%if(user.getID()!=0){%>
	<script>
		document.getElementById('remember').checked = true // 选中记住登录状态
		document.getElementById('userForm').submit();
	</script>
	<%}%>
	
	<!-- 页尾 -->
	<%@include file="/CommonView/foot.jsp" %>
	
</body>
</html>