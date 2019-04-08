<%
	request.getSession().invalidate();
	response.sendRedirect("/CSMS/login.jsp");
%>
