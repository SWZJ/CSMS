<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

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
<%@include file="/CommonView/messageLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->

	<%
		Message mes = new Message();
		
		int recordCount = mes.queryByCondition(0, 2, 0, user.getID(), "").size();   	//记录总数
		int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
		int start=1;           					//显示开始页
		int end=10;            					//显示结束页
		int pageCount = recordCount%pageSize==0 ? (recordCount/pageSize==0?1:recordCount/pageSize) : recordCount/pageSize+1;	//计算总页数
		int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
		
		Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况
		Page = Page<1 ? 1 : Page;						//页码小于1的情况
		
		List<Message> myMesList = mes.cutPageData(Page, pageSize, 0, 2, 0, user.getID(), "");
		request.setAttribute("myMesList", myMesList);
		request.setAttribute("startFloor", (Page-1)*pageSize);
     %>
	<div class="container-fluid">
		<div class="row">
		
			<div class="col-md-12">
				<div class="panel">
			        <div class="panel-heading" >
			            <h3 class="panel-title">My Message</h3>
			            <div class="right">
			                <a href="sendMessage.jsp"><span class="label label-primary"><i class="fa fa-comments"></i>&nbsp;Send Message</span></a>
			            </div>
			        </div>
					<div class="panel-body" style="text-align:center;font-size:24px">
						Here are all the messages you've received
					</div>
				</div>
			</div>
	
		
			<c:forEach var="mes" items="${myMesList}" varStatus="floor">
			<div class="col-md-12">
				<c:choose>
				<c:when test="${mes.getReaded()==false }">
					<div class="panel">
						<div class="panel-heading">
				        	<h3 class="panel-title">Summary:${mes.getSummary() }</h3>
				        	<span style="margin-top:-2cm;" class="badge bg-danger">${mes.getReaded()==false?"<span>new message</span>":"" }</span>
							<div class="text-center">
				                <h3 style="margin-top:-41px;" class="panel-title">Sender:${mes.getSender() }</h3>
				            </div>
							<div class="right">
								<a href="deleteMessageDo.jsp?id=${mes.getID() }" onclick="return confirm('Are you sure you want to delete this message?');">
								<span class="label label-danger"><i class="fa fa-window-close"></i>&nbsp;Delete Message</span></a>
								<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
								<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
							</div>
						</div>
						<div class="panel-body">
							<p style="text-indent: 2em;">${mes.getContent() }</p>
						</div>
						<div class="panel-footer">
							<span>#${floor.count+startFloor}</span>
							<span style="margin-left:50px;">Identifier:${mes.getIden() }</span>
							<div class="text-center" style="margin-top:-27px;">
								<a type="button" href="markReadMessageDo.jsp?id=${mes.getID() }" class="btn btn-success">Mark as Read</a>
				            </div>
							<div class="text-right" style="margin-top:-27px;">
				            	<span>Sending time:${mes.getCreated() }</span>
				            </div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="panel">
						<div class="panel-heading">
				        	<h3 class="panel-title">Summary:${mes.getSummary() }</h3>
							<div class="text-center">
				                <h3 style="margin-top:-20px;" class="panel-title">Sender:${mes.getSender() }</h3>
				            </div>
							<div class="right">
								<a href="deleteMessageDo.jsp?id=${mes.getID() }" onclick="return confirm('<%="sd"%>Are you sure you want to delete this message?');">
								<span class="label label-danger"><i class="fa fa-window-close"></i>&nbsp;Delete Message</span></a>
								<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
								<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
							</div>
						</div>
						<div class="panel-body">
							<p style="text-indent: 2em;">${mes.getContent() }</p>
						</div>
						<div class="panel-footer">
							<span>#${floor.count+startFloor}</span>
							<span style="margin-left:50px;">Identifier:${mes.getIden() }</span>
							<div class="text-center" style="margin-top:-27px;">
								<a type="button" href="markUnreadMessageDo.jsp?id=${mes.getID() }" class="btn btn-info">Mark as Unread</a>
				            </div>
							<div class="text-right" style="margin-top:-27px;">
				            	<span>Sending time:${mes.getCreated() }</span>
				            </div>
						</div>
					</div>
				</c:otherwise>
				</c:choose>
			</div>
			</c:forEach>
			
			<c:if test="${myMesList.size()==0 }">
				<div class="col-md-12">
					<div class="panel">
						<div class="panel-heading">
							<div class="right">
								<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
								<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
							</div>
						</div>
						<div class="panel-body">
							<p style="text-align:center;font-size:20px">You haven't received any messages yet!!!</p>
						</div>
					</div>
				</div>
			</c:if>
			
		</div>
		
	<!-- 选择页码 -->
	<%@include file="/CommonView/selectPages.jsp" %>
	<!-- 分页 -->
	<%@include file="/CommonView/pagination.jsp" %>
	
	</div>

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
