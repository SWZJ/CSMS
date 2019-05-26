<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
    <div class="sidebar-scroll">
        <nav>
            <ul class="nav">
            
                <li><a href="/CSMS/index.jsp" id="teacher" class=""><i class="lnr lnr-home"></i><span>概览</span></a></li>
                
                <li>
                    <a href="#myTopic" data-toggle="collapse" id="#myTopic" class="collapsed">
                    <i class="lnr lnr-code"></i><span>我的课题</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="myTopic" class="collapse">
                        <ul class="nav">
                        	<li><a href="/CSMS/SWZJ/teacher/myTopic/teacherAllTopic.jsp" id="teacherAllTopic" class="">我拥有的课题</a></li>
                        	<li><a href="/CSMS/SWZJ/teacher/myTopic/teacherActiveTopic.jsp" id="teacherActiveTopic" class="">已生效课题</a></li>
                            <li><a href="/CSMS/SWZJ/teacher/myTopic/teacherFailedTopic.jsp" id="teacherFailedTopic" class="">未生效课题</a></li>
                            <li><a href="/CSMS/SWZJ/teacher/myTopic/teacherTopicOfStudent.jsp" id="teacherTopicOfStudent" class="">选题学生</a></li>
                        </ul>
                    </div>
                </li>
                
                <li>
                    <a href="#createTopic" data-toggle="collapse" id="#createTopic" class="collapsed ">
                    <i class="lnr lnr-file-empty"></i><span>出题、选题阶段</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="createTopic" class="collapse">
                        <ul class="nav">
                        	<li><a href="/CSMS/SWZJ/teacher/createTopic/teacherCdtopicAdd.jsp" id="teacherCdtopicAdd" class="">新增课题</a></li>
							<li><a href="/CSMS/SWZJ/teacher/createTopic/teacherReportOfStudent.jsp" id="teacherReportOfStudent" class="">学生的课题报告</a></li>
                        </ul>
                    </div>
                </li>
  
            </ul>
        </nav>
    </div>
</div>
<!-- END LEFT SIDEBAR -->

<!-- 侧边栏选中保持 -->
<script>
	var pathname = window.location.pathname;
	//概览
	if(pathname.indexOf("teacher.jsp") != -1){
		document.getElementById("teacher").className = "active";
	}

	//我的课题
	if(pathname.indexOf("myTopic") != -1){
		document.getElementById("#myTopic").className = "active";
		document.getElementById("myTopic").className = "collapse in";
		if(pathname.indexOf("teacherActiveTopic") != -1){
			document.getElementById("teacherActiveTopic").className = "active";
		}else if(pathname.indexOf("teacherFailedTopic") != -1){
			document.getElementById("teacherFailedTopic").className = "active";
		}else if(pathname.indexOf("teacherTopicOfStudent") != -1){
			document.getElementById("teacherTopicOfStudent").className = "active";
		}else if(pathname.indexOf("teacherAllTopic") != -1){
			document.getElementById("teacherAllTopic").className = "active";
		}
	}
	
	//出题、选题阶段
	if(pathname.indexOf("createTopic") != -1){
		document.getElementById("#createTopic").className = "active";
		document.getElementById("createTopic").className = "collapse in";
		if(pathname.indexOf("teacherCdtopicAdd") != -1){
			document.getElementById("teacherCdtopicAdd").className = "active";
		}else if(pathname.indexOf("teacherReportOfStudent") != -1){
			document.getElementById("teacherReportOfStudent").className = "active";
		}
	}

</script>
