<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,emailController.*,JZW.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test2.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  	<% User user = (User)session.getAttribute("user");%>
    <%Sendemail email = new Sendemail();
    user.getLogger().info(path);
    user.getLogger().info(basePath);
    String to = "2433553243@qq.com";
    String title = "来自神葳总局的邮件";
    String content ="<div style='width:640px; background:#fff; border:solid 1px #efefef; margin:0 auto; padding:0 0 0 0'>"+
					" <table width='560' border='0' align='center' cellpadding='0' cellspacing='0' style=' margin:0 auto; margin-left:30px; margin-right:30px;'>"+
					"    <tbody>"+
					"      <td>"+
					"      <h3 style='font-weight:normal; font-size:18px'>您好！<span style='font-weight:bold; margin-left:5px;'>"+user.getName()+"</span></h3>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>神葳总局邮箱验证通知:</p>"+
					"      <p style='color:#666; font-size:14px'>请在24小时内点击下面链接完成邮箱验证： "+
					"      <a href='"+basePath+"SWZJ/admin/subPages/test3.jsp?_token=lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV&amp;email="+to+"&amp;account="+user.getAccount()+"&amp;id="+user.getID()+"' target='_blank' style='display:block; margin-top:10px; color:#2980b9; line-height:24px; text-decoration:none;word-break:break-all; width:575px;'>"+
					""+basePath+"SWZJ/admin/subPages/test3.jsp?_token=lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV&amp;email="+to+"&amp;account="+user.getAccount()+"&amp;id="+user.getID()+"</a>"+
					"      </p>"+
					" 	   <a href='"+basePath+"SWZJ/admin/subPages/test3.jsp?_token=lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV&amp;email="+to+"&amp;account="+user.getAccount()+"&amp;id="+user.getID()+"' style='display:inline-block; width:105px; text-align:center; background:#2980b9; color:#fff;  font-size:16px; text-decoration:none; line-height:34px; padding:0;border-radius:5px;' target='_blank'>查看详情</a></p>"+
					"      <p style='margin:10px 0 5px 0; padding:3px 0;color:#666; font-size:14px'>如果上面不是链接形式，请将地址复制到您的浏览器（例如：IE）的地址栏再访问。</p>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>如果链接已经失效，请重新神葳总局进行邮箱验证！谢谢您的合作</p>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>如非本人操作，请忽略此邮件，由此给您带来的不便请谅解！</p>"+
					"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>感谢您对神葳总局的支持。</p>"+
					"      </td>"+
					"    </tbody>"+
					" </table>"+
					"</div>";
    if(email.send(to,title,content)){%>
    <div style="text-align:center">
    	<h1>邮件发送成功！</h1><hr>
    	<h3>请通过接收到的email激活邮箱！</h3>
    </div>
    <%}%>
  </body>
</html>
