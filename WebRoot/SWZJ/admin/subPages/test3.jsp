<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>

<%
	User user = new User();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	String _token = request.getParameter("_token");
    String email = request.getParameter("email");
    String account = request.getParameter("account");
    String user_id = request.getParameter("id");
    
    user.getLogger().debug("接收到的_token为："+_token);
    user.getLogger().debug("接收到的邮箱为："+email);
    user.getLogger().debug("接收到的账号为："+account);
    user.getLogger().debug("接收到的ID为："+user_id);
    
%>


<div style="text-align:center">
	<h1>邮箱验证成功！</h1><hr>
	<h3>_koekn为：<%=_token %></h3>
	<h3>邮箱为：<%=email %></h3>
	<h3>账号为：<%=account %></h3>
	<h3>ID为：<%=user_id %></h3>
</div>