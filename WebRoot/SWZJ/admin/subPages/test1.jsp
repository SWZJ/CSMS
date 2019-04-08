<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>节奏葳</title>
	<link rel="stylesheet" type="text/css" href="styles.css">
	<script type="text/javascript">
	function confirmDelete(student_name){
        if(window.confirm("您确定要删除 "+student_name+" 的学生信息吗？"))	return true;
        else return false;
 	}
	</script>
  </head>

  <body>
    <h1>节奏葳 欢迎！！！</h1>
    <h2>很高兴再次见到您！！</h2>
    <h2><a href="indexAdd.jsp">学生信息添加</a></h2>
    <h2><a href="test.jsp">测试页面</a></h2>
    <h2><a href="test2.jsp">测试页面2</a></h2>
    <div align="center">
	    <h2>学生信息表:</h2>
	    <table border=1>
	   	<%--  加<% %>的意思是写在后台用户看不见的地方 --%>
	    <%
	    try {
	    		/* 使用JDBC包文件 */
	            String driver = "com.mysql.cj.jdbc.Driver";
	            Class.forName(driver);
	            
	            /* 连接数据库语句 自己修改为自己创建的数据库中的下述信息*/
	            String 数据库名字 = "课程设计选题管理系统";
	            String 数据库账号 = "root";
	            String 数据库密码 = "root";
	            String 数据库时间 = "serverTimezone=GMT";
	            String url = "jdbc:mysql://localhost/"+数据库名字+"?useSSL=true&"+数据库时间+"&user="+数据库账号+"&password="+数据库密码+"";
	            Connection connection = DriverManager.getConnection(url);

				
	            ResultSet queryRS = null;				//sql执行的结果集
	        	Statement queryStatement = null;		//JDBC SQL执行器
	       		Connection queryConn = null;			//JDBC连接管理器
		        queryConn = connection;					
		        queryStatement = queryConn.createStatement();		
		        String sqlQuery = "select * from student";			//sql语句  得到数据库中的student表中的全部数据
		        queryRS = queryStatement.executeQuery(sqlQuery);	//使用SQL执行器把得到的数据赋值到结果集


				/* 使用out.print()是写到前台给用户看 */
				/* 标题行 */
				out.print("<tr>");
				out.print("<th>主键ID</th>");
				out.print("<th>学号</th>");
				out.print("<th>姓名</th>");
				out.print("<th>性别</th>");
				out.print("<th>年龄</th>");
				out.print("<th>班级</th>");
				out.print("<th>专业</th>");
				out.print("<th>操作</th>");
				out.print("</tr>");
				
				/* 循环输出数据库中的数据 */
				while(queryRS.next()) {
					/* 带有表格输出 */
					int student_id = queryRS.getInt("student_id");
					String student_name =queryRS.getString("student_name");
					out.print("<tr>");
	                out.print("<td>"+queryRS.getInt("student_id")+"</td>");
	                out.print("<td>"+queryRS.getString("student_number")+"</td>");
	                out.print("<td>"+queryRS.getString("student_name")+"</td>");
	                out.print("<td>"+queryRS.getString("student_sex")+"</td>");
	                out.print("<td>"+queryRS.getInt("student_age")+"</td>");
	                out.print("<td>"+queryRS.getString("student_class")+"</td>");
	                out.print("<td>"+queryRS.getString("student_major")+"</td>");
	                out.print("<td>&emsp;<a href="+"indexAMend.jsp?id="+student_id+">修改</a>");
	                out.print("&emsp;<a href="+"indexDoDelete.jsp?id="+student_id+" onclick=\"return confirmDelete('"+student_name+"')\">删除</a>&emsp;</td>");
	                out.print("</tr>");
	            }
				
				/* 不带有表格输出 */
		        /* while(queryRS.next()) {
	                out.print(queryRS.getInt("student_id")+"\t");
	                out.print(queryRS.getString("student_number")+"\t");
	                out.print(queryRS.getString("student_name")+"\t");
	                out.print(queryRS.getString("student_sex")+"\t");
	                out.print(queryRS.getInt("student_age")+"\t");
	                out.print(queryRS.getString("student_class")+"\t");
	                out.println(queryRS.getString("student_major")+"<br>");
	            } */

				queryStatement.close();
				queryRS.close();
	            connection.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println("数据库连接出错");
	        }
	     %>

	     </table>
    </div>
  </body>
</html>
