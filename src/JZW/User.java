package JZW;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.log4j.Logger;

import emailController.Sendemail;
import phoneController.PhoneCode;

public class User {
	private int user_id;			//用户主键
    private String user_account;	//用户账号
    private String user_password;	//用户密码
    private String user_name;		//用户名
    private String user_phone;		//用户手机号
    private String user_email;		//用户邮箱
    private String user_question;	//用户密保问题
    private String user_answer;		//用户密保答案
    private int user_root;			//用户权限
    private String user_root_name; 	//用户权限名称
    private boolean user_deleted;	//用户是否已删除
    private int student_id;			//学生外键
    private int teacher_id;			//教师外键
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
    private boolean remember;		//登录记住账号密码
    private static Logger logger = Logger.getLogger(User.class);	//输出日志

    public User() {}
    
    public Logger getLogger() {
    	return logger;
    }
    
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
    
    public String getPhone() {
    	if(user_phone==null)	return "";
    	else	return user_phone;
    }
    
    public String getPhoneHide() {
    	if(user_phone==null)	return "";
    	else	return user_phone.replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2");
    }
    
    public void setPhone(String user_phone) {
    	this.user_phone = user_phone;
    }
    
    public String getEmail() {
    	if(user_email==null)	return "";
    	else	return user_email;
    }
    
    public String getEmailHide() {
    	if(user_email==null)	return "";
    	else	return user_email.replaceAll("(\\w?)(\\w+)(\\w)(@\\w+\\.[a-z]+(\\.[a-z]+)?)", "$1****$3$4");
    }
    
    public void setEmail(String user_email) {
    	this.user_email = user_email;
    }
    
    public String getQuestion() {
    	if(user_question==null)	return "";
    	else	return user_question;
    }
    
    public void setQuestion(String user_question) {
    	this.user_question = user_question;
    }
    
    public String getAnswer() {
    	if(user_answer==null)	return "";
    	else	return user_answer;
    }
    
