<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="UTF-8"%>

<div>
	<div class="pull-left">
		<ul class="pagination">
			<%
				String url = request.getRequestURI() + "?";
				if(request.getQueryString()!=null){
					url = request.getRequestURI() + "?" + URLDecoder.decode(request.getQueryString(),"utf-8") +"&";
				}
				if(url.indexOf("page")!=-1){
					int pageLen = 6+(Page+"").length();
					url = url.substring(0, url.length()-pageLen);
				}
				if(pageCount<=end){
					if(Page == 1){
						out.print(String.format("<li class=\"disabled\"><a>首页</a></li>"));
					}else{
						out.print(String.format("<li><a href=\""+url+"page=%d\">首页</a></li>",1));
					}
					
					end = pageCount;
					
					if(Page>1){
					  out.print(String.format("<li><a href=\""+url+"page=%d\">&laquo;</a></li>",Page-1));
					}
					
					for(int i=start;i<=end;i++){
					  if(i>pageCount) break;
					  String pageinfo=String.format("<li><a href=\""+url+"page=%d\">%d</a></li>",i,i);
					  if(i==Page){
					    pageinfo=String.format("<li class=\"active\"><span>%d</span></li>",i);
					  }
					  out.print(pageinfo);
					}
					
					if(Page<pageCount){
					  out.print(String.format("<li><a href=\""+url+"page=%d\">&raquo;</a></li>",Page+1));
					}
					
					if(Page == pageCount){
						out.print(String.format("<li class=\"disabled\"><a>尾页</a></li>"));
					}else{
						out.print(String.format("<li><a href=\""+url+"page=%d\">尾页</a></li>",pageCount));
					}
					
				}else{
					if(Page == 1){
						out.print(String.format("<li class=\"disabled\"><a>首页</a></li>"));
					}else{
						out.print(String.format("<li><a href=\""+url+"page=%d\">首页</a></li>",1));
					}
					if(Page>=7){
					  start=Page-5;
					  end=Page+4;
					}
					if(start>(pageCount-10)){
					  start=pageCount-9;
					}
					if(Page>1){
					  out.print(String.format("<li><a href=\""+url+"page=%d\">&laquo;</a></li>",Page-1));
					}
					
					for(int i=start;i<=end;i++){
					  if(i>pageCount) break;
					  String pageinfo=String.format("<li><a href=\""+url+"page=%d\">%d</a></li>",i,i);
					  if(i==Page){
					    pageinfo=String.format("<li class=\"active\"><span>%d</span></li>",i);
					  }
					  out.print(pageinfo);
					}
					
					if(Page<pageCount){
					  out.print(String.format("<li><a href=\""+url+"page=%d\">&raquo;</a></li>",Page+1));
					}
					
					if(Page == pageCount){
						out.print(String.format("<li class=\"disabled\"><a>尾页</a></li>"));
					}else{
						out.print(String.format("<li><a href=\""+url+"page=%d\">尾页</a></li>",pageCount));
					}
				}
		     %>
		</ul>
	</div>
</div>