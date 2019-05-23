<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
User user = new User();
if(session.getAttribute("user") != null){
	user = new User().queryUserByID(((User)session.getAttribute("user")).getID()); 
	session.setAttribute("user", user);
}
%>
<title>节奏葳</title>
<meta content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.3">
<!-- VENDOR CSS -->
<link rel="stylesheet" href="/CSMS/public/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSMS/public/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/CSMS/public/assets/vendor/linearicons/style.css">
<link rel="stylesheet" href="/CSMS/public/assets/vendor/chartist/css/chartist-custom.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="/CSMS/public/assets/css/main.css">
<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
<link rel="stylesheet" href="/CSMS/public/assets/css/demo.css">
<!-- ICONS -->
<link rel="apple-touch-icon" sizes="76x76" href="/CSMS/public/assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96" href="/CSMS/public/assets/img/favicon.png">
