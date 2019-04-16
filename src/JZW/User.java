package JZW;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {
	private int user_id;			//用户主键
    private String user_account;	//用户账号
    private String user_password;	//用户密码
    private String user_name;		//用户名
    private int user_root;			//用户权限
    private String user_root_name; 	//用户权限名称
    private boolean user_deleted;	//用户是否已删除
    private int student_id;			//学生外键
    private int teacher_id;			//教师外键
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
    private boolean remember;		//登录记住账号密码

    public User() {}
    
    public boolean getRemember() {
    	return remember;
    }
    
    public void setRemember(boolean remember) {
    	this.remember=remember;
    }
    
    public int getID() {
    	return user_id;
    }
    
    public void setID(int user_id) {
    	this.user_id = user_id;
    }
    
    public String getAccount() {
    	return user_account;
    }
    
    public void setAccount(String user_account) {
    	this.user_account = user_account;
    }
    
    public String getPassword() {
    	return user_password;
    }
    
    public void setPassword(String user_password) {
    	this.user_password = user_password;
    }
    
    public String getName() {
    	if(user_name==null)	return "";
    	else	return user_name;
    }
    
    public void setName(String user_name) {
    	this.user_name = user_name;
    }
    
    public int getRoot() {
    	return user_root;
    }
    
    public void setRoot(int user_root) {
    	this.user_root = user_root;
    }
    
    public String getRootName() {
    	return user_root_name;
    }
    
    public void setRootName(String user_root_name) {
    	this.user_root_name = user_root_name;
    }
    
    public String getIsDeleteStr() {
    	if(user_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return user_deleted;
    }
    
    public void setIsDeleted(boolean user_deleted) {
    	this.user_deleted = user_deleted;
    }
    
    public int getStudentID() {
    	return student_id;
    }
    
    public void setStudentID(int student_id) {
    	this.student_id = student_id;
    }
    
    public int getTeacherID() {
    	return teacher_id;
    }
    
    public void setTeacherID(int teacher_id) {
    	this.teacher_id = teacher_id;
    }
    
    public String getCreated() {
        if(created_at!=null) {
        	DateFormat t = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String Created = t.format(created_at);
            return Created;
    	}else {
    		return "";
    	}
    }
    
    public void setCreated(Date created_at) {
    	this.created_at = created_at;
    }

    public String getUpdated() {
        if(updated_at!=null) {
        	DateFormat t = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String Updated = t.format(updated_at);
            return Updated;
    	}else {
    		return "";
    	}
    }
    
    public void setUpdated(Date updated_at) {
    	this.updated_at = updated_at;
    }
    
    public String getDeleted() {
    	if(deleted_at!=null) {
    		DateFormat t = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String Deleted = t.format(deleted_at);
            return Deleted;
    	}else {
    		return "";
    	}
    }
    
    public void setDeleted(Date deleted_at) {
    	this.deleted_at = deleted_at;
    }
    
    //添加用户
    public boolean creatUser(String user_account,String user_password,String user_name,int user_root,String user_root_name,int student_id,int teacher_id,Date created_at) {
    	String insertSql =
        		"insert into user("
        			+ "user_account,"
        			+ "user_password,"
        			+ "user_name,"
        			+ "user_root,"
        			+ "user_root_name,"
	        		+ "student_id,"
	        		+ "teacher_id,"
	        		+ "created_at) "
        		+ "values(?,?,?,?,?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1, user_account);
        	ps.setString(2, user_password);
        	ps.setString(3, user_name);
        	ps.setInt(4, user_root);
        	ps.setString(5, user_root_name);
        	if(student_id != 0)	ps.setInt(6, student_id);	else	ps.setNull(6, Types.INTEGER);
        	if(teacher_id != 0)	ps.setInt(7, teacher_id);	else	ps.setNull(7, Types.INTEGER);
        	ps.setTimestamp(8, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
            return true;
        } catch (Exception e1) {
            e1.printStackTrace();
            System.out.println("添加用户信息失败！");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    }
    
    
    //查询用户信息
    public List<User> queryUser(String querySql) {
        List<User> userList = new ArrayList<User>();
        User user = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                user = new User();
                user.user_id = queryRS.getInt("user_id");
            	user.user_account = queryRS.getString("user_account");
            	user.user_password = queryRS.getString("user_password");
            	user.user_name = queryRS.getString("user_name");
            	user.user_root = queryRS.getInt("user_root");
            	user.user_root_name = queryRS.getString("user_root_name");
            	user.user_deleted = queryRS.getBoolean("user_deleted");
            	user.student_id = queryRS.getInt("student_id");
            	user.teacher_id = queryRS.getInt("teacher_id");
            	user.created_at = queryRS.getTimestamp("created_at");
            	user.updated_at = queryRS.getTimestamp("updated_at");
            	user.deleted_at = queryRS.getTimestamp("deleted_at");
            	userList.add(user);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            return null;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return userList;
    }
    
    //主键查找用户
    public User queryUserByID(int user_id) {
        String querySql = "select * from user where user_id="+"'"+user_id+"'";
        if(queryUser(querySql).size()!=0) {
        	return queryUser(querySql).get(0);
        }else {
        	return new User();
        }
    }
    
    //账号查找用户
    public User queryUserByAccount(String user_account) {
        String querySql = "select * from user where user_account="+"'"+user_account+"'";
        if(queryUser(querySql).size()!=0) {
        	return queryUser(querySql).get(0);
        }else {
        	return new User();
        }
    }
    
    //账号密码查找用户
    public User queryUserByAccountPassword(String account,String password) {
    	String querySql = "select * from user where user_account="+"'"+account+"'"+" and user_password="+"'"+password+"'";
    	if(queryUser(querySql).size()!=0) {
        	return queryUser(querySql).get(0);
        }else {
        	return new User();
        }
    }
    
    //权限查找用户
    public List<User> queryUserByRoot(int user_root) {
        String querySql = "select * from user where user_root="+"'"+user_root+"'";
        return queryUser(querySql);
    }
    
    //查询用户信息（按是否已删除查找）
    public List<User> queryUserByIsDeleted(boolean user_deleted) {
    	int deleted = user_deleted?1:0;
    	String querySql = "select * from user where user_deleted="+"'"+deleted+"'";
        return queryUser(querySql);
    }
    
    //修改用户密码
    public boolean updateUserPassword(User user,String user_password) {
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
    	Connection conn = conn();
        //信息有改动时才修改
        if(user_password.equals(user.user_password) == false) {
        	count++;
            String updateSql = "update user set user_password='"+user_password+"' where user_id=" + user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        if(nowTime != user.updated_at&&count != 0) {
        	String updateSql = "update user set updated_at = ? where user_id="+ user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(nowTime.getTime()));
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
        }
        return true;
    }
    

    //验证账号密码是否正确
	public User validateAccountPassword(String account,String password) {
    	User user = queryUserByAccountPassword(account, password);
    	Student stu = new Student();
		if(user.getID()!=0)	return user;
		//判断是否为新学生登录
		if(user.queryUserByAccount(account).getID() == 0 && stu.queryStudentByNumber(account).size() != 0 && password.equals("123456")) {	
			stu = stu.queryStudentByNumber(account).get(0);
			Date created_at = new Date();
			user.creatUser(account, password, stu.getName(), 0, "学生", stu.getID() , 0 , created_at);
			return user.queryUserByAccount(account);
		}
		return null;
    }
    
	//获取所有数据量（无条件）
    public int CountOfAll() {
    	int count;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
            conn = conn();
            ps = conn.prepareStatement("select count(*) from user");
            rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        }catch(Exception e2) {
            e2.printStackTrace();
            return 0;
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return count;
    }
    
    //按条件获取用户数据
    public List<User> queryByConditionByString(String querySql,String queryStr) {
    	List<User> userList = new ArrayList<User>();
        User user = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
            rs = ps.executeQuery();
            while(rs.next()) {
            	user = new User();
            	user.user_id = rs.getInt("user_id");
            	user.user_account = rs.getString("user_account");
            	user.user_password = rs.getString("user_password");
            	user.user_name = rs.getString("user_name");
            	user.user_root = rs.getInt("user_root");
            	user.user_root_name = rs.getString("user_root_name");
            	user.user_deleted = rs.getBoolean("user_deleted");
            	user.student_id = rs.getInt("student_id");
            	user.teacher_id = rs.getInt("teacher_id");
            	user.created_at = rs.getTimestamp("created_at");
            	user.updated_at = rs.getTimestamp("updated_at");
            	user.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		userList.add(user);
            	}
            	else if(user.user_name.indexOf(queryStr)!=-1||
            			user.user_root_name.indexOf(queryStr)!=-1) {
            		userList.add(user);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            return userList;
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return userList;
    }
    
    //按条件获取用户数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<User> queryByCondition(int user_deleted,String queryStr) {
    	if(user_deleted==2&&queryStr.length()==0) {
    		return queryByConditionByString("select * from user",queryStr);
    	}else {
    		String querySql = "select * from user where";
    		if(user_deleted!=2)	querySql += " user_deleted = "+user_deleted+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		return queryByConditionByString(querySql,queryStr);
    	}
    }

    //返回分页数据
    public List<User> cutPageDataByString(int page,int pageSize,String querySql,String queryStr){
    	List<User> userList = new ArrayList<User>();
        User user = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
        	if(queryStr.length()==0) {
        		ps = conn.prepareStatement(querySql);
                ps.setInt(1,page*pageSize-pageSize);
        		ps.setInt(2,pageSize);
            }else {
            	querySql = querySql.substring(0, querySql.length()-10);
            	ps = conn.prepareStatement(querySql);
            }
            rs = ps.executeQuery();
            while(rs.next()) {
            	user = new User();
            	user.user_id = rs.getInt("user_id");
            	user.user_account = rs.getString("user_account");
            	user.user_password = rs.getString("user_password");
            	user.user_name = rs.getString("user_name");
            	user.user_root = rs.getInt("user_root");
            	user.user_root_name = rs.getString("user_root_name");
            	user.user_deleted = rs.getBoolean("user_deleted");
            	user.student_id = rs.getInt("student_id");
            	user.teacher_id = rs.getInt("teacher_id");
            	user.created_at = rs.getTimestamp("created_at");
            	user.updated_at = rs.getTimestamp("updated_at");
            	user.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		userList.add(user);
            	}
            	else if(user.user_name.indexOf(queryStr)!=-1||
            			user.user_root_name.indexOf(queryStr)!=-1) {
            		userList.add(user);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            return userList;
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        if(queryStr.length()==0) {
        	return userList;
        }else {
        	int count = queryByConditionByString(querySql,queryStr).size();
        	int start = page*pageSize-pageSize;
        	int end;
        	if(start == (count/pageSize)*pageSize) {
        		end = start+count%pageSize;
        		return userList.subList(start, end);
        	}else {
        		end = start+pageSize;
        		return userList.subList(start, end);
        	}
        }
    }
    
    //返回分页数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<User> cutPageData(int page,int pageSize,int user_deleted,String queryStr){
    	if(user_deleted==2&&queryStr.length()==0) {
    		return cutPageDataByString(page,pageSize,"select * from user limit ?,?",queryStr);
    	}else {
    		String querySql = "select * from user where";
    		if(user_deleted!=2)	querySql += " user_deleted = "+user_deleted+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += "limit ?,?";
    		return cutPageDataByString(page,pageSize,querySql,queryStr);
    	}
    }
 
    //从数据库获取所有用户信息返回用户表
    public List<User> getUserInfo() {
        List<User> userList = new ArrayList<User>();
        User user = null;
        ResultSet queryRS = null;
        Statement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.createStatement();
            String sqlQuery = "select * from user";
            queryRS = queryStatement.executeQuery(sqlQuery);
            while(queryRS.next()) {
            	user = new User();
            	user.user_id = queryRS.getInt("user_id");
            	user.user_account = queryRS.getString("user_account");
            	user.user_password = queryRS.getString("user_password");
            	user.user_name = queryRS.getString("user_name");
            	user.user_root = queryRS.getInt("user_root");
            	user.user_root_name = queryRS.getString("user_root_name");
            	user.user_deleted = queryRS.getBoolean("user_deleted");
            	user.student_id = queryRS.getInt("student_id");
            	user.teacher_id = queryRS.getInt("teacher_id");
            	user.created_at = queryRS.getTimestamp("created_at");
            	user.updated_at = queryRS.getTimestamp("updated_at");
            	user.deleted_at = queryRS.getTimestamp("deleted_at");
            	userList.add(user);
            }
            return userList;
        }catch(Exception e2) {
            e2.printStackTrace();
            return null;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    }
    
    //连接数据库
    public Connection conn() {
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost/csms?useSSL=true&serverTimezone=Asia/Shanghai&user=root&password=root";
            Class.forName(driver);
            Connection connection = DriverManager.getConnection(url);
            return connection;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("数据库连接出错");
        }
        return null;
    }

}
