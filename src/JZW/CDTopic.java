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
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

public class CDTopic {
	private int cdtopic_id;				//主键
	private String cdtopic_number;		//编号
	private String cdtopic_name;		//名称
	private String cdtopic_keyword;		//关键字
	private String cdtopic_technology;	//实现技术
	private int cdtopic_headcount;		//选题人数
	private double cdtopic_grade;		//课题评分
	private int cdtopic_status;			//课题审核状态
	private String cdtopic_opinion;		//课题审核意见
	private boolean cdtopic_active;		//课题是否生效
	private boolean cdtopic_deleted;	//课题是否删除
	private int teacher_id;				//教师外键
	private Date created_at;			//新增时间
    private Date updated_at;			//修改时间
    private Date deleted_at;			//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
    
    public CDTopic() {}
    
    public int getID() {
    	return cdtopic_id;
    }
    
    public void setID(int cdtopic_id) {
    	this.cdtopic_id = cdtopic_id;
    }
    
    public String getNum() {
    	return cdtopic_number;
    }
    
    public void setNum(String cdtopic_number) {
    	this.cdtopic_number = cdtopic_number;
    }
    
    public String getName() {
    	return cdtopic_name;
    }
    
    public void setName(String cdtopic_name) {
    	this.cdtopic_name = cdtopic_name;
    }

    public String getKeyword() {
    	if(cdtopic_keyword==null)	return "";
    	else return cdtopic_keyword;
    }
    
    public void setKeyword(String cdtopic_keyword) {
    	this.cdtopic_keyword = cdtopic_keyword;
    }

    public String getTechnology() {
    	if(cdtopic_technology==null)	return "";
    	else return cdtopic_technology;
    }
    
    public void setTechnology(String cdtopic_technology) {
    	this.cdtopic_technology = cdtopic_technology;
    }

    public int getHeadcount() {
    	return cdtopic_headcount;
    }
    
    public void setHeadcount(int cdtopic_headcount) {
    	this.cdtopic_headcount = cdtopic_headcount;
    }
    
    public String getGradeStr() {
    	if(cdtopic_grade==0)	return "无";
    	else {
    		DecimalFormat df = new DecimalFormat("0.00"); 
    		return df.format(cdtopic_grade);
    	}
    	
    }
    
    public double getGrade() {
    	return cdtopic_grade;
    }
    
    public void setGrade(double cdtopic_grade) {
    	this.cdtopic_grade = cdtopic_grade;
    }
    
    public String getStatusStr() {
    	switch(cdtopic_status) {
	    	case 0:	return "<span><i class='fa fa-spinner fa-spin'></i>等待审核</span>";
	    	case 1:	return "<span style='color: green'><i class='fa fa-check-circle'></i>审核通过</span>";
	    	case 2:	return "<span style='color: red'><i class='fa fa-warning'></i>审核未通过</span>";
	    	default:	return "未知";
    	}
    }
    
    public int getStatus() {
    	return cdtopic_status;
    }
    
    public void setStatus(int cdtopic_status) {
    	this.cdtopic_status = cdtopic_status;
    }
    
    public String getOpinion() {
    	return cdtopic_opinion==null?"":cdtopic_opinion;
    }
    
    public void setOpinion(String cdtopic_opinion) {
    	this.cdtopic_opinion = cdtopic_opinion;
    }
    
    public String getActiveStr() {
    	if(cdtopic_active == true) {
    		return "<span style='color: green'><i class='fa fa-check-circle'></i>已生效</span>";
    	}else {
    		return "<span style='color: red'><i class='fa fa-times-circle'></i>未生效</span>";
    	}
    }
    
    public boolean getActive() {
    	return cdtopic_active;
    }
    
    public void setActive(boolean cdtopic_active) {
    	this.cdtopic_active = cdtopic_active;
    }
    
