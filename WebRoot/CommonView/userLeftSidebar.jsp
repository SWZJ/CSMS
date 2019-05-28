<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
    <div class="sidebar-scroll">
        <nav>
            <ul class="nav">
            
                <li><a href="/CSMS/SWZJ/user/userCenter.jsp" id="user" class=""><i class="lnr lnr-user"></i> <span>个人中心</span></a></li>
                
                <li>
                    <a href="#userManageInfo" data-toggle="collapse" id="#userManageInfo" class="collapsed">
                    <i class="lnr lnr-license"></i> <span>用户信息管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="userManageInfo" class="collapse">
                        <ul class="nav">
                        	<li><a href="/CSMS/SWZJ/user/userManageInfo/userInfo.jsp" id="userInfo" class="">用户信息</a></li>
                        	<li><a href="/CSMS/SWZJ/user/userManageInfo/updateInfo.jsp" id="updateInfo" class="">修改信息</a></li>
                        	<li><a href="/CSMS/SWZJ/user/userManageInfo/updatePassword.jsp" id="updatePassword" class="">修改密码</a></li>
                        </ul>
                    </div>
                </li>
                
                <li>
                    <a href="#phone" data-toggle="collapse" id="#phone" class="collapsed">
                    <i class="lnr lnr-tablet"></i> <span>手机号管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="phone" class="collapse">
                        <ul class="nav">
                            <li><a href="/CSMS/SWZJ/user/phone/bindPhone.jsp" id="bindPhone" class="">手机号绑定</a></li>
                            <li><a href="/CSMS/SWZJ/user/phone/tobindPhone.jsp" id="tobindPhone" class="">手机号改绑</a></li>
                            <li><a href="/CSMS/SWZJ/user/phone/unbindPhone.jsp" id="unbindPhone" class="">手机号解绑</a></li>
                        </ul>
                    </div>
                </li>
                
                <li>
                    <a href="#email" data-toggle="collapse" id="#email" class="collapsed">
                    <i class="lnr lnr-envelope"></i> <span>邮箱管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="email" class="collapse">
                        <ul class="nav">
                            <li><a href="/CSMS/SWZJ/user/email/bindEmail.jsp" id="bindEmail" class="">邮箱绑定</a></li>
                            <li><a href="/CSMS/SWZJ/user/email/tobindEmail.jsp" id="tobindEmail" class="">邮箱改绑</a></li>
                            <li><a href="/CSMS/SWZJ/user/email/unbindEmail.jsp" id="unbindEmail" class="">邮箱解绑</a></li>
                        </ul>
                    </div>
                </li>
                
                <li>
                    <a href="#question" data-toggle="collapse" id="#question" class="collapsed">
                    <i class="lnr lnr-question-circle"></i> <span>密保问题管理</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
                    <div id="question" class="collapse">
                        <ul class="nav">
                            <li><a href="/CSMS/SWZJ/user/question/setQuestion.jsp" id="setQuestion" class="">密保问题设置</a></li>
                            <li><a href="/CSMS/SWZJ/user/question/updateQuestion.jsp" id="updateQuestion" class="">密保问题修改</a></li>
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
	//个人中心首页
	if(pathname.indexOf("userCenter.jsp") != -1){
		document.getElementById("user").className = "active";
	}
	
	
	//用户信息管理菜单
	if(pathname.indexOf("userManageInfo") != -1){
		document.getElementById("#userManageInfo").className = "active";
		document.getElementById("userManageInfo").className = "collapse in";
		if(pathname.indexOf("userInfo") != -1){
			document.getElementById("userInfo").className = "active";
		}else if(pathname.indexOf("updateInfo") != -1){
			document.getElementById("updateInfo").className = "active";
		}else if(pathname.indexOf("updatePassword") != -1){
			document.getElementById("updatePassword").className = "active";
		}
	}
	
	//用户手机号管理菜单
	if(pathname.indexOf("phone") != -1){
		document.getElementById("#phone").className = "active";
		document.getElementById("phone").className = "collapse in";
		if(pathname.indexOf("tobindPhone") != -1){
			document.getElementById("tobindPhone").className = "active";
		}else if(pathname.indexOf("unbindPhone") != -1){
			document.getElementById("unbindPhone").className = "active";
		}else if(pathname.indexOf("bindPhone") != -1){
			document.getElementById("bindPhone").className = "active";
		}
	}

	//用户邮箱管理菜单
	if(pathname.indexOf("email") != -1){
		document.getElementById("#email").className = "active";
		document.getElementById("email").className = "collapse in";
		if(pathname.indexOf("tobindEmail") != -1){
			document.getElementById("tobindEmail").className = "active";
		}else if(pathname.indexOf("unbindEmail") != -1){
			document.getElementById("unbindEmail").className = "active";
		}else if(pathname.indexOf("bindEmail") != -1){
			document.getElementById("bindEmail").className = "active";
		}
	}
	
	
	//用户密保问题管理菜单
	if(pathname.indexOf("question") != -1){
		document.getElementById("#question").className = "active";
		document.getElementById("question").className = "collapse in";
		if(pathname.indexOf("setQuestion") != -1){
			document.getElementById("setQuestion").className = "active";
		}else if(pathname.indexOf("updateQuestion") != -1){
			document.getElementById("updateQuestion").className = "active";
		}
	}
</script>
