<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

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
<%if(user.getRoot() == 1){%>
<%@include file="/CommonView/adminLeftSidebar.jsp" %>
<%}else if(user.getRoot() == 0){%>
<%@include file="/CommonView/studentLeftSidebar.jsp" %>
<%}else if(user.getRoot() == 9){%>
<%@include file="/CommonView/teacherLeftSidebar.jsp" %>
<%}%>

<%if(user.getRoot() == 999){%>
<%@include file="/CommonView/adminLeftSidebar.jsp" %>
<%}%>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->

	<div class="panel">
    
        <div class="panel-heading" >
            <h3 class="panel-title">Send Message</h3>
            <div class="right">
                <!-- <a href="/CSMS/SWZJ/message/sendMessage.jsp"><span class="label label-primary"><i class="fa fa-plus-square"></i>&nbsp;Send Message</span></a> -->
            </div>
        </div>
        
		<div class="panel-body">
			<div class="panel-heading">欢迎  <%= user.getName() %> 登录</div>
            <div class="panel-body">
            	你是 <%= user.getRootName() %> ！<hr>
            	这里你可以发送消息！
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