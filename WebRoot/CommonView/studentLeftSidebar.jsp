<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
    <div class="sidebar-scroll">
        <nav>
            <ul class="nav">
            
                <li><a href="/CSMS/index.jsp" id="student" class=""><i class="lnr lnr-home"></i> <span>首页</span></a></li>
                
                <li><a href="/CSMS/SWZJ/student/chooseTopic/studentChooseTopic.jsp" id="studentChooseTopic" class=""><i class="lnr lnr-file-empty"></i> <span>选择课题</span></a></li>
                
                <li><a href="/CSMS/SWZJ/student/uploadReport/studentUploadReport.jsp" id="studentUploadReport" class=""><i class="lnr lnr-inbox"></i> <span>上传课题报告</span></a></li>
                
                <li>
                    <a href="#designStep" data-toggle="collapse" id="#designStep" class="collapsed">
                    <i class="lnr lnr-code"></i><span>课题设计步骤</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="designStep" class="collapse">
                        <ul class="nav">
                            <li><a href="/CSMS/SWZJ/student/designStep/studentWriteReport.jsp" id="studentWriteReport" class="">课题报告编写</a></li>
                            <li><a href="/CSMS/SWZJ/student/designStep/studentMyReport.jsp" id="studentMyReport" class="">我的课题报告</a></li>
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
	//首页
	if(pathname.indexOf("student.jsp") != -1){
		document.getElementById("student").className = "active";
	}
	
	//选择课题
	if(pathname.indexOf("studentChooseTopic") != -1){
		document.getElementById("studentChooseTopic").className = "active";
	}
	
	//上传报告
	if(pathname.indexOf("uploadReport") != -1){
		document.getElementById("studentUploadReport").className = "active";
	}

	//课题设计步骤
	if(pathname.indexOf("designStep") != -1){
		document.getElementById("#designStep").className = "active";
		document.getElementById("designStep").className = "collapse in";
		if(pathname.indexOf("studentWriteReport") != -1){
			document.getElementById("studentWriteReport").className = "active";
		}else if(pathname.indexOf("studentMyReport") != -1){
			document.getElementById("studentMyReport").className = "active";
		}
	}

</script>
