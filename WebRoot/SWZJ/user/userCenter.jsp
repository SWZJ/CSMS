<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<style>
table td:nth-child(1){
	text-align:left;
}
table td:nth-child(2){
	text-align:left;
}
table td:nth-child(3){
	text-align:left;
}
table td:nth-child(4){
	text-align:center;
}
table td p:nth-child(1){
	margin:5px 0;
}
table td p:nth-child(1){
	margin:10px 0;
}
.title{
	font-size:18px
}
.text {
	color: grey;
	font-size:14px
}
</style>

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

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
        
     <div class="container-fluid">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="panel panel-default" style="text-align:center">
                    <div class="panel-heading"><p style="margin:3px 0;color:; font-size:28px"><strong style="color:;"><%= user.getName() %></strong>&ensp;的个人中心</p></div>
                    <div class="panel-body">

			            <!-- 头像开始 -->
			            <div class="avatar">
			                <a href="javascript:void(0);" onclick="" title="修改头像" data-target="#changeModal" data-toggle="modal">
			                	<img src="/CSMS/public/userAvatar/<%=user.getID()%>.jpg" id="user-photo" class="img-circle" alt="Avatar" width="140" height="140"
	                			onerror="this.src='/CSMS/public/userAvatar/<%=user.getRoot()==0?new Student().queryStudentByID(user.getStudentID()).getSex():"未知"%>.jpg';this.onerror=null"/> 
			                </a>
			            </div>
			            <!-- 头像结束 -->
			            <p style="margin:5px 0;color:rgb(0, 170, 255); font-size:22px"><%=user.getAccount() %></p>
						<p class="title"><span>帐号类型：</span><span><%=user.getRootName() %></span></p>
	       				<table class="table table-hover" style="text-align:center;">
				            <colgroup>
				                <col style="width:8%">
				                <col style="width:55%">
				                <col style="width:20%">
				                <col style="width:17%">
				            </colgroup>
				            <tbody>
				            
				            <tr>
				                <td style="vertical-align:middle;">
				                    <img src="/CSMS/public/assets/img/icon_password.png" height="45">
				                </td>
				                <td>
				                    <p class="title">帐号密码</p>
				                    <p class="text">为了保护帐号安全，登录时使用</p>
				                </td>
				                <td style="vertical-align:middle;">
				                    <i class="lnr lnr-checkmark-circle"></i><span>已设置</span>
				                </td>
				                <td style="vertical-align:middle;">
				                    <a href="userManageInfo/updatePassword.jsp" class="btn btn-default">修改</a>
				                </td>
				            </tr>
				
				            <tr>
				                <td style="vertical-align:middle;">
				                    <img src="/CSMS/public/assets/img/icon_bindmobile.png" height="45">
				                </td>
				                <td>
				                    <p class="title">联系手机<span style="color: grey;"><%if(user.getPhone().length()!=0)out.print("（"+user.getPhoneHide()+"）"); %></span></p>
				                    <p class="text">用于找回密码、安全验证</p>
				                </td>
				                <td style="vertical-align:middle;">
				                	<%if(user.getPhone().length()==0){ %>
				                		<i class="lnr lnr-cross-circle"></i><span>未绑定</span>
				                	<%}else{%>
				                		<i class="lnr lnr-checkmark-circle"></i><span>已绑定</span>
				                	<%} %>
                                </td>
				                <td style="vertical-align:middle;">
				                	<%if(user.getPhone().length()==0){ %>
				                		<a href="phone/bindPhone.jsp" class="btn btn-default">绑定</a>
				                	<%}else{%>
				                		<a href="phone/tobindPhone.jsp" class="btn btn-default">修改</a>
				                	<%} %>
				                </td>
				            </tr>
				            
				            <tr>
				                <td style="vertical-align:middle;">
				                    <img src="/CSMS/public/assets/img/icon_bindemial.png" height="45">
				                </td>
				                <td>
				                    <p class="title">联系邮箱<span style="color: grey;"><%if(user.getEmail().length()!=0)out.print("（"+user.getEmailHide()+"）"); %></span></p>
				                    <p class="text">用于找回密码、安全验证</p>
				                </td>
				                <td style="vertical-align:middle;">
                                    <%if(user.getEmail().length()==0){ %>
				                		<i class="lnr lnr-cross-circle"></i><span>未绑定</span>
				                	<%}else{%>
				                		<i class="lnr lnr-checkmark-circle"></i><span>已绑定</span>
				                	<%} %>
                                </td>
				                <td style="vertical-align:middle;">
				                	<%if(user.getEmail().length()==0){ %>
				                		<a href="email/bindEmail.jsp" class="btn btn-default">绑定</a>
				                	<%}else{%>
				                		<a href="email/tobindEmail.jsp" class="btn btn-default">修改</a>
				                	<%} %>
				                </td>
				            </tr>
				            
				            <tr>
				                <td style="vertical-align:middle;">
				                    <img src="/CSMS/public/assets/img/icon_information.png" height="45">
				                </td>
				                <td>
				                    <p class="title">用户信息</p>
				                    <p class="text">帐号归属者的基本资料</p>
				                </td>
				                <td style="vertical-align:middle;">
                                    <i class="lnr lnr-checkmark-circle"></i><span>已认证</span>
                                </td>
				                <td style="vertical-align:middle;">
				                    <a href="userManageInfo/userInfo.jsp" class="btn btn-default">查看</a>
				                </td>
				            </tr>
				            
			                </tbody>
			       		</table>

                    </div>
                </div>
            </div>
        </div>
    </div>
    	
    <form id="avaterForm" action="userAvatarUpload.jsp" target="_blank" method="post" style="display:none">
    	<input type="text" name="id" id="id" value="<%=user.getID()%>">
    	<input type="text" name="dataURL" id="dataURL" value="">
    </form>

</div>
<!-- END MAIN CONTENT -->
</div>
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>
<!-- 修改头像模态框 -->
<%@include file="/CommonView/avatarModal.jsp" %>

</body>
</html>