    public String getIsDeleteStr() {
    	if(cdtopic_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return cdtopic_deleted;
    }
    
    public void setIsDeleted(boolean cdtopic_deleted) {
    	this.cdtopic_deleted = cdtopic_deleted;
    }
    
    
    public int getTeacherID() {
    	return teacher_id;
    }
    
    public void setTeacherID(int teacher_id) {
    	this.teacher_id = teacher_id;
    }
    
    public String getTeacherName() {
    	Teacher tea = new Teacher();
    	tea = tea.queryTeacherByID(teacher_id);
    	if(tea.getID()==0)	return "";
    	else	return tea.getName();
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
    
    //添加课题信息
  	public boolean createCDTopic(String cdtopic_number,String cdtopic_name,String cdtopic_keyword,String cdtopic_technology,int teacher_id, Date created_at) {
      	String insertSql = 
          		"insert into cdtopic("
          			+ "cdtopic_number,"
          			+ "cdtopic_name,"
          			+ "cdtopic_keyword,"
          			+ "cdtopic_technology,"
          			+ "teacher_id,"
  	        		+ "created_at) "
          		+ "values(?,?,?,?,?,?)";
      	Connection conn = conn();
      	PreparedStatement ps = null;
      	try {
      		ps = conn.prepareStatement(insertSql);
      		ps.setString(1, cdtopic_number);
      		ps.setString(2, cdtopic_name);
      		if(!cdtopic_keyword.equals(""))	ps.setString(3, cdtopic_keyword);	else	ps.setNull(3, Types.VARCHAR);
      		if(!cdtopic_technology.equals(""))	ps.setString(4, cdtopic_technology);	else 	ps.setNull(4, Types.VARCHAR);
      		if(teacher_id != 0)	ps.setInt(5, teacher_id);	else	ps.setNull(5, Types.INTEGER);
      		ps.setTimestamp(6, new Timestamp(created_at.getTime()));
      		ps.executeUpdate();
      	} catch (Exception e1) {
      		e1.printStackTrace();
      		logger.error("数据库语句检查或执行出错！添加课题信息失败："+cdtopic_number+" "+cdtopic_name+" "+cdtopic_keyword+" "+cdtopic_technology+" "+teacher_id);
      		return false;
      	} finally {
      		try {
      			ps.close();
      			conn.close();
      		} catch (SQLException e1) {
      			e1.printStackTrace();
      			logger.error("添加课题信息"+cdtopic_number+" "+cdtopic_name+" "+cdtopic_keyword+" "+cdtopic_technology+" "+teacher_id+"后数据库关闭出错！");
      		}
      	}
      	logger.info("添加课题信息成功："+cdtopic_number+" "+cdtopic_name+" "+cdtopic_keyword+" "+cdtopic_technology+" "+teacher_id);
      	return true;
  	}
    
  	//删除课题信息
    public boolean deleteCDTopic(int cdtopic_id) {
        Connection conn = conn();
        String deleteSQL = "delete from cdtopic where cdtopic_id=" + cdtopic_id;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(deleteSQL);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("数据库语句检查或执行出错！删除课题 "+cdtopic_id+" 失败。");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("删除课题 "+cdtopic_id+" 后数据库关闭出错！");
            }
        }
        logger.info("删除课题 "+cdtopic_id+" 成功。");
        return true;
    }
 
