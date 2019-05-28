<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
    <div class="sidebar-scroll">
        <nav>
            <ul class="nav">
            
                <li><a href="/CSMS/index.jsp" id="admin" class=""><i class="lnr lnr-home"></i> <span>主页</span></a></li>
                
                <li>
                    <a href="#audit" data-toggle="collapse" id="#audit" class="collapsed">
                    <i class="fa fa-clipboard"></i> <span>课题审核</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="audit" class="collapse">
                        <ul class="nav">
                        	<li><a href="/CSMS/SWZJ/admin/audit/waitAuditTopic.jsp" id="waitAuditTopic" class="">待审核课题</a></li>
                            <li><a href="/CSMS/SWZJ/admin/audit/approvedTopic.jsp" id="approvedTopic" class="">审核通过课题</a></li>
                            <li><a href="/CSMS/SWZJ/admin/audit/unapprovedTopic.jsp" id="unapprovedTopic" class="">审核未通过课题</a></li>
                            <c:if test="${currentURL.indexOf('audit/topicDetail.jsp')!=-1 }">
			                	<li><a href="javascript:void;" id="topicDetail" class="active">课题详情</a></li>
							</c:if>
                        </ul>
                    </div>
                </li>

                <li>
                    <a href="#manageInfo" data-toggle="collapse" id="#manageInfo" class="collapsed">
                    <i class="lnr lnr-database"></i> <span>信息管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="manageInfo" class="collapse">
                        <ul class="nav">
                        	<li><a href="/CSMS/SWZJ/admin/manageInfo/Student/studentInfo.jsp" id="Student" class="">学生信息管理</a></li>
                        	<li><a href="/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicInfo.jsp" id="CDTopic" class="">课题信息管理</a></li>
                            <li><a href="/CSMS/SWZJ/admin/manageInfo/Teacher/teacherInfo.jsp" id="Teacher" class="">教师信息管理</a></li>
                            <li><a href="#" id="Class" class="">班级信息管理</a></li>
                            <li><a href="#" id="Major" class="">专业信息管理</a></li>
                            <li><a href="#" id="College" class="">学院信息管理</a></li>
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
	//主页
	if(pathname.indexOf("admin.jsp") != -1){
		document.getElementById("admin").className = "active";
	}
	
	//管理员课题审核菜单
	if(pathname.indexOf("audit") != -1){
		document.getElementById("#audit").className = "active";
		document.getElementById("audit").className = "collapse in";
		if(pathname.indexOf("waitAuditTopic") != -1){
			document.getElementById("waitAuditTopic").className = "active";
		}else if(pathname.indexOf("unapprovedTopic") != -1){
			document.getElementById("unapprovedTopic").className = "active";
		}else if(pathname.indexOf("approvedTopic") != -1){
			document.getElementById("approvedTopic").className = "active";
		}
	}
	
	
	
	//管理员信息管理菜单
	if(pathname.indexOf("manageInfo") != -1){
		document.getElementById("#manageInfo").className = "active";
		document.getElementById("manageInfo").className = "collapse in";
		if(pathname.indexOf("Student") != -1){
			document.getElementById("Student").className = "active";
		}else if(pathname.indexOf("CDTopic") != -1){
			document.getElementById("CDTopic").className = "active";
		}else if(pathname.indexOf("Teacher") != -1){
			document.getElementById("Teacher").className = "active";
		}else if(pathname.indexOf("Class") != -1){
			document.getElementById("Class").className = "active";
		}else if(pathname.indexOf("Major") != -1){
			document.getElementById("Major").className = "active";
		}else if(pathname.indexOf("College") != -1){
			document.getElementById("College").className = "active";
		}
	}
	
	
	//管理员消息菜单
	if(pathname.indexOf("message") != -1){
		document.getElementById("#message").className = "active";
		document.getElementById("message").className = "collapse in";
		if(pathname.indexOf("myMessage") != -1){
			document.getElementById("myMessage").className = "active";
		}else if(pathname.indexOf("sendMessage") != -1){
			document.getElementById("sendMessage").className = "active";
		}
	}
</script>