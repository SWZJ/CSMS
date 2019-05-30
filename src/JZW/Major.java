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


public class Major {
	private int major_id;           //专业主键
	private String major_identifier;//专业标识符
    private String major_name;   	//专业名称
    private boolean major_deleted;  //专业是否已删除
    private int college_id;			//学院外键
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
    
    public Major() {}
	 
    public int getID() {
    	return major_id;
    }
    
    public void setID(int major_id) {
    	this.major_id = major_id;
    }
    
    public String getIdentifier() {
        return major_identifier;
    }
 
    public void setIdentifier(String major_identifier) {
        this.major_identifier = major_identifier;
    }
    
    public String getName() {
        return major_name;
    }
 
    public void setName(String major_name) {
        this.major_name = major_name;
    }
 
    public String getIsDeleteStr() {
    	if(major_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return major_deleted;
    }
    
    public void setIsDeleted(boolean major_deleted) {
    	this.major_deleted = major_deleted;
    }
    
    public String getMajorName() {
		return "计算机科学与技术";
    }
    
    public int getCollegeID() {
        return college_id;
    }
 
    public void setCollegeID(int college_id) {
        this.college_id = college_id;
    }
    
    public String getCollegeName() {
		return "信息学院";
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
    //添加专业信息
	public boolean CreateMajor(String major_identifier,String major_name,int college_id,Date created_at) {
		String insertSql = 
        		"insert into major("
        			+ "major_identifier"
        			+ "major_name,"
	        		+ "college_id,"
	        		+ "created_at) "
        		+ "values(?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1,major_identifier);
        	ps.setString(2, major_name);
        	ps.setInt(4, college_id);	   
        	ps.setTimestamp(5, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            System.out.println("添加专业信息失败！");
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

	//删除专业信息
    public boolean deleteMajorByID(int major_id) {
        Connection conn = conn();
        String deleteSql = "delete from major where major_id=" + major_id;
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
    
    //删除专业信息时，先将学生表及班级表中对应的专业信息置空
    public boolean refreshMajorID(int major_id) {

    	 Connection conn = conn();
         String deleteSQL1 = "update student set major_id=null where major_id="+"'"+major_id+"'"+"update class set major_id=null where major_id="+"'"+major_id+"'";
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
    
    //查询专业信息
    public List<Major> queryMajor(String querySql) {
        List<Major> maList = new ArrayList<Major>();
        Major ma = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                ma = new Major();
                ma.major_id = queryRS.getInt("major_id"); 
                ma.major_name = queryRS.getString("major_name");
                ma.major_identifier = queryRS.getString("major_identifier");
                ma.major_deleted = queryRS.getBoolean("major_deleted");
                ma.college_id = queryRS.getInt("college_id");
                ma.created_at = queryRS.getTimestamp("created_at");
                ma.updated_at = queryRS.getTimestamp("updated_at");
                ma.deleted_at = queryRS.getTimestamp("deleted_at");
                maList.add(ma);
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
        return maList;
    }
    
    
    //查询专业信息（按主键查找）
    public Major queryMajorByID(int major_id) {
        String querySql = "select * from major where major_id="+"'"+major_id+"'";
        if(queryMajor(querySql).size()!=0) {
        	return queryMajor(querySql).get(0);
        }else {
        	return new Major();
        }
    }
 
    //查询专业信息（按编号查找）
    public List<Major> queryMajorByIdentifier(String major_identifier) {
    	String querySql = "select * from major where major_identifier="+"'"+major_identifier+"'";
    	return queryMajor(querySql);
    }
    
    //查询专业信息（按名称查找）
    public List<Major> queryMajorByName(String major_name) {
    	String querySql = "select * from major where major_name="+"'"+major_name+"'";
        return queryMajor(querySql);
    }
   
    //查询专业信息（按学院查找）
    public List<Major> queryMajorByCollege(int college_id) {
    	String querySql = "select * from Major where college_id="+"'"+college_id+"'";
        return queryMajor(querySql);
    }
   
    //查询专业信息（按是否已删除查找）
    public List<Major> queryMajorByIsDeleted(boolean major_deleted) {
    	int deleted = major_deleted?1:0;
    	String querySql = "select * from major where major_deleted="+"'"+deleted+"'";
        return queryMajor(querySql);
    }
    
    //修改专业信息
    public boolean updateClass(Major ma,String major_identifier,String major_name,int college_id,Date updated_at) {
 
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(major_identifier.equals(ma.major_identifier) == false) {
        	count++;
            String updateSql = "update major set major_identifier='"+major_identifier+"' where major_id=" + ma.major_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(major_name.equals(ma.major_name) == false) {
        	count++;
            String updateSql = "update major set major_name='"+major_name+"' where major_id=" + ma.major_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        
        if(college_id != ma.college_id) {
        	count++;
            String updateSql = "update major set college_id='"+college_id+"'  where major_id=" + ma.major_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        
        
        if(updated_at != ma.updated_at&&count != 0) {
        	String updateSql = "update major set updated_at = ? where major_id=" + ma.major_id;
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
 
    
    //判断专业标识符是否存在
    public boolean isExist_number(String major_identifier) {
    	if(queryMajorByIdentifier(major_identifier).size() != 0)	return true;
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
    public int Count(int major_deleted) {
    	switch(major_deleted) {
    	case 2:
				return CountByString("select count(*) from major");
    	default:
				return CountByString("select count(*) from major where major_deleted = "+major_deleted);
    	}
    }
    
    
    //返回分页数据
    public List<Major> cutPageDataByString(int page,int pageSize,String querySql){
        List<Major> maList = new ArrayList<Major>();
        Major ma = null;
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
                ma = new Major();
                ma.major_id = rs.getInt("major_id");
                ma.major_identifier = rs.getString("major_identifier");
                ma.major_name = rs.getString("major_name");
                ma .major_deleted = rs.getBoolean("major_deleted");
                ma .college_id = rs.getInt("college_id");
                ma .created_at = rs.getTimestamp("created_at");
                ma .updated_at = rs.getTimestamp("updated_at");
                ma .deleted_at = rs.getTimestamp("deleted_at");
                maList.add(ma);
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
        return maList;
    }
    
    //返回分页数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<Major> cutPageData(int page,int pageSize,int major_deleted){
    	switch(major_deleted) {
    	case 2:
				return cutPageDataByString(page,pageSize,"select * from major limit ?,?");
    	default:
				return cutPageDataByString(page,pageSize,"select * from major where major_deleted = "+major_deleted+" limit ?,?");
    	}
    }
    
    
    //从数据库获取所有专业信息返回专业表
    public List<Major> getStudentInfo() {
        List<Major> maList = new ArrayList<Major>();
        Major ma = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from major";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	ma = new Major();
            	ma.major_id = queryRS.getInt("major_id");
            	ma.major_identifier = queryRS.getString("major_identifier");
            	ma.major_name = queryRS.getString("major_name");
            	ma.major_deleted = queryRS.getBoolean("major_deleted");
            	ma.college_id = queryRS.getInt("college_id");
            	ma.created_at = queryRS.getTimestamp("created_at");
            	ma.updated_at = queryRS.getTimestamp("updated_at");
            	ma.deleted_at = queryRS.getTimestamp("deleted_at");
            	maList.add(ma);
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
        return maList;
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

