<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="UTF-8"%>

<%	
List<Message> mesList = new Message().queryMessageOfNew(user.getID(),false);
int messageCount = mesList.size();
request.setAttribute("mesList", mesList);request.setAttribute("messageCount", messageCount);
%>
<!-- NAVBAR -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="brand">
    	<a href="/CSMS/index.jsp"><img src="/CSMS/public/assets/img/logo-dark.png" alt="Klorofil Logo" class="img-responsive logo"></a>
    </div>
    <div class="container-fluid">
        <div class="navbar-btn">
            <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
        </div>
        <div id="navbar-menu">
        <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
		        <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
		            <i class="lnr lnr-alarm"></i>
		            <span class="badge bg-danger" id="alarm_count">${messageCount==0?"":messageCount}</span>
		        </a>
		        <ul class="dropdown-menu notifications" id="message_menu">
		        	<c:forEach var="mes" items="${mesList}">
						<li><a href="/CSMS/SWZJ/message/myMessage.jsp?id=${mes.getID()}" class="notification-item"><span class="${mes.getTypeStr()}"></span>${mes.getSummary()}</a></li>
					</c:forEach>
					<c:if test="${messageCount==0}">
					   <li><a href="#" class="more">未收到通知</a></li>
					</c:if>
					<c:if test="${messageCount>0}">
						<li><a href="/CSMS/SWZJ/message/myMessage.jsp" class="more">查看所有通知</a></li>
					</c:if>
		        </ul>
	    	</li>
	        <li class="dropdown">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                <img src="/CSMS/public/userAvatar/${user.getID()}.jpg" class="img-circle" alt="Avatar" onerror="this.src='/CSMS/public/userAvatar/<%=user.getRoot()==0?new Student().queryStudentByID(user.getStudentID()).getSex():"未知"%>.jpg';this.onerror=null"/> 
	                <span id="user_昵称">${user.getName()}</span>
	                <i class="icon-submenu lnr lnr-chevron-down"></i>
	            </a>
	            <ul class="dropdown-menu">
	                <li><a href="/CSMS/SWZJ/user/userCenter.jsp" target="_blank"><i class="lnr lnr-user"></i> <span>个人中心</span></a></li>
	                <!-- <li><a href="/CSMS/SWZJ/message/myMessage.jsp"><i class="lnr lnr-bubble"></i> <span>Message</span></a></li> -->
	                <li><a href="/CSMS/SWZJ/user/set/userSet.jsp" target="_blank"><i class="lnr lnr-cog"></i> <span>设置</span></a></li>
	                <li><a href="/CSMS/logout.jsp?user_id=${user.getID()}&user_name=${user.getName()}"><i class="lnr lnr-exit"></i> <span>注销</span></a></li>
	            </ul>
	        </li>
        </ul>
    	</div>
    </div>
</nav>
<!-- END NAVBAR -->