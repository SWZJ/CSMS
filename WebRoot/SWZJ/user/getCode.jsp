<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="UTF-8"%>

<%
User user = new User();
//获取上一个页面传递过来的数据
request.setCharacterEncoding("UTF-8");
Integer user_id = Integer.valueOf(request.getParameter("id"));
user = user.queryUserByID(user_id);
if(user.getID()==0){return;}
String code = user.sendCode();
session.setAttribute("code",code);
%>

<script>
	window.opener=null;
	window.open('','_self');
	window.close();
</script>
