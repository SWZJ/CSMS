<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<%
	//获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Message mes = new Message();
    int message_id = request.getParameter("id")==null?0:Integer.valueOf(request.getParameter("id"));
    if(message_id != 0){
    	mes = new Message().queryMessageByID(message_id);
    	mes.updateMessageOfReaded(true);
    }else{
    	/* mes.updateMessageAllReaded(user.getID()); */
    }
 %>

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

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->

	<div class="panel">
    
        <div class="panel-heading" >
            <h3 class="panel-title">My Message</h3>
            <div class="right">
                <a href="/CSMS/SWZJ/message/sendMessage.jsp"><span class="label label-primary"><i class="fa fa-plus-square"></i>&nbsp;Send Message</span></a>
            </div>
        </div>
        
		<div class="panel-body">
			<table class="table table-hover">
				<thead>
					<tr>
					<th>操作管理</th>
					<th>类型</th>
					<th>概述</th>
					<th>是否阅读</th>
					<th>发送者</th>
					<th>发送时间</th>
					<!-- <th>修改时间</th> -->
					</tr>
				</thead>
				<tbody>
                    	<%= user.getRootName() %>
                    	<%
							if(message_id != 0){
						    	mes = new Message().queryMessageByID(message_id);
							    out.print(mes.getContent());
							}else{
								out.print("这里是你所有的消息");
							
							}
                    	 %>
				</tbody>
			</table>
		</div>
		
		<%-- <!-- 选择页码 -->
		<%@include file="/CommonView/selectPages.jsp" %> --%>

	</div>
	
	<%-- <!-- 分页 -->
	<%@include file="/CommonView/pagination.jsp" %> --%>

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
