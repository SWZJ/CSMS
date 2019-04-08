package JZW;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
 
public class Student {
	private int student_id;			//学生主键
    private String student_number;	//学生学号
    private String student_name;	//学生姓名
    private String student_sex;		//学生性别
    private int student_age;		//学生年龄
    private boolean student_deleted;//学生是否已删除
    private int class_id;			//班级外键
    private int major_id;			//专业外键
    private int college_id;			//学院外键
    private int cdtopic_id;			//课题外键
    private Date created_at;		//新增时间
    private Date updated_at;		//修改时间
    private Date deleted_at;		//删除时间
 
    public Student() {}
 
    public int getID() {
    	return student_id;
    }
    
    public void setID(int student_id) {
    	this.student_id = student_id;
    }
    
    public String getNum() {
        return student_number;
    }
 
    public void setNum(String student_number) {
        this.student_number = student_number;
    }
 
    public String getName() {
        return student_name;
    }
 
    public void setName(String student_name) {
        this.student_name = student_name;
    }
 
    public String getSex() {
    	return student_sex;
    }
    
    public void setSex(String student_sex) {
    	this.student_sex = student_sex;
    }
    
    public String getAge() {
    	if(student_age==0) {
    		return "未知";
    	}else {
    		return String.valueOf(student_age);
    	}
    }
    
    public void setAge(int student_age) {
    	this.student_age = student_age;
    }
    
