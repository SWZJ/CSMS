<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,emailController.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
String basePathPort = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

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
				<% 
				//获取上一个页面传递过来的数据
				request.setCharacterEncoding("UTF-8");
				String user_email = request.getParameter("user_email")==null?"":request.getParameter("user_email");
				if(request.getParameter("tobin")!=null&&user_email.equals(user.getEmail())){
					out.print("<script>alert(\"操作失败！\\n不可改绑为当前已绑定的邮箱！\");window.history.back(-1);</script>");return;
				}
				if(user.isExist_email(user_email)&&!user_email.equals(user.getEmail())){
					out.print("<script>alert(\"操作失败！\\n邮箱 "+user_email+" 已被绑定！\");window.history.back(-1);</script>");return;
				}
				Sendemail email = new Sendemail();
				String to = user_email;
				String title = "神葳总局邮箱改绑";
				long poke = System.currentTimeMillis();
				String content ="<div style='width:640px; background:#fff; border:solid 1px #efefef; margin:0 auto; padding:0 0 0 0'>"+
					" <table width='560' border='0' align='center' cellpadding='0' cellspacing='0' style=' margin:0 auto; margin-left:30px; margin-right:30px;'>"+
					"    <tbody>"+
					"      <td>"+
					"      <h3 style='font-weight:normal; font-size:18px'>您好！<span style='font-weight:bold; margin-left:5px;'>"+user.getName()+"</span></h3>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>神葳总局邮箱改绑通知:</p>"+
					"      <p style='color:#666; font-size:14px'>您正在进行神葳总局用户邮箱改绑，请在24小时内点击下面链接完成邮箱验证： "+
					"      <a href='"+basePathPort+"SWZJ/user/email/validateEmail.jsp?_token=lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV&amp;operation=tobindEmail&amp;email="+to+"&amp;account="+user.getAccount()+"&amp;id="+user.getID()+"&amp;poke="+poke+"' target='_blank' style='display:block; margin-top:10px; color:#2980b9; line-height:24px; text-decoration:none;word-break:break-all; width:575px;'>"+
					""+basePath+"SWZJ/user/email/validateEmail.jsp?_token=lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV&amp;operation=tobindEmail&amp;email="+to+"&amp;account="+user.getAccount()+"&amp;id="+user.getID()+"&amp;poke="+poke+"</a>"+
					"      </p>"+
					" 	   <a href='"+basePathPort+"SWZJ/user/email/validateEmail.jsp?_token=lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV&amp;operation=bindEmail&amp;email="+to+"&amp;account="+user.getAccount()+"&amp;id="+user.getID()+"&amp;poke="+poke+"' style='display:inline-block; width:105px; text-align:center; background:#2980b9; color:#fff;  font-size:16px; text-decoration:none; line-height:34px; padding:0;border-radius:5px;' target='_blank'>查看详情</a></p>"+
					"      <p style='margin:10px 0 5px 0; padding:3px 0;color:#666; font-size:14px'>如果上面不是链接形式，请将地址复制到您的浏览器（例如：IE）的地址栏再访问。</p>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>如果链接已经失效，请回到神葳总局重新进行邮箱验证，谢谢您的合作！</p>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>如非本人操作，请忽略此邮件，由此给您带来的不便请谅解！</p>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>感谢您对神葳总局的支持。</p>"+
					"      </td>"+
					"    </tbody>"+
					" </table>"+
					"</div>";
				if(email.send(to,title,content)){%>
				<div>
					<h1>验证邮件发送成功</h1><hr>
					<h3>请注意查收</h3>
				</div>
				<%}else{%>
				<div>
					<h1>验证邮件发送失败</h1><hr>
					<h4>邮箱不存在或遇到未知问题，请重新操作或联系管理员</h4>
				</div>
				<br><a class="btn btn-primary" href="#" onClick="history.back(-1)">返回重新操作</a>
				<%} %>
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