    //查询课题信息
    public List<CDTopic> queryCDTopic(String querySql) {
        List<CDTopic> cdtList = new ArrayList<CDTopic>();
        CDTopic cdt = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                cdt = new CDTopic();
                cdt.cdtopic_id = queryRS.getInt("cdtopic_id");
            	cdt.cdtopic_number = queryRS.getString("cdtopic_number");
            	cdt.cdtopic_name = queryRS.getString("cdtopic_name");
            	cdt.cdtopic_keyword = queryRS.getString("cdtopic_keyword");
            	cdt.cdtopic_technology = queryRS.getString("cdtopic_technology");
            	cdt.cdtopic_headcount = queryRS.getInt("cdtopic_headcount");
            	cdt.cdtopic_grade = queryRS.getDouble("cdtopic_grade");
            	cdt.cdtopic_status = queryRS.getInt("cdtopic_status");
            	cdt.cdtopic_opinion = queryRS.getString("cdtopic_opinion");
            	cdt.cdtopic_active = queryRS.getBoolean("cdtopic_active");
            	cdt.cdtopic_deleted = queryRS.getBoolean("cdtopic_deleted");
            	cdt.teacher_id = queryRS.getInt("teacher_id");
            	cdt.created_at = queryRS.getTimestamp("created_at");
            	cdt.updated_at = queryRS.getTimestamp("updated_at");
            	cdt.deleted_at = queryRS.getTimestamp("deleted_at");
                cdtList.add(cdt);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！课题信息查询失败。");
            return cdtList;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("查询课题信息后数据库关闭出错！");
            }
        }
        return cdtList;
    }
    
    //查询课题信息（按主键查找）
    public CDTopic queryCDTopicByID(int cdtopic_id) {
        String querySql = "select * from cdtopic where cdtopic_id="+"'"+cdtopic_id+"'";
        if(queryCDTopic(querySql).size()!=0) {
        	return queryCDTopic(querySql).get(0);
        }else {
        	return new CDTopic();
        }
    }

    //查询课题信息（按编号查找）
    public List<CDTopic> queryCDTopicByNumber(String cdtopic_number) {
        String querySql = "select * from cdtopic where cdtopic_number="+"'"+cdtopic_number+"'";
        return queryCDTopic(querySql);
    }
    
    //查询课题信息（按名称查找）
    public List<CDTopic> queryCDTopicByName(String cdtopic_name) {
        String querySql = "select * from cdtopic where cdtopic_name="+"'"+cdtopic_name+"'";
        return queryCDTopic(querySql);
    }
    
    //查询课题信息（按关键字查找）
    public List<CDTopic> queryCDTopicByKeyword(String cdtopic_keyword){
    	List<CDTopic> cdtList = new ArrayList<CDTopic>();
    	CDTopic cdt = null;
        ResultSet queryRS = null;
        Statement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.createStatement();
            String querySql = "select * from cdtopic";
            queryRS = queryStatement.executeQuery(querySql);
            while(queryRS.next()) {
            	if(queryRS.getString("cdtopic_keyword") != null && queryRS.getString("cdtopic_keyword").indexOf(cdtopic_keyword) != -1
            		&& !cdtopic_keyword.equals("、")) {
            		cdt = new CDTopic();
            		cdt.cdtopic_id = queryRS.getInt("cdtopic_id");
                	cdt.cdtopic_number = queryRS.getString("cdtopic_number");
                	cdt.cdtopic_name = queryRS.getString("cdtopic_name");
                	cdt.cdtopic_keyword = queryRS.getString("cdtopic_keyword");
                	cdt.cdtopic_technology = queryRS.getString("cdtopic_technology");
                	cdt.cdtopic_headcount = queryRS.getInt("cdtopic_headcount");
                	cdt.cdtopic_grade = queryRS.getDouble("cdtopic_grade");
                	cdt.cdtopic_status = queryRS.getInt("cdtopic_status");
                	cdt.cdtopic_opinion = queryRS.getString("cdtopic_opinion");
                	cdt.cdtopic_active = queryRS.getBoolean("cdtopic_active");
                	cdt.cdtopic_deleted = queryRS.getBoolean("cdtopic_deleted");
                	cdt.teacher_id = queryRS.getInt("teacher_id");
                	cdt.created_at = queryRS.getTimestamp("created_at");
                	cdt.updated_at = queryRS.getTimestamp("updated_at");
                	cdt.deleted_at = queryRS.getTimestamp("deleted_at");
                    cdtList.add(cdt);
            	}
            }
            return cdtList;
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

    //查询课题信息（按实现技术查找）
    public List<CDTopic> queryCDTopicByTechnology(String cdtopic_technology) {
        String querySql = "select * from cdtopic where cdtopic_technology="+"'"+cdtopic_technology+"'";
        return queryCDTopic(querySql);
    }
    
    //查询课题信息（按所属教师查找）
    public List<CDTopic> queryCDTopicByTeacherID(int teacher_id) {
        String querySql = "select * from cdtopic where teacher_id="+"'"+teacher_id+"'";
        return queryCDTopic(querySql);
    }
    
    //查询课题信息（按是否已删除查找）
    public List<CDTopic> queryCDTopicByIsDeleted(boolean cdtopic_deleted) {
    	int deleted = cdtopic_deleted?1:0;
    	String querySql = "select * from cdtopic where cdtopic_deleted="+"'"+deleted+"'";
        return queryCDTopic(querySql);
    }
    
    //修改课题信息
    public boolean updateCDTopic(CDTopic cdt,String cdtopic_number,String cdtopic_name,String cdtopic_keyword,String cdtopic_technology,int teacher_id,Date updated_at) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动才提交
        if(cdtopic_number.equals(cdt.cdtopic_number) == false) {
        	count++;
            String updateSql = "update cdtopic set cdtopic_number='"+cdtopic_number+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 编号:"+cdt.cdtopic_number+"->"+cdtopic_number;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 编号"+cdt.cdtopic_number+"为"+cdtopic_number+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(cdtopic_name.equals(cdt.cdtopic_name) == false) {
        	count++;
            String updateSql = "update cdtopic set cdtopic_name='"+cdtopic_name+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 名称:"+cdt.cdtopic_name+"->"+cdtopic_name;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 名称"+cdt.cdtopic_name+"为"+cdtopic_name+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
    
        if(!(cdtopic_keyword.equals("")&&cdt.cdtopic_keyword == null)&&cdtopic_keyword.equals(cdt.cdtopic_keyword) == false) {
        	count++;
        	String updateSql = null;
        	if(cdtopic_keyword.equals(""))
        		updateSql = "update cdtopic set cdtopic_keyword=null where cdtopic_id=" + cdt.cdtopic_id;
        	else
        		updateSql = "update cdtopic set cdtopic_keyword='"+cdtopic_keyword+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 关键字:"+cdt.cdtopic_keyword+"->"+cdtopic_keyword;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 关键字"+cdt.cdtopic_keyword+"为"+cdtopic_keyword+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(!(cdtopic_technology.equals("")&&cdt.cdtopic_technology == null)&&cdtopic_technology.equals(cdt.cdtopic_technology) == false) {
        	count++;
        	String updateSql = null;
        	if(cdtopic_technology.equals(""))
        		updateSql = "update cdtopic set cdtopic_technology=null where cdtopic_id=" + cdt.cdtopic_id;
        	else
        		updateSql = "update cdtopic set cdtopic_technology='"+cdtopic_technology+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 实现技术:"+cdt.cdtopic_technology+"->"+cdtopic_technology;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 实现技术"+cdt.cdtopic_technology+"为"+cdtopic_technology+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(teacher_id != cdt.teacher_id) {
        	count++;
        	String updateSql = null;
        	if(teacher_id == 0)
        		updateSql = "update cdtopic set teacher_id=null where cdtopic_id=" + cdt.cdtopic_id;
        	else
        		updateSql = "update cdtopic set teacher_id='"+teacher_id+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 教师ID:"+cdt.teacher_id+"->"+teacher_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 教师ID"+cdt.teacher_id+"为"+teacher_id+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(updated_at != cdt.updated_at&&count != 0) {
        	String updateSql = "update cdtopic set updated_at = ? where cdtopic_id="+ cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(updated_at.getTime()));
                ps.executeUpdate();
                ps.close();
                updateStr += " 修改时间:"+cdt.updated_at+"->"+updated_at;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 修改时间"+cdt.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改课题 "+cdt.cdtopic_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改课题 "+cdt.cdtopic_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //修改课题生效状态和审核状态以及审核意见
    public boolean updateCDTopic(CDTopic cdt,boolean cdtopic_active,int cdtopic_status,String cdtopic_opinion) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动才提交
        if(cdtopic_active != cdt.cdtopic_active) {
        	count++;
        	String updateSql = null;
        	updateSql = "update cdtopic set cdtopic_active='"+(cdtopic_active==true?1:0)+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 生效状态:"+cdt.cdtopic_active+"->"+cdtopic_active;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 生效状态"+cdt.cdtopic_active+"为"+cdtopic_active+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(cdtopic_status != cdt.cdtopic_status) {
        	count++;
        	String updateSql = null;
        	updateSql = "update cdtopic set cdtopic_status='"+cdtopic_status+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 审核状态:"+cdt.cdtopic_status+"->"+cdtopic_status;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 审核状态"+cdt.cdtopic_status+"为"+cdtopic_status+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(!(cdtopic_opinion.equals("")&&cdt.cdtopic_opinion == null)&&cdtopic_opinion.equals(cdt.cdtopic_opinion) == false) {
        	count++;
            String updateSql = "update cdtopic set cdtopic_opinion='"+cdtopic_opinion+"' where cdtopic_id=" + cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 审核信息:"+cdt.cdtopic_opinion+"->"+cdtopic_opinion;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 审核信息"+cdt.cdtopic_opinion+"为"+cdtopic_opinion+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        Date updated_at=new Date();
        if(updated_at != cdt.updated_at&&count != 0) {
        	String updateSql = "update cdtopic set updated_at = ? where cdtopic_id="+ cdt.cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(updated_at.getTime()));
                ps.executeUpdate();
                ps.close();
                updateStr += " 修改时间:"+cdt.updated_at+"->"+updated_at;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改课题 "+cdt.cdtopic_id+" 修改时间"+cdt.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改课题 "+cdt.cdtopic_id+" 信息"+updateStr+"后数据库关闭失败！");
        }
        if(count != 0 ) {
        	logger.info("修改课题 "+cdt.cdtopic_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //删除教师信息时，先将课题表中对应的教师信息置空
    public boolean emptyTeacherByTeacherID(int teacher_id) {
    	 Connection conn = conn();
         String updateSQL = "update cdtopic set teacher_id=null where teacher_id="+"'"+teacher_id+"'";
         PreparedStatement ps = null;
         try {
             ps = conn.prepareStatement(updateSQL);
             ps.executeUpdate();
         } catch (Exception e) {
             e.printStackTrace();
             logger.error("数据库语句检查或执行出错！置空所有所属教师为 "+teacher_id+" 的课题的所属教师信息失败。");
             return false;
         } finally {
        	 String updateSql = "update cdtopic set updated_at = ? where teacher_id="+ teacher_id;
             try {
                 ps = conn.prepareStatement(updateSql);
                 ps.setTimestamp(1, new Timestamp(new Date().getTime()));
                 ps.executeUpdate();
                 ps.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("数据库语句检查或执行出错！置空所有所属教师为 "+teacher_id+" 的课题的所属教师信息后更改课题信息修改时间失败。");
                 return false;
             }
             try {
                 ps.close();
                 conn.close();
             } catch (SQLException e1) {
                 e1.printStackTrace();
                 logger.error("置空所有所属教师为 "+teacher_id+" 的课题的所属教师信息后数据库关闭出错！");
             }
         }
         logger.info("置空所有所属教师为 "+teacher_id+" 的课题的所属教师信息成功。");
         return true;
    }
    
    //学生表所选课题信息改变时改变课题表中的选题人数
    public boolean updadeHeadcount(int cdtopic_id,boolean add) {
    	if(cdtopic_id > 0) {
	    	Connection conn = conn();
	       	CDTopic cdt = new CDTopic();
	       	cdt = cdt.queryCDTopicByID(cdtopic_id);
	       	//判断是增加还是减少
	       	String updateSql = null;
	        if(add == true) {
	        	updateSql = "update cdtopic set cdtopic_headcount ='"+(cdt.getHeadcount()+1)+"' where cdtopic_id=" + cdtopic_id;
	        }else {
	        	updateSql = "update cdtopic set cdtopic_headcount ='"+(cdt.getHeadcount()-1)+"' where cdtopic_id=" + cdtopic_id;
	        }
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                conn.close();
                logger.info("修改课题 "+cdtopic_id+ "的选题人数成功！");
                return true;
                } catch (SQLException e1) {
	                e1.printStackTrace();
	                logger.error("数据库语句检查或执行出错！修改课题 "+cdtopic_id+ "的选题人数失败！");
	                return false;
                }
            }else {
            	logger.warn("课题ID必须为正整数！");
            	return false;
            }
    	}

    //刷新课题信息选题人数为实际选题人数
    public boolean refreshHeadcountByID(int cdtopic_id) {
    	if(cdtopic_id > 0) {
    		Connection conn = conn();
    		Student stu = new Student();
        	String updateSql = "update cdtopic set cdtopic_headcount='"+stu.queryStudentByCDTopic(cdtopic_id).size()+"' where cdtopic_id=" + cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                conn.close();
                return true;
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！刷新课题 "+cdtopic_id+ "的选题人数为实际选题人数失败！");
                return false;
            } 
    	}else{
    		logger.warn("课题ID必须为正整数！");
    		return false;
    	}
    }
    
    //刷新所有课题信息选题人数为实际选题人数
    public boolean refreshHeadcountOfAll() {
    	Connection conn = conn();
    	List<CDTopic> cdtList = getCDTopicInfo();
		for(CDTopic cdtopic:cdtList) {
			cdtopic.refreshHeadcountByID(cdtopic.getID());
		}
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("刷新所有课题的选题人数为实际选题人数后数据库关闭出错！");
		}
		/*logger.info("刷新所有课题的选题人数为实际选题人数成功！");*/
		return true;
    }
    
    //刷新单个课题评分
    public boolean refreshGradeByID(int cdtopic_id) {
    	List<Grade> graList = new Grade().queryGradeByCDTopicID(cdtopic_id);
    	double cdtopic_grade = 0;
    	int count = 0;
    	for(Grade grade:graList) {
    		if(grade.getValue()!=0) {
    			count++;
    			cdtopic_grade += grade.getValue();
    		}
    	}
    	cdtopic_grade = cdtopic_grade/(count==0?1:count);
    	if(cdtopic_id > 0) {
    		Connection conn = conn();
        	String updateSql = "update cdtopic set cdtopic_grade='"+cdtopic_grade+"' where cdtopic_id=" + cdtopic_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                conn.close();
                return true;
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！刷新课题 "+cdtopic_id+ "的评分失败！");
                return false;
            } 
    	}else{
    		logger.warn("课题ID必须为正整数！");
    		return false;
    	}
    }
    
    //刷新所有课题信息选题人数为实际选题人数
    public boolean refreshGradeOfAll() {
    	Connection conn = conn();
    	List<CDTopic> cdtList = getCDTopicInfo();
		for(CDTopic cdtopic:cdtList) {
			cdtopic.refreshHeadcountByID(cdtopic.getID());
		}
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("刷新所有课题的评分后数据库关闭出错！");
		}
		/*logger.info("刷新所有课题的评分成功！");*/
		return true;
    }
    
    //判断编号是否存在
    public boolean isExist_number(String cdtopic_number) {
    	if(queryCDTopicByNumber(cdtopic_number).size() != 0)	return true;
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
            ps = conn.prepareStatement("select count(*) from cdtopic");
            rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！无条件获取课题数据量失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("无条件获取课题数据量后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return count;
    }
    
    //按条件获取课题数据
    public List<CDTopic> queryByConditionByString(String querySql,String queryStr) {
    	List<CDTopic> cdtList = new ArrayList<CDTopic>();
    	CDTopic cdt = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
            rs = ps.executeQuery();
            while(rs.next()) {
            	cdt = new CDTopic();
            	cdt.cdtopic_id = rs.getInt("cdtopic_id");
            	cdt.cdtopic_number = rs.getString("cdtopic_number");
            	cdt.cdtopic_name = rs.getString("cdtopic_name");
            	cdt.cdtopic_keyword = rs.getString("cdtopic_keyword")==null?"":rs.getString("cdtopic_keyword");
            	cdt.cdtopic_technology = rs.getString("cdtopic_technology")==null?"":rs.getString("cdtopic_technology");
            	cdt.cdtopic_headcount = rs.getInt("cdtopic_headcount");
            	cdt.cdtopic_grade = rs.getDouble("cdtopic_grade");
            	cdt.cdtopic_status = rs.getInt("cdtopic_status");
            	cdt.cdtopic_opinion = rs.getString("cdtopic_opinion");
            	cdt.cdtopic_active = rs.getBoolean("cdtopic_active");
            	cdt.cdtopic_deleted = rs.getBoolean("cdtopic_deleted");
            	cdt.teacher_id = rs.getInt("teacher_id");
            	cdt.created_at = rs.getTimestamp("created_at");
            	cdt.updated_at = rs.getTimestamp("updated_at");
            	cdt.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		cdtList.add(cdt);
            	}
            	else if(cdt.cdtopic_number.indexOf(queryStr)!=-1||
            			cdt.cdtopic_name.indexOf(queryStr)!=-1||
    					cdt.cdtopic_keyword.indexOf(queryStr)!=-1||
    					cdt.cdtopic_technology.indexOf(queryStr)!=-1) {
            		cdtList.add(cdt);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！按条件获取课题信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("按条件获取课题信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return cdtList;
    }
    
    //按条件获取课题数据（是否删除+是否有效+审核状态+所属教师ID+排序字段+排序规则+搜索字段）（boolean型的2表示不考虑该条件）
    public List<CDTopic> queryByCondition(int cdtopic_deleted,int cdtopic_active,int cdtopic_status,int teacher_id,String sortStr,String sortOrder,String queryStr) {
    	if(cdtopic_deleted==2&&cdtopic_active==2&&cdtopic_status==-1&&teacher_id==0&&queryStr.length()==0) {
    		return queryByConditionByString("select * from cdtopic",queryStr);
    	}else {
    		String querySql = "select * from cdtopic where";
    		if(cdtopic_deleted!=2)	querySql += " cdtopic_deleted = "+cdtopic_deleted+" and";
    		if(cdtopic_active!=2)	querySql += " cdtopic_active = "+cdtopic_active+" and";
    		if(cdtopic_status!=-1)	querySql += " cdtopic_status = "+cdtopic_status+" and";
    		if(teacher_id!=0)		querySql += " teacher_id = "+teacher_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += " order by "+sortStr+" "+sortOrder;
    		return queryByConditionByString(querySql,queryStr);
    	}
    }
    
    //按条件获取课题数据（是否删除+是否有效+审核状态+所属教师ID+搜索字段）（boolean型的2表示不考虑该条件）（默认排序）
    public List<CDTopic> queryByCondition(int cdtopic_deleted,int cdtopic_active,int cdtopic_status,int teacher_id,String queryStr) {
    	if(cdtopic_deleted==2&&cdtopic_active==2&&cdtopic_status==-1&&teacher_id==0&&queryStr.length()==0) {
    		return queryByConditionByString("select * from cdtopic",queryStr);
    	}else {
    		String querySql = "select * from cdtopic where";
    		if(cdtopic_deleted!=2)	querySql += " cdtopic_deleted = "+cdtopic_deleted+" and";
    		if(cdtopic_active!=2)	querySql += " cdtopic_active = "+cdtopic_active+" and";
    		if(cdtopic_status!=-1)	querySql += " cdtopic_status = "+cdtopic_status+" and";
    		if(teacher_id!=0)		querySql += " teacher_id = "+teacher_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		return queryByConditionByString(querySql,queryStr);
    	}
    }

    //返回分页数据
    public List<CDTopic> cutPageDataByString(int page,int pageSize,String querySql,String queryStr){
        List<CDTopic> cdtList = new ArrayList<CDTopic>();
        CDTopic cdt = null;
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
            	cdt = new CDTopic();
            	cdt.cdtopic_id = rs.getInt("cdtopic_id");
            	cdt.cdtopic_number = rs.getString("cdtopic_number");
            	cdt.cdtopic_name = rs.getString("cdtopic_name");
            	cdt.cdtopic_keyword = rs.getString("cdtopic_keyword")==null?"":rs.getString("cdtopic_keyword");
            	cdt.cdtopic_technology = rs.getString("cdtopic_technology")==null?"":rs.getString("cdtopic_technology");
            	cdt.cdtopic_headcount = rs.getInt("cdtopic_headcount");
            	cdt.cdtopic_grade = rs.getDouble("cdtopic_grade");
            	cdt.cdtopic_status = rs.getInt("cdtopic_status");
            	cdt.cdtopic_opinion = rs.getString("cdtopic_opinion");
            	cdt.cdtopic_active = rs.getBoolean("cdtopic_active");
            	cdt.cdtopic_deleted = rs.getBoolean("cdtopic_deleted");
            	cdt.teacher_id = rs.getInt("teacher_id");
            	cdt.created_at = rs.getTimestamp("created_at");
            	cdt.updated_at = rs.getTimestamp("updated_at");
            	cdt.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		cdtList.add(cdt);
            	}
            	else if(cdt.cdtopic_number.indexOf(queryStr)!=-1||
            			cdt.cdtopic_name.indexOf(queryStr)!=-1||
    					cdt.cdtopic_keyword.indexOf(queryStr)!=-1||
    					cdt.cdtopic_technology.indexOf(queryStr)!=-1) {
            		cdtList.add(cdt);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取课题分页信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("获取课题分页信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        if(queryStr.length()==0) {
        	return cdtList;
        }else {
        	int count = queryByConditionByString(querySql,queryStr).size();
        	int start = page*pageSize-pageSize;
        	int end;
        	if(start == (count/pageSize)*pageSize) {
        		end = start+count%pageSize;
        		return cdtList.subList(start, end);
        	}else {
        		end = start+pageSize;
        		return cdtList.subList(start, end);
        	}
        }
    }
    
    //返回分页数据（是否删除+是否有效+审核状态+所属教师ID+排序字段+排序规则+搜索字段）（boolean型的2表示不考虑该条件）
    public List<CDTopic> cutPageData(int page,int pageSize,int cdtopic_deleted,int cdtopic_active,int cdtopic_status,int teacher_id,String sortStr,String sortOrder,String queryStr){
    	if(cdtopic_deleted==2&&cdtopic_active==2&&cdtopic_status==-1&&teacher_id==0&&queryStr.length()==0) {
    		return cutPageDataByString(page,pageSize,"select * from cdtopic limit ?,?",queryStr);
    	}else {
    		String querySql = "select * from cdtopic where";
    		if(cdtopic_deleted!=2)	querySql += " cdtopic_deleted = "+cdtopic_deleted+" and";
    		if(cdtopic_active!=2)	querySql += " cdtopic_active = "+cdtopic_active+" and";
    		if(cdtopic_status!=-1)	querySql += " cdtopic_status = "+cdtopic_status+" and";
    		if(teacher_id!=0)		querySql += " teacher_id = "+teacher_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += " order by "+sortStr+" "+sortOrder;
    		querySql += " limit ?,?";
    		return cutPageDataByString(page,pageSize,querySql,queryStr);
    	}
    }
    
    //从数据库获取所有课题信息返回课题表
    public List<CDTopic> getCDTopicInfo() {
        List<CDTopic> CDTList = new ArrayList<CDTopic>();
        CDTopic cdt = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from cdtopic";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	cdt = new CDTopic();
            	cdt.cdtopic_id = queryRS.getInt("cdtopic_id");
            	cdt.cdtopic_number = queryRS.getString("cdtopic_number");
            	cdt.cdtopic_name = queryRS.getString("cdtopic_name");
            	cdt.cdtopic_keyword = queryRS.getString("cdtopic_keyword");
            	cdt.cdtopic_technology = queryRS.getString("cdtopic_technology");
            	cdt.cdtopic_headcount = queryRS.getInt("cdtopic_headcount");
            	cdt.cdtopic_grade = queryRS.getDouble("cdtopic_grade");
            	cdt.cdtopic_status = queryRS.getInt("cdtopic_status");
            	cdt.cdtopic_opinion = queryRS.getString("cdtopic_opinion");
            	cdt.cdtopic_active = queryRS.getBoolean("cdtopic_active");
            	cdt.cdtopic_deleted = queryRS.getBoolean("cdtopic_deleted");
            	cdt.teacher_id = queryRS.getInt("teacher_id");
            	cdt.created_at = queryRS.getTimestamp("created_at");
            	cdt.updated_at = queryRS.getTimestamp("updated_at");
            	cdt.deleted_at = queryRS.getTimestamp("deleted_at");
            	CDTList.add(cdt);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取课题信息失败！");
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
            	logger.error("获取课题信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return CDTList;
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
