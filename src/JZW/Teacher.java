package JZW;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;
import java.util.List;

import org.apache.log4j.Logger;

public class Teacher {
	private int teacher_id;			//教师主键
    private String teacher_number;	//教师编号
    private String teacher_name;	//教师姓名
    private String teacher_position;//教师职称
    private int teacher_cdtcount;	//教师拥有的课题总数
    private double teacher_grade;	//教师评分
    private boolean teacher_deleted;//教师是否已删除
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
 
    public Teacher() {}
 
    public int getID() {
    	return teacher_id;
    }
    
    public void setID(int teacher_id) {
    	this.teacher_id = teacher_id;
    }
    
    public String getNum() {
        return teacher_number;
    }
 
    public void setNum(String teacher_number) {
        this.teacher_number = teacher_number;
    }
 
    public String getName() {
        return teacher_name;
    }
 
    public void setName(String teacher_name) {
        this.teacher_name = teacher_name;
    }
    
    public String getPosition() {
		return teacher_position==null?"":teacher_position;
	}

	public void setPosition(String teacher_position) {
		this.teacher_position = teacher_position;
	}
    
    public int getCDTcount() {
        return teacher_cdtcount;
    }
 
    public void setCDTcount(int teacher_cdtcount) {
        this.teacher_cdtcount = teacher_cdtcount;
    }
    
    public String getGradeStr() {
    	if(teacher_grade==0)	return "无";
    	else {
    		DecimalFormat df = new DecimalFormat("0.0"); 
    		return df.format(teacher_grade);
    	}
    }
    
    public double getGrade() {
    	return teacher_grade;
    }
    
    public void setGrade(double teacher_grade) {
    	this.teacher_grade = teacher_grade;
    }
    
    public String getIsDeleteStr() {
    	if(teacher_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return teacher_deleted;
    }
    
    public void setIsDeleted(boolean teacher_deleted) {
    	this.teacher_deleted = teacher_deleted;
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
 
    //添加教师信息
	public boolean CreateTeacher(String teacher_number,String teacher_name,String teacher_position,Date created_at) {
		String insertSql = 
        		"insert into teacher("
        			+ "teacher_number,"
        			+ "teacher_name,"
        			+ "teacher_position,"
	        		+ "created_at) "
        		+ "values(?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1, teacher_number);
        	ps.setString(2, teacher_name);
        	ps.setString(3, teacher_position);
        	ps.setTimestamp(4, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            logger.error("数据库语句检查或执行出错！添加教师信息失败："+teacher_number+" "+teacher_name+" "+teacher_position);
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("添加教师信息"+teacher_number+" "+teacher_name+" "+teacher_position+"后数据库关闭失败！");
            }
        }
        logger.info("添加教师信息成功："+teacher_number+" "+teacher_name+" "+teacher_position);
        return true;
    }
 
    //删除教师信息
    public boolean deleteTeacherByID(int teacher_id) {
        Connection conn = conn();
        String deleteSql = "delete from teacher where teacher_id=" + teacher_id;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(deleteSql);
            ps.executeUpdate();
        } catch (Exception e) {
        	logger.error("数据库语句检查或执行出错！删除教师 "+teacher_id+" 失败。");
            e.printStackTrace();
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("删除教师 "+teacher_id+" 后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        logger.info("删除教师 "+teacher_id+" 成功。");
        return true;
    }
 
    //查询教师信息
    public List<Teacher> queryTeacher(String querySql) {
        List<Teacher> teaList = new ArrayList<Teacher>();
        Teacher tea = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                tea = new Teacher();
                tea.teacher_id = queryRS.getInt("teacher_id");
                tea.teacher_number = queryRS.getString("teacher_number");
                tea.teacher_name = queryRS.getString("teacher_name");
                tea.teacher_position = queryRS.getString("teacher_position");
                tea.teacher_cdtcount = queryRS.getInt("teacher_cdtcount");
                tea.teacher_grade = queryRS.getDouble("teacher_grade");
                tea.teacher_deleted = queryRS.getBoolean("teacher_deleted");
                tea.created_at = queryRS.getTimestamp("created_at");
                tea.updated_at = queryRS.getTimestamp("updated_at");
                tea.deleted_at = queryRS.getTimestamp("deleted_at");
                teaList.add(tea);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！教师信息查询失败。");
            return teaList;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("查询教师信息后数据库关闭出错！");
            }
        }
        return teaList;
    }
    
    
    //查询教师信息（按主键查找）
    public Teacher queryTeacherByID(int teacher_id) {
        String querySql = "select * from teacher where teacher_id="+"'"+teacher_id+"'";
        if(queryTeacher(querySql).size()!=0) {
        	return queryTeacher(querySql).get(0);
        }else {
        	return new Teacher();
        }
    }
 
