<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
    <div class="sidebar-scroll">
        <nav>
            <ul class="nav">
            
                <li><a href="/CSMS/SWZJ/message/myMessage.jsp" id="myMessage" class=""><i class="lnr lnr-bubble"></i><span>My Message</span></a></li>
                
                <li><a href="/CSMS/SWZJ/message/unreadMessage.jsp" id="unreadMessage" class="">
                <i class="lnr lnr-pie-chart"></i><span>Unread Message </span><span class="badge bg-danger">${newMessageCount==0?"":newMessageCount}</span></a></li>
                
                <li><a href="/CSMS/SWZJ/message/historyMessage.jsp" id="historyMessage" class=""><i class="lnr lnr-map"></i><span>History Message</span></a></li>
                
                <li><a href="/CSMS/SWZJ/message/sendMessage.jsp" id="sendMessage" class=""><i class="lnr lnr-highlight"></i><span>Send Message</span></a></li>
                
                <li><a href="/CSMS/SWZJ/message/sentMessage.jsp" id="sentMessage" class=""><i class="lnr lnr-spell-check"></i><span>Sent Message</span></a></li>
                
            </ul>
        </nav>
    </div>
</div>
<!-- END LEFT SIDEBAR -->

<!-- 侧边栏选中保持 -->
<script>
	var pathname = window.location.pathname;
	//全部消息
	if(pathname.indexOf("myMessage.jsp") != -1){
		document.getElementById("myMessage").className = "active";
	}
	//未读消息
	if(pathname.indexOf("unreadMessage.jsp") != -1){
		document.getElementById("unreadMessage").className = "active";
	}
	//已读消息
	if(pathname.indexOf("historyMessage.jsp") != -1){
		document.getElementById("historyMessage").className = "active";
	}
	//发送消息
	if(pathname.indexOf("sendMessage.jsp") != -1){
		document.getElementById("sendMessage").className = "active";
	}
	//已发送消息
	if(pathname.indexOf("sentMessage.jsp") != -1){
		document.getElementById("sentMessage").className = "active";
	}
	
</script>