    public void setAnswer(String user_answer) {
    	this.user_answer = user_answer;
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
        } catch (Exception e1) {
            e1.printStackTrace();
            logger.error("数据库语句检查或执行出错！添加用户信息失败："+user_account+" "+user_password+" "+user_name+" "+user_root+" "+user_root_name+" "+student_id+" "+teacher_id);
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("添加用户信息"+user_account+" "+user_password+" "+user_name+" "+user_root+" "+user_root_name+" "+student_id+" "+teacher_id+"后数据库关闭出错！");
            }
        }
        logger.info("添加用户信息成功："+user_account+" "+user_password+" "+user_name+" "+user_root+" "+user_root_name+" "+student_id+" "+teacher_id);
        return true;
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
            	user.user_phone = queryRS.getString("user_phone");
            	user.user_name = queryRS.getString("user_name");
            	user.user_email = queryRS.getString("user_email");
            	user.user_question = queryRS.getString("user_question");
            	user.user_answer = queryRS.getString("user_answer");
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
            logger.error("数据库语句检查或执行出错！用户信息查询失败。");
            return userList;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("查询用户信息后数据库关闭出错！");
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
    
    //邮箱查找用户
    public List<User> queryUserByEmail(String user_email) {
        String querySql = "select * from user where user_email="+"'"+user_email+"'";
        return queryUser(querySql);
    }
    
    //手机号查找用户
    public List<User> queryUserByPhone(String user_phone) {
        String querySql = "select * from user where user_phone="+"'"+user_phone+"'";
        return queryUser(querySql);
    }
    
    //账号密码查找用户（手机号、邮箱也可登录）
    public User queryUserByAccountPassword(String account,String password) {
    	String querySql = "select * from user where (user_account="+"'"+account+"'"+" or user_phone="+"'"+account+"'"+" or user_email="+"'"+account+"'"+" ) and user_password="+"'"+password+"'";
    	if(queryUser(querySql).size()!=0) {
    		User user = queryUser(querySql).get(0);
    		if(user.getPassword().equals(password))
    			return user;
    		else
    			return new User();
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
    	String updateStr = "";
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
                updateStr += " 密码:"+user.user_password+"->"+user_password;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 密码"+user.user_password+"为"+user_password+"失败。");
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
                updateStr += " 修改时间:"+user.updated_at+"->"+nowTime;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 修改时间"+user.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改用户 "+user.user_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改用户 "+user.user_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //修改用户名
    public boolean updateUserName(User user,String user_name) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
    	Connection conn = conn();
        //信息有改动时才修改
        if(user_name.equals(user.user_name) == false) {
        	count++;
            String updateSql = "update user set user_name='"+user_name+"' where user_id=" + user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 用户名:"+user.user_name+"->"+user_name;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 用户名"+user.user_name+"为"+user_name+"失败。");
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
                updateStr += " 修改时间:"+user.updated_at+"->"+nowTime;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 修改时间"+user.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改用户 "+user.user_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改用户 "+user.user_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //修改用户邮箱
    public boolean updateUserEmail(User user,String user_email) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
    	Connection conn = conn();
        //信息有改动时才修改
        if(user_email.equals(user.user_email) == false) {
        	count++;
            String updateSql = "update user set user_email='"+user_email+"' where user_id=" + user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 邮箱:"+user.user_email+"->"+user_email;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 邮箱"+user.user_email+"为"+user_email+"失败。");
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
                updateStr += " 修改时间:"+user.updated_at+"->"+nowTime;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 修改时间"+user.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改用户 "+user.user_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改用户 "+user.user_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //修改用户手机号
    public boolean updateUserPhone(User user,String user_phone) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
    	Connection conn = conn();
        //信息有改动时才修改
        if(user_phone.equals(user.user_phone) == false) {
        	count++;
            String updateSql = "update user set user_phone='"+user_phone+"' where user_id=" + user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 手机号:"+user.user_phone+"->"+user_phone;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 手机号"+user.user_phone+"为"+user_phone+"失败。");
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
                updateStr += " 修改时间:"+user.updated_at+"->"+nowTime;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 修改时间"+user.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改用户 "+user.user_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改用户 "+user.user_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //修改用户密保问题答案
    public boolean updateUserQuestionAnswer(User user,String user_question,String user_answer) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
    	Connection conn = conn();
        //信息有改动时才修改
        if(user_question.equals(user.user_question) == false) {
        	count++;
            String updateSql = "update user set user_question='"+user_question+"' where user_id=" + user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 密保问题:"+user.user_question+"->"+user_question;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 密保问题"+user.user_question+"为"+user_question+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        if(user_answer.equals(user.user_answer) == false) {
        	count++;
            String updateSql = "update user set user_answer='"+user_answer+"' where user_id=" + user.user_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 密保答案:"+user.user_answer+"->"+user_answer;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 密保答案"+user.user_answer+"为"+user_answer+"失败。");
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
                updateStr += " 修改时间:"+user.updated_at+"->"+nowTime;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改用户 "+user.user_id+" 修改时间"+user.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改用户 "+user.user_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改用户 "+user.user_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //验证账号密码是否正确（手机号邮箱也可登录）
	public User validateAccountPassword(String account,String password) {
    	User user = queryUserByAccountPassword(account, password);
    	Student stu = new Student();
		if(user.getID()!=0)	{
	        logger.info(user.getRootName()+" "+user.getName()+" 成功登录系统。");  
			return user;
		}
		//判断是否为新学生登录
		if(account.length()==11) {
			if(user.queryUserByAccount(account).getID() == 0 && stu.queryStudentByNumber(account).size() != 0 
				&& password.equals(stu.queryStudentByNumber(account).get(0).getNum().substring(stu.queryStudentByNumber(account).get(0).getNum().length()-6))) {	
				stu = stu.queryStudentByNumber(account).get(0);
				user.creatUser(account, password, stu.getName(), 0, "学生", stu.getID() , 0 , new Date());
				logger.info("学生 "+stu.getName()+" 成功注册。"); 
				return user.queryUserByAccount(account);
			}
		}
		return null;
    }
    
	//判断账号是否存在
    public boolean isExist_account(String user_account) {
    	if(queryUserByAccount(user_account).getID() != 0)	return true;
    	else return false;
    }
	
    //判断邮箱是否存在
    public boolean isExist_email(String user_email) {
    	if(queryUserByEmail(user_email).size() != 0)	return true;
    	else return false;
    }
    
    //判断手机号是否存在
    public boolean isExist_phone(String user_phone) {
    	if(queryUserByPhone(user_phone).size() != 0)	return true;
    	else return false;
    }
    
	//获取所有数据量（无条件）
    public int CountOfAll() {
    	int count = 0;
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
            logger.error("数据库语句检查或执行出错！无条件获取用户数据量失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("无条件获取用户数据量后数据库关闭出错！");
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
            	user.user_phone = rs.getString("user_phone");
            	user.user_email = rs.getString("user_email");
            	user.user_question = rs.getString("user_question");
            	user.user_answer = rs.getString("user_answer");
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
            logger.error("数据库语句检查或执行出错！按条件获取用户信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("按条件获取用户信息后数据库关闭出错！");
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
            	user.user_phone = rs.getString("user_phone");
            	user.user_email = rs.getString("user_email");
            	user.user_question = rs.getString("user_question");
            	user.user_answer = rs.getString("user_answer");
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
            logger.error("数据库语句检查或执行出错！获取用户分页信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("获取用户分页信息后数据库关闭出错！");
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
            	user.user_phone = queryRS.getString("user_phone");
            	user.user_email = queryRS.getString("user_email");
            	user.user_question = queryRS.getString("user_question");
            	user.user_answer = queryRS.getString("user_answer");
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
            logger.error("数据库语句检查或执行出错！获取用户信息失败！");
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
            	logger.error("获取用户信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return userList;
    }
    
    //连接数据库
    public Connection conn() {
    	Connection connection = null;
        try {
        	String driver = MySQLConfig.DRIVER;
            String database = MySQLConfig.DATABASE;
            String username = MySQLConfig.USERNAME;
            String password = MySQLConfig.PASSWORD;
            String url = "jdbc:mysql://localhost/"+database+"?useSSL=true&serverTimezone=Asia/Shanghai&user="+username+"&password="+password+"";
            Class.forName(driver);
            connection = DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("数据库连接出错！");
            return null;
        }
        return connection;
    }

    //发送邮箱验证码
    public boolean sendEmailCode(String code) throws Exception {
    	Sendemail email = new Sendemail();
		String to = this.getEmail();
		String title = "神葳总局邮箱验证";
		String content ="<div style='width:640px; background:#fff; border:solid 1px #efefef; margin:0 auto; padding:0 0 0 0'>"+
			" <table width='560' border='0' align='center' cellpadding='0' cellspacing='0' style=' margin:0 auto; margin-left:30px; margin-right:30px;'>"+
			"    <tbody>"+
			"      <td>"+
			"      <h3 style='font-weight:normal; font-size:18px'>您好！<span style='font-weight:bold; margin-left:5px;'>"+this.getName()+"</span></h3>"+
			"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>神葳总局邮箱验证通知:</p>"+
			"      <p style='color:#666; font-size:14px'>您正在进行神葳总局用户邮箱验证，您收到的邮箱验证码为： "+
			"      <p style='color:red; font-size:28px'>"+code+
			"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>如果验证码已经失效，请回到神葳总局重新发送验证码，谢谢您的合作！</p>"+
			"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>如非本人操作，请忽略此邮件，由此给您带来的不便请谅解！</p>"+
			"      <p style='margin:5px 0; padding:3px 0;color:#666; font-size:14px'>感谢您对神葳总局的支持。</p>"+
			"      </td>"+
			"    </tbody>"+
			" </table>"+
			"</div>";
		if(email.send(to,title,content)){
			logger.info(this.getID()+" 发送邮箱验证码 "+code+" 成功！"+to);
			return true;
		}else {
			logger.error(this.getID()+" 发送邮箱验证码 "+code+" 失败！"+to);
			return false;
		}
    }
    
    //创建邮箱验证码
    public static String getEmailCode() {
		String string = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer code = new StringBuffer();
		for (int i = 0; i < 6; i++) {
			Random random = new Random();
			int index = random.nextInt(string.length());
			char ch = string.charAt(index);
			code.append(ch);
		}
		return code.toString();
	}
    
    //发送手机验证码
    public boolean sendPhoneCode(String to,String code) throws Exception {
    	PhoneCode phone = new PhoneCode();
    	if(phone.sendPhoneCode(to,code)){
			logger.info(this.getID()+" 发送手机验证码 "+code+" 成功！"+to);
			return true;
		}else {
			logger.error(this.getID()+" 发送手机验证码 "+code+" 失败！"+to);
			return false;
		}
    }
    
    //创建手机短信验证码
    public static String getPhoneCode() {
    	String random = (int) ((Math.random() * 9 + 1) * 100000) + "";
		return random;
	}
    
    //上传用户头像
    public void decodeBase64DataURLToImage(String dataURL, String path, String imgName) throws IOException {
        // 将dataURL开头的非base64字符删除
        String base64 = dataURL.substring(dataURL.indexOf(",") + 1);
        //目录不存在先创建目录
        File file = new File(path);if(!file.exists()){file.mkdirs();}
        FileOutputStream write = new FileOutputStream(new File(path  + "\\" + imgName));
        //目录不存在先创建目录(复制一份到本地硬盘)
        File newFile = new File("C:/CSMS-public/upload/userAvatar");if(!newFile.exists()){newFile.mkdirs();}
        FileOutputStream write1 = new FileOutputStream(new File(newFile + "/" + imgName));
        byte[] decoderBytes = Base64.getDecoder().decode(base64);
        write.write(decoderBytes);
        write.close();
        byte[] decoderBytes1 = Base64.getDecoder().decode(base64);
        write1.write(decoderBytes1);
        write1.close();
    }
}
