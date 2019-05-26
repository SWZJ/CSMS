<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.net.URLDecoder" pageEncoding="utf-8"%>

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
<%@include file="/CommonView/studentLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
        
    <%
    	int cdtopic_id = Integer.valueOf(request.getParameter("cdtopic_id"));
		CDTopic cdt = new CDTopic().queryCDTopicByID(cdtopic_id);
		Grade gra = new Grade();
		
		int recordCount = gra.queryByCondition(0, 0, cdtopic_id, 0, "").size();   	//记录总数
		int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
		int start=1;           					//显示开始页
		int end=10;            					//显示结束页
		int pageCount = recordCount%pageSize==0 ? (recordCount/pageSize==0?1:recordCount/pageSize) : recordCount/pageSize+1;	//计算总页数
		int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
		
		Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况
		Page = Page<1 ? 1 : Page;						//页码小于1的情况
		
		List<Grade> graList = gra.cutPageData(Page, pageSize, 0, 0, cdtopic_id, 0, "");
		request.setAttribute("graList", graList);
		String queryStr = "";
     %>
    <div class="panel">
        <div class="panel-heading" >
            <h3 class="panel-title">课题 <%=cdt.getName()%> 的详细信息</h3>
            <div class="right">
            	<span style="font-size:25px">课题综合评分：</span><span style="color:rgb(0, 170, 255); font-size:40px"><%=cdt.getGradeStr() %></span>
            </div>
        </div>

		<div class="panel-body">
			<table class="table table-hover">
				<thead>
					<tr>
					<th>编号</th>
					<th>评分人</th>
					<th>评分数值</th>
					<th>评语</th>
					<th>评分时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="grade" items="${graList}">
					<tr>
						<td>${grade.getIden() }</td>
						<td>${grade.getUser() }</td>
						<td>${grade.getValue() }</td>
						<td style="width:50%">${grade.getContent() }</td>
						<td>${grade.getCreated() }</td>
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
		
		<!-- 选择页码 -->
		<%@include file="/CommonView/selectPages.jsp" %>

	</div>
	
	<!-- 分页 -->
	<%@include file="/CommonView/pagination.jsp" %>

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