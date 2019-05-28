<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,fileController.*" pageEncoding="utf-8"%>
<%if(request.getParameter("id")==null){response.sendRedirect("/CSMS/404.jsp");return;} %>

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
<%@include file="/CommonView/teacherLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
     <%int cdtopic_id = Integer.valueOf(request.getParameter("id")); %>
     <%CDTopic cdtopic = new CDTopic().queryCDTopicByID(cdtopic_id); %>
     <%-- <%ListFile list = new ListFile();int reportCount = list.getFileMap(request, response, "teacher", user.getTeacherID(), "").size(); %> --%>
     <div style="padding: 80px 0px;text-align: center">
        <h2>上传我的开题报告</h2><hr>
        <h4><span style="color:red">上传要求：</span>文件名中必须含课题名称：<b><%=cdtopic.getName() %></b></h4>
        <p><span  style="color:#E308E4">新上传的开题报告将会覆盖原有的开题报告，请谨慎操作</span></p>
        <form method="post" action="/CSMS/servlet/UploadHandleServlet?branch=teacher&id=<%=cdtopic_id %>" onsubmit="return checkFile();" target="_self" enctype="multipart/form-data">
            <button type="button" class="btn btn-default" onclick="transferclick()" style="margin: 40px">
                <span class="glyphicon glyphicon-inbox" style="font-size: 100px" title="选择开题报告文件"></span>
            </button>
            <p id="nametarget">请选择上传文件</p>
            <input type="file" name="thesis" id="thesis" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" onchange="showfilename()" style="padding: 10px;display:none">
            <button type="submit" class="btn btn-primary" title="上传开题报告">上传</button>
        </form>
    </div>

    <script>
        function transferclick() {
            document.getElementById("thesis").click();
        }

        function showfilename() {
            var file=document.getElementById("thesis");
            var nametarget=document.getElementById("nametarget");
            var filename = "请选择上传文件";
            if(file.files[0] != undefined){
                filename=file.files[0].name;
            }
            nametarget.innerText=filename;
        }
        
		function checkFile(){
			var file=document.getElementById("thesis");
            if(file.files[0] != undefined){
            	var filename=file.files[0].name;
            	if( filename.indexOf('<%=cdtopic.getName()%>')!=-1){
            		return true;
            	}else{
            		alert("上传文件失败！原因可能有：\n1、文件名不符合要求；\n2、文件名中的课题名称有误。");
            		return false;
            	}  
            }else{
            	alert("上传文件不能为空！");
            	return false;
            }
		}
		
    </script>


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
