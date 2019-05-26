<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.net.URLDecoder" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>
<!-- 星级选择CSS -->
<link rel="stylesheet" href="/CSMS/public/assets/css/gradeSelect.css">
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
		request.setAttribute("startFloor", (Page-1)*pageSize);
     %>
    <div class="container-fluid">
		<h3 class="page-title">课题 <b><%=cdt.getName()%></b> 的详细信息</h3>
		<div class="row">
		
			<div class="col-md-12">
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="right">
		            		<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
							<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
		            	</div>
		            	<h3 class="panel-title"><span style="font-size:20px">课题综合评分：</span><span style="color:rgb(0, 170, 255); font-size:40px;"><%=cdt.getGradeStr() %></span></h3>		
						<div class="right" style="margin-right:50px;margin-top:0px;">
		            		<p style="font-size:20px" class="panel-subtitle"><span><script src="/CSMS/public/assets/scripts/randomText.js"></script></span></p>
		            	</div>
					</div>
					<div class="panel-body">
						<pre><span style="font-family:微软雅黑; font-size:20px">所属教师：<%=cdt.getTeacherName() %>&#9;&#9;教师职称：<%=new Teacher().queryTeacherByID(cdt.getTeacherID()).getPosition() %>&#9;教师综合评分：<span style="color:rgb(0, 170, 255);font-size:25px"><%=new Teacher().queryTeacherByID(cdt.getTeacherID()).getGradeStr() %></span></span></pre>
						<pre><span style="font-family:微软雅黑; font-size:20px">课题编号：<%=cdt.getNum() %></span></pre>
						<pre><span style="font-family:微软雅黑; font-size:20px">实现技术：<%=cdt.getTechnology() %></span></pre>
						<pre><span style="font-family:微软雅黑; font-size:20px">关&ensp;键&ensp;字：<%=cdt.getKeyword() %></span></pre>
						<pre><span style="font-family:微软雅黑; font-size:20px">选题人数：<%=cdt.getHeadcount() %></span></pre>
						<pre><span style="font-family:微软雅黑; font-size:20px">发布时间：<%=cdt.getCreated() %></span></pre>
					</div>
					<div class="panel-footer">
						<div class="text-right">
                			<button type="button" id="gradeBtn" class="btn btn-danger">评分</button>
			            </div>
					</div>
				</div>
				<div style="display:none;" id="gradeBox">
					<h3 style="text-align:center" class="page-title">请给课题 <b><%=cdt.getName()%></b> 评分</h3>
					<div id="score">
				    	<ul class="clearfix">
				    		<li></li><li></li><li></li><li></li><li></li>
				    	</ul>
				    	<p><strong></strong></p>
				    	<div id="tip">
				    		<strong></strong>
				    		<div class="triangle"></div>
				    		<div class="triangle_outer"></div>
				    	</div>
				    </div>
				    <div class="text-center">
			    		<input name="grade" id="grade" type="hidden">
				    	<textarea class="form-control" placeholder="在这里写评语（不超过500字）" maxlength="500" style="text-align: center;height:150px;resize: none;"></textarea><br>
				    	<button type="button" id="gradeOK" class="btn btn-primary">提交评分</button>
				    </div>
				</div><hr>
			</div>
			
	        <div class="col-md-12">
				<h3 style="text-align:center" class="page-title">课题评论区</h3>
			</div>
		
			<c:forEach var="grade" items="${graList}" varStatus="floor">
				<div class="col-md-12">
					<div class="panel">
						<div class="panel-heading">
				        	<h3 class="panel-title">${grade.getValueStr() }分</h3>
							<div class="text-center">
				                <h3 style="margin-top:-20px;" class="panel-title">评论用户：${grade.getUser() }</h3>
				            </div>
							<div class="right">
								<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
								<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
							</div>
						</div>
						<div class="panel-body">
							<p style="text-indent: 2em;">${grade.getContent() }</p>
						</div>
						<div class="panel-footer">
							<h5>#${floor.count+startFloor==1?"沙发":floor.count+startFloor}</h5>
							<div class="text-right" >
				            	<h5 style="margin-top:-25px;">评分时间：${grade.getCreated() }</h5>
				            </div>
						</div>
					</div>
				</div>
			</c:forEach>
			<c:if test="${graList.size()==0 }">
				<div class="col-md-12">
					<div class="panel">
						<div class="panel-heading">
				        	<h3 class="panel-title">沙发</h3>
							<div class="right">
								<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
								<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
							</div>
						</div>
						<div class="panel-body">
							<p style="text-align:center;font-size:20px">评论席空空如也，快来抢沙发！！！</p>
						</div>
					</div>
				</div>
			</c:if>
			
			 <div class="col-md-12">
			 	<div class="text-center">
			 		<button type="button" id="remarkBtn" class="btn btn-primary">参与评论</button><hr>
			 	</div>
			 	<div style="display:none;" id="remarkBox">
				    <div class="text-center">
				    	<textarea class="form-control" placeholder="在这里写评论（不超过500字）" maxlength="500" style="text-align: center;height:150px;resize: none;"></textarea><br>
				    	<button type="button" id="remarkOK" class="btn btn-primary">提交评论</button>
				    </div>
				</div><hr>
			</div>
			
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
<!-- 选择星级JS -->
<script src="/CSMS/public/assets/scripts/gradeSelect.js"></script>
<!-- 显示评分框和评论框 -->
<script>
$("#gradeBtn").click(function(){
	$("#gradeBox").show(500);
});
$("#remarkBtn").click(function(){
	$("#remarkBox").show(500);
});
</script>
<script>
<!-- 提交评分 -->
${"#gradeOK"}.click(function(){
	
})
/* 提交评论 */
${"#remarkOK"}.click(function(){
	
})
</script>

</body>
</html>
