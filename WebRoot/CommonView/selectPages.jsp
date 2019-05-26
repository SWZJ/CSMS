<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!-- SELECT PAGES -->
<meta charset="utf-8">
<div class="panel-footer">
    <div class="col-md-2">
        <form class="form-inline" id="pageNumForm" role="form" method="get" action="">
        	<%if(request.getParameter("cdtopic_id")!=null){ %><input type="hidden" name="cdtopic_id" value="<%=request.getParameter("cdtopic_id")%>"><%} %>
        	<%if(request.getParameter("queryStr")!=null){ %><input type="hidden" name="cdtopic_id" value="<%=request.getParameter("queryStr")%>"><%} %>
            <div class="form-group">
                <select title="显示行数" id="selectPages" name="selectPages" class="form-control field">
                    <option value="10" id="10">显示10行</option>
                    <option value="25" id="25">显示25行</option>
                    <option value="50" id="50">显示50行</option>
                    <option value="100" id="100">显示100行</option>
                    <option value="250" id="250">显示250行</option>
                    <option value="500" id="500">显示500行</option>
                </select>
            </div>
        </form>
    </div>
    <hr>
</div>
<!-- END SELECT PAGES -->


<%-- <!-- SELECT  -->
<script>
   $(document).ready(function(){
       //页面行数改变，刷新页面
       $("#selectPages").change(function(){
           $("#pageNumForm").submit();
       });
   });
</script>
<!-- END SELECT  -->
<!-- GET SELECT PAGES FROM INPUT -->
<script>
	$("#selectPages option").each(function() {
        if($(this).val()=='<%=pageSize%>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END GET SELECT PAGES FROM INPUT --> --%>
