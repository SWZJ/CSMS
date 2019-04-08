<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test5.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <h1>节奏葳的测试页面</h1><hr>
    
    <%
    	Connection connection = null;
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost/课程设计选题管理系统?useSSL=true&serverTimezone=GMT&user=root&password=root";
            Class.forName(driver);
            connection = DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("数据库连接出错");
        }
        
        ResultSet queryRS = null;
        Statement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = connection;
            queryStatement = queryConn.createStatement();
            String sqlQuery = "select * from student";
            queryRS = queryStatement.executeQuery(sqlQuery);
            while(queryRS.next()) {
				out.print(queryRS.getInt("student_id"));
				out.print(queryRS.getString("student_number"));
				out.print(queryRS.getString("student_name"));
				out.print(queryRS.getString("student_sex"));
				out.print(queryRS.getInt("student_age"));
				out.print(queryRS.getString("student_class"));
				out.print(queryRS.getString("student_major"));
				out.print(queryRS.getInt("cdtopic_id"));
				out.print(queryRS.getInt("created_at"));
				out.print(queryRS.getInt("updated_at"));
				out.print(queryRS.getInt("deleted_at"));
				out.print("<br>");
            }
        }catch(Exception e2) {
            e2.printStackTrace();
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    
    
     %>
    

  </body>
</html>
