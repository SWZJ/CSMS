package JZW;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

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
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
 
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
            logger.error("数据库语句检查或执行出错！添加学生信息失败："+student_number+" "+student_name+" "+student_sex+" "+student_age+" "+class_id+" "+major_id+" "+college_id+" "+cdtopic_id);
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("添加学生信息"+student_number+" "+student_name+" "+student_sex+" "+student_age+" "+class_id+" "+major_id+" "+college_id+" "+cdtopic_id+"后数据库关闭出错！");
            }
        }
        logger.info("添加学生信息成功："+student_number+" "+student_name+" "+student_sex+" "+student_age+" "+class_id+" "+major_id+" "+college_id+" "+cdtopic_id);
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
            logger.error("数据库语句检查或执行出错！删除学生 "+student_id+" 失败。");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("删除学生 "+student_id+" 后数据库关闭出错！");
            }
        }
        logger.info("删除学生 "+student_id+" 成功。");
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
            logger.error("数据库语句检查或执行出错！学生信息查询失败。");
            return null;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("查询学生信息后数据库关闭出错！");
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
 
    	String updateStr = "";
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
                updateStr += " 学号:"+stu.student_number+"->"+student_number;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 学号"+stu.student_number+"为"+student_number+"失败。");
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
                updateStr += " 姓名:"+stu.student_name+"->"+student_name;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 姓名"+stu.student_name+"为"+student_name+"失败。");
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
                updateStr += " 性别:"+stu.student_sex+"->"+student_sex;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 性别"+stu.student_sex+"为"+student_sex+"失败。");
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
                updateStr += " 年龄:"+stu.student_age+"->"+student_age;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 年龄"+stu.student_age+"为"+student_age+"失败。");
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
                updateStr += " 班级ID:"+stu.class_id+"->"+class_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 班级ID"+stu.class_id+"为"+class_id+"失败。");
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
                updateStr += " 专业ID:"+stu.major_id+"->"+major_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 专业ID"+stu.major_id+"为"+major_id+"失败。");
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
                updateStr += " 学院ID:"+stu.college_id+"->"+college_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 学院ID"+stu.college_id+"为"+college_id+"失败。");
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
                updateStr += " 课题ID:"+stu.cdtopic_id+"->"+cdtopic_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 课题ID"+stu.cdtopic_id+"为"+cdtopic_id+"失败。");
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
                updateStr += " 修改时间:"+stu.updated_at+"->"+updated_at;
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！修改学生 "+stu.student_id+" 修改时间"+stu.updated_at+"为"+updated_at+"失败。");
                return false;
            }
        }
        
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改学生 "+stu.student_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改学生 "+stu.student_id+" 信息成功！"+updateStr);
        }
        return true;
    }
 
    //删除课题信息时，先将学生表中对应的课题信息置空
    public boolean emptyCDTopicByCDTopicID(int cdtopic_id) {
    	 Connection conn = conn();
         String updateSQL = "update student set cdtopic_id=null where cdtopic_id="+"'"+cdtopic_id+"'";
         PreparedStatement ps = null;
         try {
             ps = conn.prepareStatement(updateSQL);
             ps.executeUpdate();
         } catch (Exception e) {
             e.printStackTrace();
             logger.error("数据库语句检查或执行出错！置空所有选择了课题为 "+cdtopic_id+" 的学生的所选课题信息失败。");
             return false;
         } finally {
        	 String updateSql = "update student set updated_at = ? where cdtopic_id="+ cdtopic_id;
             try {
                 ps = conn.prepareStatement(updateSql);
                 ps.setTimestamp(1, new Timestamp(new Date().getTime()));
                 ps.executeUpdate();
                 ps.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("数据库语句检查或执行出错！置空所有选择了课题为 "+cdtopic_id+" 的学生的所选课题信息后更改学生信息修改时间失败。");
                 return false;
             }
             try {
                 ps.close();
                 conn.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("置空所有选择了课题为 "+cdtopic_id+" 的学生的所选课题信息后数据库关闭出错！");
             }
         }
         logger.info("置空所有选择了课题为 "+cdtopic_id+" 的学生的所选课题信息成功。");
         return true;
    }
    
    //退选课题（设置学生所选课题为空）
    public boolean emptyCDTopicByStudentID(int student_id) {
    	 int cdtopic_id = queryStudentByID(student_id).getCdtopicID();
    	 Connection conn = conn();
         String updateSQL = "update student set cdtopic_id=null where student_id="+student_id;
         PreparedStatement ps = null;
         try {
             ps = conn.prepareStatement(updateSQL);
             ps.executeUpdate();
         } catch (Exception e) {
             e.printStackTrace();
             logger.error("数据库语句检查或执行出错！学生 "+student_id+" 退选课题 "+cdtopic_id+" 失败。");
             return false;
         } finally {
        	 String updateSql = "update student set updated_at = ? where student_id="+ student_id;
             try {
                 ps = conn.prepareStatement(updateSql);
                 ps.setTimestamp(1, new Timestamp(new Date().getTime()));
                 ps.executeUpdate();
                 ps.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("数据库语句检查或执行出错！学生 "+student_id+" 退选课题 "+cdtopic_id+" 后更改修改时间失败。");
                 return false;
             }
             try {
                 ps.close();
                 conn.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("学生 "+student_id+" 退选课题 "+cdtopic_id+" 后数据库关闭出错！");
             }
         }
         logger.info("学生 "+student_id+" 退选课题 "+cdtopic_id+" 成功。");
         return true;
    }
    
    //选择课题
    public boolean selectCDTopicByStudentID(int student_id,int cdtopic_id) {
    	 Connection conn = conn();
         String updateSQL = "update student set cdtopic_id="+cdtopic_id+" where student_id="+student_id;
         PreparedStatement ps = null;
         try {
             ps = conn.prepareStatement(updateSQL);
             ps.executeUpdate();
         } catch (Exception e) {
             e.printStackTrace();
             System.out.println("数据库语句检查或执行出错");
             return false;
         } finally {
        	 String updateSql = "update student set updated_at = ? where student_id="+ student_id;
             try {
                 ps = conn.prepareStatement(updateSql);
                 ps.setTimestamp(1, new Timestamp(new Date().getTime()));
                 ps.executeUpdate();
                 ps.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("学生 "+student_id+" 选择课题 "+cdtopic_id+" 后更改修改时间失败。");
                 return false;
             }
             try {
                 ps.close();
                 conn.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("学生 "+student_id+" 选择课题 "+cdtopic_id+" 后关闭数据库失败。");
             }
         }
         logger.info("学生 "+student_id+" 选择课题 "+cdtopic_id+" 成功。");
         return true;
    }
    
    //判断学号是否存在
    public boolean isExist_number(String student_number) {
    	if(queryStudentByNumber(student_number).size() != 0)	return true;
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
            ps = conn.prepareStatement("select count(*) from student");
            rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！无条件获取学生数据量失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("无条件获取学生数据量后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return count;
    }
    
    //按条件获取学生数据
    public List<Student> queryByConditionByString(String querySql,String queryStr) {
    	List<Student> stuList = new ArrayList<Student>();
    	Student stu = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
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
            	if(queryStr.length()==0) {
            		stuList.add(stu);
            	}
            	else if(stu.student_number.indexOf(queryStr)!=-1||
            			stu.student_name.indexOf(queryStr)!=-1) {
            		stuList.add(stu);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！按条件获取学生信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("按条件获取学生信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return stuList;
    }
    
    //按条件获取学生数据（是否删除+所选课题ID+所属班级ID+所属专业ID+所属学院ID）（boolean型的2表示不考虑该条件）
    public List<Student> queryByCondition(int student_deleted,int cdtopic_id,int class_id,int major_id,int college_id,String queryStr) {
    	if(student_deleted==2&&cdtopic_id==0&&class_id==0&&major_id==0&&college_id==0&&queryStr.length()==0) {
    		return queryByConditionByString("select * from student",queryStr);
    	}else {
    		String querySql = "select * from student where";
    		if(student_deleted!=2)	querySql += " student_deleted = "+student_deleted+" and";
    		if(cdtopic_id!=0)		querySql += " cdtopic_id = "+cdtopic_id+" and";
    		if(class_id!=0)			querySql += " class_id = "+class_id+" and";
    		if(major_id!=0)			querySql += " major_id = "+major_id+" and";
    		if(college_id!=0)		querySql += " college_id = "+college_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		return queryByConditionByString(querySql,queryStr);
    	}
    }

    //返回分页数据
    public List<Student> cutPageDataByString(int page,int pageSize,String querySql,String queryStr){
        List<Student> stuList = new ArrayList<Student>();
        Student stu = null;
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
            	if(queryStr.length()==0) {
            		stuList.add(stu);
            	}
            	else if(stu.student_number.indexOf(queryStr)!=-1||
            			stu.student_name.indexOf(queryStr)!=-1) {
            		stuList.add(stu);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取学生分页信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("获取学生分页信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        if(queryStr.length()==0) {
        	return stuList;
        }else {
        	int count = queryByConditionByString(querySql,queryStr).size();
        	int start = page*pageSize-pageSize;
        	int end;
        	if(start == (count/pageSize)*pageSize) {
        		end = start+count%pageSize;
        		return stuList.subList(start, end);
        	}else {
        		end = start+pageSize;
        		return stuList.subList(start, end);
        	}
        }
    }
    
    //返回分页数据（是否删除+所选课题ID+所属班级ID+所属专业ID+所属学院ID）（boolean型的2表示不考虑该条件）
    public List<Student> cutPageData(int page,int pageSize,int student_deleted,int cdtopic_id,int class_id,int major_id,int college_id,String queryStr){
    	if(student_deleted==2&&cdtopic_id==0&&class_id==0&&major_id==0&&college_id==0&&queryStr.length()==0) {
    		return cutPageDataByString(page,pageSize,"select * from student limit ?,?",queryStr);
    	}else {
    		String querySql = "select * from student where";
    		if(student_deleted!=2)	querySql += " student_deleted = "+student_deleted+" and";
    		if(cdtopic_id!=0)		querySql += " cdtopic_id = "+cdtopic_id+" and";
    		if(class_id!=0)			querySql += " class_id = "+class_id+" and";
    		if(major_id!=0)			querySql += " major_id = "+major_id+" and";
    		if(college_id!=0)		querySql += " college_id = "+college_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += "limit ?,?";
    		return cutPageDataByString(page,pageSize,querySql,queryStr);
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
            logger.error("数据库语句检查或执行出错！获取学生信息失败！");
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
            	logger.error("获取学生信息后数据库关闭出错！");
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
            logger.error("数据库连接出错！");
            return null;
        }
        return connection;
    }
}