    //查询教师信息（按编号查找）
    public Teacher queryTeacherByNumber(String teacher_number) {
    	String querySql = "select * from teacher where teacher_number="+"'"+teacher_number+"'";
    	if(queryTeacher(querySql).size()!=0) {
        	return queryTeacher(querySql).get(0);
        }else {
        	return new Teacher();
        }
    }
    
    //查询教师信息（按姓名查找）
    public List<Teacher> queryTeacherByName(String teacher_name) {
    	String querySql = "select * from teacher where teacher_name="+"'"+teacher_name+"'";
        return queryTeacher(querySql);
    }
    
    //查询教师信息（按职称查找）
    public List<Teacher> queryTeacherByPosition(String teacher_position) {
    	String querySql = "select * from teacher where teacher_position="+"'"+teacher_position+"'";
        return queryTeacher(querySql);
    }
    
 	//查询教师信息（按是否已删除查找）
    public List<Teacher> queryTeacherByIsDeleted(boolean teacher_deleted) {
    	int deleted = teacher_deleted?1:0;
    	String querySql = "select * from teacher where teacher_deleted="+"'"+deleted+"'";
        return queryTeacher(querySql);
    }
    
    //修改教师信息
    public boolean updateTeacher(Teacher tea,String teacher_number,String teacher_name,String teacher_position,Date updated_at) {
 
    	String updateStr = "";
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(teacher_number.equals(tea.teacher_number) == false) {
        	count++;
            String updateSql = "update teacher set teacher_number='"+teacher_number+"' where teacher_id=" + tea.teacher_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 编号:"+tea.teacher_number+"->"+teacher_number;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改教师 "+tea.teacher_id+" 编号"+tea.teacher_number+"为"+teacher_number+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(teacher_name.equals(tea.teacher_name) == false) {
        	count++;
            String updateSql = "update teacher set teacher_name='"+teacher_name+"' where teacher_id=" + tea.teacher_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 姓名:"+tea.teacher_name+"->"+teacher_name;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改教师 "+tea.teacher_id+" 姓名"+tea.teacher_name+"为"+teacher_name+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(teacher_position.equals(tea.teacher_position) == false) {
        	count++;
            String updateSql = "update teacher set teacher_position='"+teacher_position+"' where teacher_id=" + tea.teacher_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 职称:"+tea.teacher_position+"->"+teacher_position;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改教师 "+tea.teacher_id+" 职称"+tea.teacher_position+"为"+teacher_position+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(updated_at != tea.updated_at&&count != 0) {
        	String updateSql = "update teacher set updated_at = ? where teacher_id="+ tea.teacher_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(updated_at.getTime()));
                ps.executeUpdate();
                ps.close();
                updateStr += " 修改时间:"+tea.updated_at+"->"+updated_at;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改教师 "+tea.teacher_id+" 修改时间"+tea.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改教师 "+tea.teacher_id+" 信息"+updateStr+"后数据库关闭出错！");
        }
        if(count != 0 ) {
        	logger.info("修改教师 "+tea.teacher_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //刷新教师拥有的课题总数
    public boolean refreshCDTopicCountByID(int teacher_id) {
    	if(teacher_id > 0) {
    		Connection conn = conn();
    		CDTopic cdt = new CDTopic();
        	String updateSql = "update teacher set teacher_cdtcount='"+cdt.queryCDTopicByTeacherID(teacher_id).size()+"' where teacher_id=" + teacher_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                conn.close();
                return true;
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！刷新教师 "+teacher_id+" 拥有的课题总数失败。");
                return false;
            } 
    	}else {
    		logger.warn("传入的教师ID必须为正整数！刷新教师 "+teacher_id+" 拥有的课题总数失败。");
    		return false;
    	}
    }
    
    //刷新所有教师拥有的课题总数
    public boolean refreshCDTopicCountOfAll() {
    	Connection conn = conn();
    	List<Teacher> teaList = getTeacherInfo();
		for(Teacher teacher:teaList) {
			teacher.refreshCDTopicCountByID(teacher.getID());
		}
		try {
			conn.close();
			logger.info("刷新所有教师拥有的课题总数成功！");
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("刷新所有教师拥有的课题总数后数据库关闭失败！");
			return false;
		}
    }
    
    //判断编号是否存在
    public boolean isExist_number(String teacher_number) {
    	if(queryTeacherByNumber(teacher_number).getID() != 0)	return true;
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
            ps = conn.prepareStatement("select count(*) from teacher");
            rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！无条件获取教师数据量失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("无条件获取教师数据量后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return count;
    }
    
    //按条件获取教师数据
    public List<Teacher> queryByConditionByString(String querySql,String queryStr) {
    	List<Teacher> teaList = new ArrayList<Teacher>();
        Teacher tea = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
            rs = ps.executeQuery();
            while(rs.next()) {
                tea = new Teacher();
                tea.teacher_id = rs.getInt("teacher_id");
                tea.teacher_number = rs.getString("teacher_number");
                tea.teacher_name = rs.getString("teacher_name");
                tea.teacher_position = rs.getString("teacher_position");
                tea.teacher_cdtcount = rs.getInt("teacher_cdtcount");
                tea.teacher_grade = rs.getDouble("teacher_grade");
                tea.teacher_deleted = rs.getBoolean("teacher_deleted");
                tea.created_at = rs.getTimestamp("created_at");
                tea.updated_at = rs.getTimestamp("updated_at");
                tea.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		teaList.add(tea);
            	}
            	else if(tea.teacher_number.indexOf(queryStr)!=-1||
            			tea.teacher_name.indexOf(queryStr)!=-1||
            			tea.teacher_position.indexOf(queryStr)!=-1) {
            		teaList.add(tea);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！按条件获取教师信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("按条件获取教师信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return teaList;
    }
    
    //按条件获取教师数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<Teacher> queryByCondition(int teacher_deleted,String queryStr) {
    	if(teacher_deleted==2&&queryStr.length()==0) {
    		return queryByConditionByString("select * from teacher",queryStr);
    	}else {
    		String querySql = "select * from teacher where";
    		if(teacher_deleted!=2)	querySql += " teacher_deleted = "+teacher_deleted+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		return queryByConditionByString(querySql,queryStr);
    	}
    }

    //返回分页数据
    public List<Teacher> cutPageDataByString(int page,int pageSize,String querySql,String queryStr){
    	List<Teacher> teaList = new ArrayList<Teacher>();
        Teacher tea = null;
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
                tea = new Teacher();
                tea.teacher_id = rs.getInt("teacher_id");
                tea.teacher_number = rs.getString("teacher_number");
                tea.teacher_name = rs.getString("teacher_name");
                tea.teacher_position = rs.getString("teacher_position");
                tea.teacher_cdtcount = rs.getInt("teacher_cdtcount");
                tea.teacher_grade = rs.getDouble("teacher_grade");
                tea.teacher_deleted = rs.getBoolean("teacher_deleted");
                tea.created_at = rs.getTimestamp("created_at");
                tea.updated_at = rs.getTimestamp("updated_at");
                tea.deleted_at = rs.getTimestamp("deleted_at");
                if(queryStr.length()==0) {
            		teaList.add(tea);
            	}
            	else if(tea.teacher_number.indexOf(queryStr)!=-1||
            			tea.teacher_name.indexOf(queryStr)!=-1||
            			tea.teacher_position.indexOf(queryStr)!=-1) {
            		teaList.add(tea);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取教师分页信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("获取教师分页信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        if(queryStr.length()==0) {
        	return teaList;
        }else {
        	int count = queryByConditionByString(querySql,queryStr).size();
        	int start = page*pageSize-pageSize;
        	int end;
        	if(start == (count/pageSize)*pageSize) {
        		end = start+count%pageSize;
        		return teaList.subList(start, end);
        	}else {
        		end = start+pageSize;
        		return teaList.subList(start, end);
        	}
        }
    }
    
    //返回分页数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<Teacher> cutPageData(int page,int pageSize,int teacher_deleted,String queryStr){
    	if(teacher_deleted==2&&queryStr.length()==0) {
    		return cutPageDataByString(page,pageSize,"select * from teacher limit ?,?",queryStr);
    	}else {
    		String querySql = "select * from teacher where";
    		if(teacher_deleted!=2)	querySql += " teacher_deleted = "+teacher_deleted+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += "limit ?,?";
    		return cutPageDataByString(page,pageSize,querySql,queryStr);
    	}
    }
    
    //从数据库获取所有教师信息返回教师表
    public List<Teacher> getTeacherInfo() {
        List<Teacher> teaList = new ArrayList<Teacher>();
        Teacher tea = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from teacher";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                tea = new Teacher();
                tea.teacher_id = queryRS.getInt("teacher_id");
                tea.teacher_number = queryRS.getString("teacher_number");
                tea.teacher_name = queryRS.getString("teacher_name");
                tea.teacher_position = queryRS.getString("teacher_position");
                tea.teacher_grade = queryRS.getDouble("teacher_grade");
                tea.teacher_cdtcount = queryRS.getInt("teacher_cdtcount");
                tea.teacher_deleted = queryRS.getBoolean("teacher_deleted");
                tea.created_at = queryRS.getTimestamp("created_at");
                tea.updated_at = queryRS.getTimestamp("updated_at");
                tea.deleted_at = queryRS.getTimestamp("deleted_at");
                teaList.add(tea);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取教师信息失败！");
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
            	logger.error("获取教师信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return teaList;
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

}