    public String getIsDeleteStr() {
    	if(student_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return student_deleted;
    }
    
    public void setIsDeleted(boolean student_deleted) {
    	this.student_deleted = student_deleted;
    }
    
    public int getClassID() {
        return class_id;
    }
 
    public void setClassID(int class_id) {
        this.class_id = class_id;
    }
    
    public String getClassName() {
		return "计科17-3BJ";
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
    
    public int getCdtopicID() {
    	return cdtopic_id;
    }
    
    public void setCdtopicID(int cdtopic_id) {
    	this.cdtopic_id = cdtopic_id;
    }
    
    public String getCDTopicName() {
		if(cdtopic_id > 0) {
			CDTopic cdt = new CDTopic();
			cdt = cdt.queryCDTopicByID(cdtopic_id);
		   	String cdtopicName = cdt.getName();
		   	return cdtopicName;
		}else	return "";
    }
    
    //获取课题名称——课题主键
    public String getCDTopicNameByCDTopicID(int cdtopic_id) {
    	if(cdtopic_id > 0) {
    		CDTopic cdt = new CDTopic();
    		cdt = cdt.queryCDTopicByID(cdtopic_id);
	       	String cdtopicName = cdt.getName();
	       	return cdtopicName;
        }else	return "";
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
 
    //添加学生信息
	public boolean CreateStudent(String student_number,String student_name,String student_sex,int student_age,int class_id,int major_id,int college_id,int cdtopic_id,Date created_at) {
		String insertSql = 
        		"insert into student("
        			+ "student_number,"
        			+ "student_name,"
        			+ "student_sex,"
        			+ "student_age,"
        			+ "class_id,"
	        		+ "major_id,"
	        		+ "college_id,"
	        		+ "cdtopic_id,"
	        		+ "created_at) "
        		+ "values(?,?,?,?,?,?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1, student_number);
        	ps.setString(2, student_name);
        	ps.setString(3, student_sex);
        	if(student_age != 0)	ps.setInt(4, student_age);	else	ps.setNull(4, Types.INTEGER);
        	ps.setInt(5, class_id);
        	ps.setInt(6, major_id);
        	ps.setInt(7, college_id);
        	if(cdtopic_id != 0)		ps.setInt(8, cdtopic_id);	else 	ps.setNull(8, Types.INTEGER);
        	ps.setTimestamp(9, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            System.out.println("添加学生信息失败！");
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
 
    //删除学生信息
    public boolean deleteStudentByID(int student_id) {
        Connection conn = conn();
        String deleteSql = "delete from student where student_id=" + student_id;
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
 
    //查询学生信息
    public List<Student> queryStudent(String querySql) {
        List<Student> stuList = new ArrayList<Student>();
        Student stu = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                stu = new Student();
                stu.student_id = queryRS.getInt("student_id");
                stu.student_number = queryRS.getString("student_number");
                stu.student_name = queryRS.getString("student_name");
                stu.student_sex = queryRS.getString("student_sex");
                stu.student_age = queryRS.getInt("student_age");
                stu.student_deleted = queryRS.getBoolean("student_deleted");
                stu.class_id = queryRS.getInt("class_id");
                stu.major_id = queryRS.getInt("major_id");
                stu.college_id = queryRS.getInt("college_id");
                stu.cdtopic_id = queryRS.getInt("cdtopic_id");
                stu.created_at = queryRS.getTimestamp("created_at");
                stu.updated_at = queryRS.getTimestamp("updated_at");
                stu.deleted_at = queryRS.getTimestamp("deleted_at");
                stuList.add(stu);
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
        return stuList;
    }
    
    
    //查询学生信息（按主键查找）
    public Student queryStudentByID(int student_id) {
        String querySql = "select * from student where student_id="+"'"+student_id+"'";
        if(queryStudent(querySql).size()!=0) {
        	return queryStudent(querySql).get(0);
        }else {
        	return new Student();
        }
    }
 
    //查询学生信息（按学号查找）
    public List<Student> queryStudentByNumber(String student_number) {
    	String querySql = "select * from student where student_number="+"'"+student_number+"'";
    	return queryStudent(querySql);
    }
    
    //查询学生信息（按姓名查找）
    public List<Student> queryStudentByName(String student_name) {
    	String querySql = "select * from student where student_name="+"'"+student_name+"'";
        return queryStudent(querySql);
    }
    
    //查询学生信息（按班级查找）
    public List<Student> queryStudentByClass(int class_id) {
    	String querySql = "select * from student where class_id="+"'"+class_id+"'";
        return queryStudent(querySql);
    }
    
    //查询学生信息（按专业查找）
    public List<Student> queryStudentByMajor(int major_id) {
    	String querySql = "select * from student where major_id="+"'"+major_id+"'";
        return queryStudent(querySql);
    }
    
    //查询学生信息（按学院查找）
    public List<Student> queryStudentByCollege(int college_id) {
    	String querySql = "select * from student where college_id="+"'"+college_id+"'";
        return queryStudent(querySql);
    }
    
    //查询学生信息（按课题查找）
    public List<Student> queryStudentByCDTopic(int cdtopic_id) {
    	String querySql = "select * from student where cdtopic_id="+"'"+cdtopic_id+"'";
        return queryStudent(querySql);
    } 
    
    //查询学生信息（按是否已删除查找）
    public List<Student> queryStudentByIsDeleted(boolean student_deleted) {
    	int deleted = student_deleted?1:0;
    	String querySql = "select * from student where student_deleted="+"'"+deleted+"'";
        return queryStudent(querySql);
    }
    
    //修改学生信息
    public boolean updateStudent(Student stu,String student_number,String student_name,String student_sex,int student_age,int class_id,int major_id,int college_id,int cdtopic_id,Date updated_at) {
 
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(student_number.equals(stu.student_number) == false) {
        	count++;
            String updateSql = "update student set student_number='"+student_number+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(student_name.equals(stu.student_name) == false) {
        	count++;
            String updateSql = "update student set student_name='"+student_name+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(student_sex.equals(stu.student_sex) == false) {
        	count++;
            String updateSql = "update student set student_sex='"+student_sex+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(student_age != stu.student_age) {
        	count++;
        	String updateSql = null;
        	if(student_age == 0)
        		updateSql = "update student set student_age=null where student_id=" + stu.student_id;
        	else
        		updateSql = "update student set student_age='"+student_age+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
 
        if(class_id != stu.class_id) {
        	count++;
            String updateSql = "update student set class_id='"+class_id+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(major_id != stu.major_id) {
        	count++;
            String updateSql = "update student set major_id='"+major_id+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(college_id != stu.college_id) {
        	count++;
            String updateSql = "update student set college_id='"+college_id+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(cdtopic_id != stu.cdtopic_id) {
        	count++;
        	String updateSql = null;
        	if(cdtopic_id == 0)
        		updateSql = "update student set cdtopic_id=null where student_id=" + stu.student_id;
        	else
        		updateSql = "update student set cdtopic_id='"+cdtopic_id+"' where student_id=" + stu.student_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                return false;
            }
        }
        
        if(updated_at != stu.updated_at&&count != 0) {
        	String updateSql = "update student set updated_at = ? where student_id="+ stu.student_id;
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
 
    //删除课题信息时，先将学生表中对应的课题信息置空
    public boolean refreshCDTopicID(int cdtopic_id) {
    	 Connection conn = conn();
         String deleteSQL = "update student set cdtopic_id=null where cdtopic_id="+"'"+cdtopic_id+"'";
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
    
    //判断学号是否存在
    public boolean isExist_number(String student_number) {
    	if(queryStudentByNumber(student_number).size() != 0)	return true;
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

    //获取总数据条数（是否删除+所选课题ID）（boolean型的2表示不考虑该条件）
    public int Count(int student_deleted,int cdtopic_id) {
    	switch(student_deleted) {
    	case 2:
    		if(cdtopic_id!=0) {
				return CountByString("select count(*) from student where cdtopic_id ="+cdtopic_id);
			}else {
				return CountByString("select count(*) from student");
			}
    	default:
    		if(cdtopic_id!=0) {
				return CountByString("select count(*) from student where student_deleted = "+student_deleted+" and cdtopic_id ="+cdtopic_id);
			}else {
				return CountByString("select count(*) from student where student_deleted = "+student_deleted);
			}
    	}
    }
    
  //返回分页数据
    public List<Student> cutPageDataByString(int page,int pageSize,String querySql){
        List<Student> stuList = new ArrayList<Student>();
        Student stu = null;
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
                stu = new Student();
                stu.student_id = rs.getInt("student_id");
                stu.student_number = rs.getString("student_number");
                stu.student_name = rs.getString("student_name");
                stu.student_sex = rs.getString("student_sex");
                stu.student_age = rs.getInt("student_age");
                stu.student_deleted = rs.getBoolean("student_deleted");
                stu.class_id = rs.getInt("class_id");
                stu.major_id = rs.getInt("major_id");
                stu.college_id = rs.getInt("college_id");
                stu.cdtopic_id = rs.getInt("cdtopic_id");
                stu.created_at = rs.getTimestamp("created_at");
                stu.updated_at = rs.getTimestamp("updated_at");
                stu.deleted_at = rs.getTimestamp("deleted_at");
                stuList.add(stu);
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
        return stuList;
    }
    
    //返回分页数据（是否删除+所选课题ID）（boolean型的2表示不考虑该条件）
    public List<Student> cutPageData(int page,int pageSize,int student_deleted,int cdtopic_id){
    	switch(student_deleted) {
    	case 2:
    		if(cdtopic_id!=0) {
				return cutPageDataByString(page,pageSize,"select * from student where cdtopic_id = "+cdtopic_id+" limit ?,?");
			}else {
				return cutPageDataByString(page,pageSize,"select * from student limit ?,?");
			}
    	default:
    		if(cdtopic_id!=0) {
				return cutPageDataByString(page,pageSize,"select * from student where student_deleted = "+student_deleted+" and cdtopic_id ="+cdtopic_id+" limit ?,?");
			}else {
				return cutPageDataByString(page,pageSize,"select * from student where student_deleted = "+student_deleted+" limit ?,?");
			}
    	}
    }
    
    //从数据库获取所有学生信息返回学生表
    public List<Student> getStudentInfo() {
        List<Student> stuList = new ArrayList<Student>();
        Student stu = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from student";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                stu = new Student();
                stu.student_id = queryRS.getInt("student_id");
                stu.student_number = queryRS.getString("student_number");
                stu.student_name = queryRS.getString("student_name");
                stu.student_sex = queryRS.getString("student_sex");
                stu.student_age = queryRS.getInt("student_age");
                stu.student_deleted = queryRS.getBoolean("student_deleted");
                stu.class_id = queryRS.getInt("class_id");
                stu.major_id = queryRS.getInt("major_id");
                stu.college_id = queryRS.getInt("college_id");
                stu.cdtopic_id = queryRS.getInt("cdtopic_id");
                stu.created_at = queryRS.getTimestamp("created_at");
                stu.updated_at = queryRS.getTimestamp("updated_at");
                stu.deleted_at = queryRS.getTimestamp("deleted_at");
                stuList.add(stu);
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
        return stuList;
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