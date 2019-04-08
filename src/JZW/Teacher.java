package JZW;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;
import java.util.List;

public class Teacher {
	private int teacher_id;			//教师主键
    private String teacher_number;	//教师编号
    private String teacher_name;	//教师姓名
    private String teacher_position;//教师职称
    private int teacher_cdtcount;	//教师拥有的课题总数
    private boolean teacher_deleted;//教师是否已删除
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
 
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
            System.out.println("添加教师信息失败！");
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
 
    //删除教师信息
    public boolean deleteTeacherByID(int teacher_id) {
        Connection conn = conn();
        String deleteSql = "delete from teacher where teacher_id=" + teacher_id;
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
                tea.teacher_deleted = queryRS.getBoolean("teacher_deleted");
                tea.created_at = queryRS.getTimestamp("created_at");
                tea.updated_at = queryRS.getTimestamp("updated_at");
                tea.deleted_at = queryRS.getTimestamp("deleted_at");
                teaList.add(tea);
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
    public List<Teacher> queryTeacherByNumber(String teacher_number) {
    	String querySql = "select * from teacher where teacher_number="+"'"+teacher_number+"'";
    	return queryTeacher(querySql);
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
            } catch (SQLException e1) {
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
            } catch (SQLException e1) {
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
            } catch (SQLException e1) {
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
                return false;
            } 
    	}else	return false;
    }
    
    //刷新所有教师拥有的课题总数
    public boolean refreshCDTopicCountOfAll() {
    	Connection conn = conn();
    	CDTopic cdt = new CDTopic();
    	List<Teacher> teaList = getTeacherInfo();
		for(Teacher teacher:teaList) {
			String updateSql = "update teacher set teacher_cdtcount='"+cdt.queryCDTopicByTeacherID(teacher.getID()).size()+"' where teacher_id=" + teacher.getID();
			try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            } 
		}
		try {
			conn.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
    }
    
    //判断编号是否存在
    public boolean isExist_number(String teacher_number) {
    	if(queryTeacherByNumber(teacher_number).size() != 0)	return true;
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
    public int Count(int teacher_deleted) {
    	switch(teacher_deleted) {
    	case 2:
    		return CountByString("select count(*) from teacher");
    	default:
    		return CountByString("select count(*) from teacher where teacher_deleted = "+teacher_deleted);
    	}
    }
    
    //返回分页数据
    public List<Teacher> cutPageDataByString(int page,int pageSize,String querySql){
        List<Teacher> teaList = new ArrayList<Teacher>();
        Teacher tea = null;
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
                tea = new Teacher();
                tea.teacher_id = rs.getInt("teacher_id");
                tea.teacher_number = rs.getString("teacher_number");
                tea.teacher_name = rs.getString("teacher_name");
                tea.teacher_position = rs.getString("teacher_position");
                tea.teacher_cdtcount = rs.getInt("teacher_cdtcount");
                tea.teacher_deleted = rs.getBoolean("teacher_deleted");
                tea.created_at = rs.getTimestamp("created_at");
                tea.updated_at = rs.getTimestamp("updated_at");
                tea.deleted_at = rs.getTimestamp("deleted_at");
                teaList.add(tea);
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
        return teaList;
    }
    
    //返回分页数据（是否删除）（boolean型的2表示不考虑该条件）
    public List<Teacher> cutPageData(int page,int pageSize,int teacher_deleted){
    	switch(teacher_deleted) {
    	case 2:
    		return cutPageDataByString(page,pageSize,"select * from teacher limit ?,?");
    	default:
    		return cutPageDataByString(page,pageSize,"select * from teacher where teacher_deleted = "+teacher_deleted+" limit ?,?");
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
                tea.teacher_cdtcount = queryRS.getInt("teacher_cdtcount");
                tea.teacher_deleted = queryRS.getBoolean("teacher_deleted");
                tea.created_at = queryRS.getTimestamp("created_at");
                tea.updated_at = queryRS.getTimestamp("updated_at");
                tea.deleted_at = queryRS.getTimestamp("deleted_at");
                teaList.add(tea);
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
        return teaList;
    }
    
 	//连接数据库
    public Connection conn() {
    	Connection connection = null;
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost/csms?useSSL=true&serverTimezone=Asia/Shanghai&user=root&password=root";
            Class.forName(driver);
            connection = DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("数据库连接出错");
            return null;
        }
        return connection;
    }

}