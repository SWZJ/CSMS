<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>

<%
User user = new User();
//获取上一个页面传递过来的数据
request.setCharacterEncoding("UTF-8");
String user_id = request.getParameter("id")==null?"":request.getParameter("id");
String dataURL = request.getParameter("dataURL")==null?"":request.getParameter("dataURL");

String path=request.getSession().getServletContext().getRealPath("/");
path += "/public/userAvatar";
String imgName=user_id+".jpg";
user.decodeBase64DataURLToImage(dataURL, path, imgName);

%>
<%-- <%if(!user.sendPhoneCode(to,code)){ %>
	<script>alert("遇到未知原因，头像保存失败！如多次出错请联系管理员。");</script>
<%} %> --%>

<script>
	window.opener=null;
	window.open('','_self');
	window.close();
</script>

