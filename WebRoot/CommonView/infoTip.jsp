<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<% String message = (String)session.getAttribute("message"); %>
<%if(message != null){
	if(message.indexOf("成功") != -1||message.indexOf("success") != -1){
		out.print("<div class=\"alert alert-success alert-dismissible\" role=\"alert\">");
		out.print("<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>");
		out.print("<i class=\"fa fa-check-circle\"></i>"+message+"</div>");
	}else{
		out.print("<div class=\"alert alert-danger alert-dismissible\" role=\"alert\">");
		out.print("<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>");
		out.print("<i class=\"fa fa-times-circle\"></i>"+message+"</div>");
	}
}%>
<% session.removeAttribute("message"); %>
