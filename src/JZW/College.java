package JZW;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

public class College {
	private int college_id;	        //学院主键
	private String college_identifier;//学院标识符
    private String college_name;   	//学院名称
    private boolean college_deleted;  //学院是否已删除
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
    
    public College() {}
	 
    public int getID() {
    	return college_id;
    }
    
    public void setID(int college_id) {
    	this.college_id = college_id;
    }
    
    public String getIdentifier() {
        return college_identifier;
    }
 
    public void setIdentifier(String college_identifier) {
        this.college_identifier = college_identifier;
    }
    
    public String getName() {
        return college_name;
    }
 
    public void setName(String college_name) {
        this.college_name = college_name;
    }
 
    public String getIsDeleteStr() {
    	if(college_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return college_deleted;
    }
    
    public void setIsDeleted(boolean college_deleted) {
    	this.college_deleted = college_deleted;
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
    //添加学院信息
	public boolean CreateCollege(String college_identifier,String college_name,Date created_at) {
		String insertSql = 
        		"insert into college("
        			+ "college_identifier"
        			+ "college_name,"
	        		+ "created_at) "
        		+ "values(?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1,college_identifier);
        	ps.setString(2, college_name);  
        	ps.setTimestamp(5, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            System.out.println("添加学院信息失败！");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        return true;
    }

	//删除学院信息
    public boolean deleteCollegeByID(int college_id) {
        Connection conn = conn();
        String deleteSql = "delete from college where college_id=" +college_id;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(deleteSql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("数据库语句检查或执行出错");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return true;
    }
    
    //删除学院信息时，先将学生表及班级表及专业表中对应的学院信息置空
    public boolean refreshCollegeID(int college_id) {

    	 Connection conn = conn();
         String deleteSQL1 = "update student set college_id=null where college_id="+"'"+college_id+"'"+"update class set college_id=null where college_id="+"'"+college_id+"'"+"update major set college_id=null where college_id="+"'"+college_id+"'";
         PreparedStatement ps = null;
         
         try {
             ps = conn.prepareStatement(deleteSQL1);
             ps.executeUpdate();
         } catch (Exception e) {
             e.printStackTrace();
             System.out.println("数据库语句检查或执行出错");
             return false;
         } finally {
             try {
                 ps.close();
                 conn.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
             }
         }
         
         return true;
    }
    
    //查询学院信息
    public List<College> queryCollege(String querySql) {
        List<College> coList = new ArrayList<College>();
        College co = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	co = new College();
            	co.college_id = queryRS.getInt("college_id"); 
            	co.college_name = queryRS.getString("college_name");
            	co.college_identifier = queryRS.getString("college_identifier");
            	co.college_deleted = queryRS.getBoolean("college_deleted");
            	co.created_at = queryRS.getTimestamp("created_at");
            	co.updated_at = queryRS.getTimestamp("updated_at");
            	co.deleted_at = queryRS.getTimestamp("deleted_at");
            	coList.add(co);
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
        return coList;
    }
    
    
    //查询学院信息（按主键查找）
    public College queryCollegeByID(int college_id) {
        String querySql = "select * from college where college_id="+"'"+college_id+"'";
        if(queryCollege(querySql).size()!=0) {
        	return queryCollege(querySql).get(0);
        }else {
        	return new College();
        }
    }
 
    //查询学院信息（按编号查找）
    public List<College> queryCollegeByIdentifier(String college_identifier) {
    	String querySql = "select * from college where college_identifier="+"'"+college_identifier+"'";
    	return queryCollege(querySql);
    }
    
    //查询学院信息（按名称查找）
    public List<College> queryCollegeByName(String college_name) {
    	String querySql = "select * from college where college_name="+"'"+college_name+"'";
        return queryCollege(querySql);
    }
   
   
    //查询学院信息（按是否已删除查找）
    public List<College> queryCollegeByIsDeleted(boolean college_deleted) {
    	int deleted = college_deleted?1:0;
    	String querySql = "select * from college where college_deleted="+"'"+deleted+"'";
        return queryCollege(querySql);
    }
    
    //修改学院信息
    public boolean updateCollege(College co,String college_identifier,String college_name,Date updated_at) {
 
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(college_identifier.equals(co.college_identifier) == false) {
        	count++;
            String updateSql = "update college set college_identifier='"+college_identifier+"' where college_id=" + co.college_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(college_name.equals(co.college_name) == false) {
        	count++;
            String updateSql = "update college set college_name='"+college_name+"' where college_id=" + co.college_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        
        
        if(updated_at != co.updated_at&&count != 0) {
        	String updateSql = "update college set updated_at = ? where college_id=" + co.college_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(updated_at.getTime()));
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
 
    
    //判断学院标识符是否存在
    public boolean isExist_number(String college_identifier) {
    	if(queryCollegeByIdentifier(college_identifier).size() != 0)	return true;
    	else return false;
    }
  

	    //获取数据量
    public int CountByString(String querySql) {
    	int count;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
            conn = conn();
            ps = conn.prepareStatement(querySql);
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
    
    //获取总数据条数（是否删除）（boolean型的2表示不考虑该条件）
    public int Count(int college_deleted) {
    	switch(college_deleted) {
    	case 2:
				return CountByString("select count(*) from college");
    	default:
				return CountByString("select count(*) from college where college_deleted = "+college_deleted);
    	}
    }
    
    
    //返回分页数据
    public List<College> cutPageDataByString(int page,int pageSize,String querySql){
        List<College> coList = new ArrayList<College>();
        College co = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
            ps.setInt(1,page*pageSize-pageSize);
            ps.setInt(2,pageSize);
            rs = ps.executeQuery();
            while(rs.next()) {
            	co = new College();
            	co.college_id = rs.getInt("college_id");
            	co.college_identifier = rs.getString("college_identifier");
            	co.college_name = rs.getString("college_name");
            	co .college_deleted = rs.getBoolean("college_deleted");
            	co .created_at = rs.getTimestamp("created_at");
            	co .updated_at = rs.getTimestamp("updated_at");
            	co .deleted_at = rs.getTimestamp("deleted_at");
                coList.add(co);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            return null;
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return coList;
    }
    
    //返回分页数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<College> cutPageData(int page,int pageSize,int major_deleted){
    	switch(major_deleted) {
    	case 2:
				return cutPageDataByString(page,pageSize,"select * from major limit ?,?");
    	default:
				return cutPageDataByString(page,pageSize,"select * from college where college_deleted = "+college_deleted+" limit ?,?");
    	}
    }
    
    
    //从数据库获取所有学院信息返回学院表
    public List<College> getStudentInfo() {
        List<College> coList = new ArrayList<College>();
        College co = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from major";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	co = new College();
            	co.college_id = queryRS.getInt("college_id");
            	co.college_identifier = queryRS.getString("college_identifier");
            	co.college_name = queryRS.getString("college_name");
            	co.college_deleted = queryRS.getBoolean("college_deleted");
            	co.created_at = queryRS.getTimestamp("created_at");
            	co.updated_at = queryRS.getTimestamp("updated_at");
            	co.deleted_at = queryRS.getTimestamp("deleted_at");
            	coList.add(co);
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
        return coList;
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

