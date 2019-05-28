<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,fileController.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<!-- 导航栏 -->
<% int teacher_id = new CDTopic().queryCDTopicByID(new Student().queryStudentByID(user.getStudentID()).getCdtopicID()).getTeacherID(); user.setTeacherID(teacher_id); %>
<%@include file="/CommonView/navbar.jsp" %>
<!-- 左侧边栏 -->
<%@include file="/CommonView/studentLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
     
     <%Student student = new Student().queryStudentByID(user.getStudentID()); %>
     <%ListFile list = new ListFile();int reportCount = list.getFileMap(request, response, "student", 0, user.getName()).size(); %>
     <div style="padding: 80px 0px;text-align: center">
        <h2>上传我的课题报告</h2><hr>
        <h4><span style="color:red">上传要求：</span>文件名中必须含课题名称、班级、姓名和学号。（例：神葳计划 计科17-3BJ 李浩葳 14172401437）</h4>
        <p><span  style="color:#E308E4">最多上传10篇报告</span>&ensp;&ensp;&ensp;已上传报告数：<%=reportCount %></p>
        <form method="post" action="/CSMS/servlet/UploadHandleServlet?branch=student&id=${user.getTeacherID()}" onsubmit="return checkFile()?checkID():false" target="_self" enctype="multipart/form-data">
            <button type="button" class="btn btn-default" onclick="transferclick()" style="margin: 40px">
                <span class="glyphicon glyphicon-inbox" style="font-size: 100px" title="选择课题报告文件"></span>
            </button>
            <p id="nametarget">请选择上传文件</p>
            <input type="file" name="thesis" id="thesis" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" onchange="showfilename()" style="padding: 10px;display:none">
            <button type="submit" class="btn btn-primary" title="上传课题报告">上传</button>
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
            	var reportCount = '<%=reportCount%>';
            	if(	filename.indexOf('<%=student.getCDTopicName()%>')!=-1&&
            		filename.indexOf('<%=student.getClassName()%>')!=-1&&
            		filename.indexOf('<%=student.getName()%>')!=-1&&
            		filename.indexOf('<%=student.getNum()%>')!=-1&&
            		reportCount<=10){
            		return true;
            	}else{
            		alert("上传文件失败！原因可能有：\n1、文件名不符合要求；\n2、文件名中的课题名称、班级、姓名或学号有误；\n3、上传报告数量已超限。");
            		return false;
            	}  
            }else{
            	alert("上传文件不能为空！");
            	return false;
            }
		}
		
		function checkID(){
			var teacher_id = ${user.getTeacherID()};
			if(teacher_id!=0){
				return true;
			}else{
				alert("你还未选择课题无法上传课题报告！！！");
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