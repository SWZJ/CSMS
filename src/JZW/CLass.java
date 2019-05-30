/*By 戴丽婷*/
package JZW;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import java.util.Date;
 
public class CLass {
	private int class_id;			//班级主键
    private String class_identifier;//班级标识符
    private String class_name;  	//班级名称
    private boolean class_deleted;  //班级是否已删除
    private int major_id;			//专业外键
    private int college_id;			//学院外键
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
 
    public CLass() {}
 
    public int getID() {
    	return class_id;
    }
    
    public void setID(int class_id) {
    	this.class_id = class_id;
    }
    
    public String getIdentifier() {
        return class_identifier;
    }
 
    public void setIdentifier(String class_identifier) {
        this.class_identifier = class_identifier;
    }
    
    public String getName() {
        return class_name;
    }
 
    public void setName(String class_name) {
        this.class_name = class_name;
    }
 
    public String getIsDeleteStr() {
    	if(class_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return class_deleted;
    }
    
    public void setIsDeleted(boolean class_deleted) {
    	this.class_deleted = class_deleted;
    }
    
    public int getMajorID() {
        return major_id;
    }
 
    public void setMajorID(int major_id) {
        this.major_id = major_id;
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
 
    //添加班级信息
	public boolean CreateCLass(String class_name,String class_identifier,int major_id,int college_id,Date created_at) {
		String insertSql = 
        		"insert into class("
        			+ "class_name,"
        			+ "class_identifier"
	        		+ "major_id,"
	        		+ "college_id,"
	        		+ "created_at) "
        		+ "values(?,?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1, class_name);
        	ps.setString(2, class_identifier);
        	ps.setInt(3, major_id);
        	ps.setInt(4, college_id);	   
        	ps.setTimestamp(5, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            System.out.println("添加班级信息失败！");
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
 
    //删除班级信息
    public boolean deleteClassByID(int class_id) {
        Connection conn = conn();
        String deleteSql = "delete from class where class_id=" + class_id;
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
    
  //删除班级信息时，先将学生表中对应的班级信息置空
    public boolean refreshCLassID(int class_id) {
    	 Connection conn = conn();
         String deleteSQL = "update student set class_id=null where class_id="+"'"+class_id+"'";
         PreparedStatement ps = null;
         try {
             ps = conn.prepareStatement(deleteSQL);
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
    
    //查询班级信息
    public List<CLass> queryClass(String querySql) {
        List<CLass> claList = new ArrayList<CLass>();
        CLass cla = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                cla = new CLass();
                cla.class_id = queryRS.getInt("class_id");
                cla.class_identifier = queryRS.getString("class_identifier");
                cla.class_name = queryRS.getString("class_name");
                cla.class_deleted = queryRS.getBoolean("class_deleted");
                cla.major_id = queryRS.getInt("major_id");
                cla.college_id = queryRS.getInt("college_id");
                cla.created_at = queryRS.getTimestamp("created_at");
                cla.updated_at = queryRS.getTimestamp("updated_at");
                cla.deleted_at = queryRS.getTimestamp("deleted_at");
                claList.add(cla);
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
        return claList;
    }
    
    
    //查询班级信息（按主键查找）
    public CLass queryClassByID(int class_id) {
        String querySql = "select * from class where class_id="+"'"+class_id+"'";
        if(queryClass(querySql).size()!=0) {
        	return queryClass(querySql).get(0);
        }else {
        	return new CLass();
        }
    }
 
    //查询班级信息（按编号查找）
    public List<CLass> queryClassByIdentifier(String class_identifier) {
    	String querySql = "select * from class where class_identifier="+"'"+class_identifier+"'";
    	return queryClass(querySql);
    }
    
    //查询班级信息（按名称查找）
    public List<CLass> queryClassByName(String class_name) {
    	String querySql = "select * from class where class_name="+"'"+class_name+"'";
        return queryClass(querySql);
    }
    
    //查询班级信息（按专业查找）
    public List<CLass> queryClassByMajor(int major_id) {
    	String querySql = "select * from class where major_id="+"'"+major_id+"'";
        return queryClass(querySql);
    }
    
    //查询班级信息（按学院查找）
    public List<CLass> queryClassByCollege(int college_id) {
    	String querySql = "select * from class where college_id="+"'"+college_id+"'";
        return queryClass(querySql);
    }
   
    //查询班级信息（按是否已删除查找）
    public List<CLass> queryClassByIsDeleted(boolean class_deleted) {
    	int deleted = class_deleted?1:0;
    	String querySql = "select * from class where class_deleted="+"'"+deleted+"'";
        return queryClass(querySql);
    }
    
    //修改班级信息
    public boolean updateClass(CLass cla,String class_identifier,String class_name,int major_id,int college_id,Date updated_at) {
 
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(class_identifier.equals(cla.class_identifier) == false) {
        	count++;
            String updateSql = "update class set class_identifier='"+class_identifier+"' where class_id=" + cla.class_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(class_name.equals(cla.class_name) == false) {
        	count++;
            String updateSql = "update class set class_name='"+class_name+"' where class_id=" + cla.class_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        
        if(major_id != cla.major_id) {
        	count++;
            String updateSql = "update class set major_id='"+major_id+"' where class_id=" + cla.class_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(college_id != cla.college_id) {
        	count++;
            String updateSql = "update class set college_id='"+college_id+"'  where class_id=" + cla.class_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        
        
        if(updated_at != cla.updated_at&&count != 0) {
        	String updateSql = "update class set updated_at = ? where class_id=" + cla.class_id;
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
 
   
    
    //判断班级标识符是否存在
    public boolean isExist_number(String class_identifier) {
    	if(queryClassByIdentifier(class_identifier).size() != 0)	return true;
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
    public int Count(int class_deleted) {
    	switch(class_deleted) {
    	case 2:
				return CountByString("select count(*) from class");

    	default:
				return CountByString("select count(*) from class where class_deleted = "+class_deleted);
			}
    	
    }
    
  //返回分页数据
    public List<CLass> cutPageDataByString(int page,int pageSize,String querySql){
        List<CLass> claList = new ArrayList<CLass>();
        CLass cla = null;
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
                cla = new CLass();
                cla.class_id = rs.getInt("class_id");
                cla.class_identifier = rs.getString("class_identifier");
                cla.class_name = rs.getString("class_name");
                cla.class_deleted = rs.getBoolean("class_deleted");
                cla.major_id = rs.getInt("major_id");
                cla.college_id = rs.getInt("college_id");
                cla.created_at = rs.getTimestamp("created_at");
                cla.updated_at = rs.getTimestamp("updated_at");
                cla.deleted_at = rs.getTimestamp("deleted_at");
                claList.add(cla);
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
        return claList;
    }
    
    //返回分页数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<CLass> cutPageData(int page,int pageSize,int class_deleted){
    	switch(class_deleted) {
    	case 2:
				return cutPageDataByString(page,pageSize,"select * from class limit ?,?");
    	default:
				return cutPageDataByString(page,pageSize,"select * from class where class_deleted = "+class_deleted+" limit ?,?");
    	}
    }
    
    //从数据库获取所有班级信息返回班级表
    public List<CLass> getClassInfo() {
        List<CLass> claList = new ArrayList<CLass>();
        CLass cla = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from class";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	 cla = new CLass();
	                cla.class_id =queryRS.getInt("class_id");
	                cla.class_identifier = queryRS.getString("class_identifier");
	                cla.class_name = queryRS.getString("class_name");
	                cla.class_deleted = queryRS.getBoolean("class_deleted");
	                cla.major_id = queryRS.getInt("major_id");
	                cla.college_id =queryRS.getInt("college_id");
	                cla.created_at = queryRS.getTimestamp("created_at");
	                cla.updated_at = queryRS.getTimestamp("updated_at");
	                cla.deleted_at = queryRS.getTimestamp("deleted_at");
	                claList.add(cla);
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
        return claList;
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
