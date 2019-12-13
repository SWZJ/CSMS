package JZW;

import java.sql.*;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.apache.log4j.Logger;

import java.util.Date;
 
public class Grade {
	private int grade_id;				//评分主键
    private String grade_identifier;	//评分编号
    private double grade_value;			//评分数值
    private String grade_content;		//评分内容
    private int grade_user;				//评分用户主键
    private int grade_type;				//评分对象类型
    private boolean grade_deleted;		//评分是否已删除
    private int cdtopic_id;				//评分的课题外键
    private int teacher_id;				//评分的教师外键
    private Date created_at;			//新增时间
    private Date updated_at;			//修改时间
    private Date deleted_at;			//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
 
    public Grade() {}
 
    public int getID() {
    	return grade_id;
    }
    
    public void setID(int grade_id) {
    	this.grade_id = grade_id;
    }
    
    public String getIden() {
        return grade_identifier;
    }
 
    public void setIden(String grade_identifier) {
        this.grade_identifier = grade_identifier;
    }
 
    public String getValueStr() {
    	if(grade_value==0)	return "无";
    	else {
    		DecimalFormat df = new DecimalFormat("0.0"); 
    		return df.format(grade_value);
    	}
    }
    
    public double getValue() {
    	return grade_value;
    }
 
    public void setValue(double grade_value) {
        this.grade_value = grade_value;
    }
 
    public String getContent() {
    	return grade_content;
    }
    
    public void setContent(String grade_content) {
    	this.grade_content = grade_content;
    }
    
    public String getUser() {
    	if(grade_user<=0)	return "匿名用户";
    	else 	return new User().queryUserByID(grade_user).getName();
    }
    
    public int getUserID() {
    	return grade_user;
    }
    
    public void setUserID(int grade_user) {
    	this.grade_user = grade_user;
    }
    
    public int getType() {
        return grade_type;
    }
 
    public void setType(int grade_type) {
        this.grade_type = grade_type;
    }
    
    public String getIsDeleteStr() {
    	if(grade_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return grade_deleted;
    }
    
    public void setIsDeleted(boolean grade_deleted) {
    	this.grade_deleted = grade_deleted;
    }
 
    public String getCDTopic() {
    	if(cdtopic_id!=0) {
    		return new User().queryUserByID(cdtopic_id).getName();
    	}else {
    		return "";
    	}
    }
    
    public int getCDTopicID() {
        return cdtopic_id;
    }
 
    public void setCDTopicID(int cdtopic_id) {
        this.cdtopic_id = cdtopic_id;
    }
    
    public String getTeacher() {
    	if(teacher_id!=0) {
    		return new User().queryUserByID(teacher_id).getName();
    	}else {
    		return "";
    	}
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
    
    public static String getRandomIden() {
		String[] chars = new String[] { "a", "b", "c", "d", "e", "f",  
                "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",  
                "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5",  
                "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I",  
                "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",  
                "W", "X", "Y", "Z" };  
        Random r = new Random();
        StringBuffer shortBuffer = new StringBuffer();  
        String uuid = UUID.randomUUID().toString().replace("-", "");  
        for (int i = 0; i < 8; i++) {  
            String str = uuid.substring(i * 4, i * 4 + 4);  
            int x = Integer.parseInt(str, 16);  
            shortBuffer.append(chars[x % 0x3E]);  
        }
        return shortBuffer.toString()+(r.nextInt(899)+100);  
	}
    
    //添加评分信息
	public boolean CreateGrade(double grade_value,String grade_content,int grade_user,int grade_type,int foreign_id) {
		String insertSql = 
        		"insert into grade("
        			+ "grade_identifier,"
        			+ "grade_value,"
        			+ "grade_content,"
        			+ "grade_user,"
        			+ "grade_type,"
	        		+ ""+(grade_type==0?"cdtopic_id":"teacher_id")+","
	        		+ "created_at) "
        		+ "values(?,?,?,?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        String grade_identifier = getRandomIden();
        while(true) {
    		if(isExist_identifier(grade_identifier)) {
    			grade_identifier = getRandomIden();
    		}else {
    			break;
    		}
    	}
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1, grade_identifier);
        	ps.setDouble(2, grade_value);
        	if(grade_content.length()==0)	ps.setNull(3, Types.VARCHAR);	else	ps.setString(3, grade_content);
        	ps.setInt(4, grade_user);
        	ps.setInt(5, grade_type);
        	ps.setInt(6, foreign_id);
        	ps.setTimestamp(7, new Timestamp(new Date().getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            logger.error("数据库语句检查或执行出错！添加评分失败："+grade_identifier+" "+grade_value+" "+grade_content+" "+grade_user+" "+grade_type+" "+foreign_id);
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("添加评分"+grade_identifier+" "+grade_value+" "+grade_content+" "+grade_user+" "+grade_type+" "+foreign_id+"后数据库关闭出错！");
            }
        }
        logger.info("添加评分成功："+grade_identifier+" "+grade_value+" "+grade_content+" "+grade_user+" "+grade_type+" "+foreign_id);
        return true;
    }
 
	//软删除评分信息
    public boolean softDeleteGradeByID(int grade_id) {
    	Connection conn = conn();
    	String updateSql = "update grade set grade_deleted='"+1+"' where grade_id=" + grade_id;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(updateSql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("数据库语句检查或执行出错！软删除评分 "+grade_id+" 失败。");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("软删除评分 "+grade_id+" 后数据库关闭出错！");
            }
        }
        logger.info("软删除评分 "+grade_id+" 成功。");
        return true;
    }
	
    //删除评分信息
    public boolean deleteGradeByID(int grade_id) {
        Connection conn = conn();
        String deleteSql = "delete from grade where grade_id=" + grade_id;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(deleteSql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("数据库语句检查或执行出错！删除评分 "+grade_id+" 失败。");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("删除评分 "+grade_id+" 后数据库关闭出错！");
            }
        }
        logger.info("删除评分 "+grade_id+" 成功。");
        return true;
    }
    
    //删除课题信息时，先将评分表中对应的评分信息删除
    public boolean deleteGradeByCDTopicID(int cdtopic_id) {
    	List<Grade> graList = this.queryGradeByCDTopicID(cdtopic_id);
    	boolean ok = false;
    	for(Grade gra:graList) {
    		ok = this.deleteGradeByID(gra.getID());
    	}
    	if(ok==true){
    		logger.info("删除课题 "+cdtopic_id+" 的所有评分信息成功。");
    		return true;
    	}else {
    		logger.error("删除课题 "+cdtopic_id+" 的所有评分信息失败。");
    		return false;
    	}
	}
 
    //查询评分信息
    public List<Grade> queryGrade(String querySql) {
        List<Grade> graList = new ArrayList<Grade>();
        Grade gra = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	gra = new Grade();
                gra.grade_id = queryRS.getInt("grade_id");
                gra.grade_identifier = queryRS.getString("grade_identifier");
                gra.grade_value = queryRS.getDouble("grade_value");
                gra.grade_content = queryRS.getString("grade_content");
                gra.grade_user = queryRS.getInt("grade_user");
                gra.grade_type = queryRS.getInt("grade_type");
                gra.grade_deleted = queryRS.getBoolean("grade_deleted");
                gra.cdtopic_id = queryRS.getInt("cdtopic_id");
                gra.teacher_id = queryRS.getInt("teacher_id");
                gra.created_at = queryRS.getTimestamp("created_at");
                gra.updated_at = queryRS.getTimestamp("updated_at");
                gra.deleted_at = queryRS.getTimestamp("deleted_at");
                graList.add(gra); 
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！评分查询失败。");
            return graList;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("查询评分后数据库关闭出错！");
            }
        }
        return graList;
    }
    
    
    //查询评分信息（按主键查找）
    public Grade queryGradeByID(int grade_id) {
        String querySql = "select * from grade where grade_id="+"'"+grade_id+"'";
        if(queryGrade(querySql).size()!=0) {
        	return queryGrade(querySql).get(0);
        }else {
        	return new Grade();
        }
    }
 
    //查询评分信息（按编号查找）
    public List<Grade> queryGradeByIden(String grade_identifier) {
    	String querySql = "select * from grade where grade_identifier="+"'"+grade_identifier+"'";
    	return queryGrade(querySql);
    }
    
    //查询评分信息（按数值查找）
    public List<Grade> queryGradeByValue(double grade_value) {
    	String querySql = "select * from grade where grade_value="+"'"+grade_value+"'";
    	return queryGrade(querySql);
    }
    
    //查询评分信息（按评分人查找）
    public List<Grade> queryGradeByUserID(int grade_user) {
    	String querySql = "select * from grade where grade_user="+"'"+grade_user+"'";
        return queryGrade(querySql);
    }
    
    //查询评分信息（按类型查找）
    public List<Grade> queryGradeByType(int grade_type) {
    	String querySql = "select * from grade where grade_type="+"'"+grade_type+"'";
        return queryGrade(querySql);
    }
    
    //查询评分信息（按是否阅读查找）
    public List<Grade> queryGradeByReaded(boolean grade_readed) {
    	int readed = grade_readed?1:0;
    	String querySql = "select * from grade where grade_readed="+"'"+readed+"'";
        return queryGrade(querySql);
    }
    
    //查询评分信息（按评分课题查找）
    public List<Grade> queryGradeByCDTopicID(int cdtopic_id) {
    	String querySql = "select * from grade where cdtopic_id="+"'"+cdtopic_id+"'";
        return queryGrade(querySql);
    }
    
    //查询评分信息（按评分教师查找）
    public List<Grade> queryGradeByTeacherID(int teacher_id) {
    	String querySql = "select * from grade where teacher_id="+"'"+teacher_id+"'";
        return queryGrade(querySql);
    }
    
    //查询评分信息（按是否已删除查找）
    public List<Grade> queryGradeByIsDeleted(boolean grade_deleted) {
    	int deleted = grade_deleted?1:0;
    	String querySql = "select * from grade where grade_deleted="+"'"+deleted+"'";
        return queryGrade(querySql);
    }
    
    //修改评分信息
    public boolean updateGrade(Grade gra,String grade_identifier,double grade_value,String grade_content) {
    	String updateStr = "";
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(grade_identifier.equals(gra.grade_identifier) == false) {
        	count++;
            String updateSql = "update grade set grade_identifier='"+grade_identifier+"' where grade_id=" + gra.grade_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 编号:"+gra.grade_identifier+"->"+grade_identifier;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改评分 "+gra.grade_id+" 编号"+gra.grade_identifier+"为"+grade_identifier+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(grade_value!=gra.grade_value) {
        	count++;
        	String updateSql = "update grade set grade_value='"+grade_value+"' where grade_id=" + gra.grade_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 评分数值:"+gra.grade_value+"->"+grade_value;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改评分 "+gra.grade_value+" 数值"+gra.grade_value+"为"+grade_value+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(grade_content.equals(gra.grade_content) == false) {
        	count++;
        	String updateSql = "update grade set grade_content='"+grade_content+"' where grade_id=" + gra.grade_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 内容:"+gra.grade_content+"->"+grade_content;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改评分 "+gra.grade_id+" 内容"+gra.grade_content+"为"+grade_content+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        updated_at= new Date();
        if(updated_at != gra.updated_at&&count != 0) {
        	String updateSql = "update grade set updated_at = ? where grade_id="+ gra.grade_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(updated_at.getTime()));
                ps.executeUpdate();
                ps.close();
                updateStr += " 修改时间:"+gra.updated_at+"->"+updated_at;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改评分 "+gra.grade_id+" 修改时间"+gra.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改评分 "+gra.grade_id+" 信息"+updateStr+"后数据库关闭出错！");
        }
        if(count != 0 ) {
        	logger.info("修改评分 "+gra.grade_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //标记是否软删除
    public boolean updateGradeOfSoftDelete(boolean grade_deleted) {
    	int deleted = grade_deleted?1:0;
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
        Connection conn = conn();
        //信息有改动时才修改
        if(grade_deleted != this.grade_deleted) {
        	count++;
            String updateSql = "update grade set grade_deleted='"+deleted+"' where grade_id=" + this.grade_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！标记评分 "+this.grade_id+" 软删除状态为"+grade_deleted+"失败！");
                return false;
            }
        }
        if(nowTime != this.updated_at&&count != 0) {
        	String updateSql = "update grade set updated_at = ? where grade_id="+ this.grade_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(nowTime.getTime()));
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！标记评分 "+this.grade_id+" 软删除状态为"+grade_deleted+"后更改修改时间失败！");
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
        	logger.error("标记评分 "+this.grade_id+" 软删除状态为"+grade_deleted+"后数据库关闭出错！");
            e1.printStackTrace();
        }
        logger.info("标记评分 "+this.grade_id+" 软删除状态为"+grade_deleted+"成功！");
        return true;
    }

    //判断编号是否存在
    public boolean isExist_identifier(String grade_identifier) {
    	if(queryGradeByIden(grade_identifier).size() != 0)	return true;
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
            ps = conn.prepareStatement("select count(*) from grade");
            rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！无条件获取评分数据量失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("无条件获取评分数据量后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return count;
    }
    
    //按条件获取评分数据
    public List<Grade> queryByConditionByString(String querySql,String queryStr) {
    	List<Grade> graList = new ArrayList<Grade>();
        Grade gra = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
            rs = ps.executeQuery();
            while(rs.next()) {
            	gra = new Grade();
            	gra.grade_id = rs.getInt("grade_id");
                gra.grade_identifier = rs.getString("grade_identifier");
                gra.grade_value = rs.getDouble("grade_value");
                gra.grade_content = rs.getString("grade_content");
                gra.grade_user = rs.getInt("grade_user");
                gra.grade_type = rs.getInt("grade_type");
                gra.grade_deleted = rs.getBoolean("grade_deleted");
                gra.cdtopic_id = rs.getInt("cdtopic_id");
                gra.teacher_id = rs.getInt("teacher_id");
                gra.created_at = rs.getTimestamp("created_at");
                gra.updated_at = rs.getTimestamp("updated_at");
                gra.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		graList.add(gra);
            	}
            	else if(gra.grade_identifier.indexOf(queryStr)!=-1||
            			gra.grade_content.indexOf(queryStr)!=-1) {
            		graList.add(gra);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！按条件获取评分信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("按条件获取评分信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return graList;
    }
    
    //按条件获取评分数据（是否删除+评分者ID+评分课题ID+评分教师ID）（boolean型的2表示不考虑该条件）
    public List<Grade> queryByCondition(int grade_deleted,int grade_user,int cdtopic_id,int teahcer_id,String queryStr) {
    	if(grade_deleted==2&&grade_user==0&&cdtopic_id==0&&teahcer_id==0&&queryStr.length()==0) {
    		return queryByConditionByString("select * from grade",queryStr);
    	}else {
    		String querySql = "select * from grade where";
    		if(grade_deleted!=2)	querySql += " grade_deleted = "+grade_deleted+" and";
    		if(grade_user!=0)		querySql += " grade_user = "+grade_user+" and";
    		if(cdtopic_id!=0)		querySql += " cdtopic_id = "+cdtopic_id+" and";
    		if(teahcer_id!=0)		querySql += " teahcer_id = "+teahcer_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		return queryByConditionByString(querySql,queryStr);
    	}
    }

    //返回分页数据
    public List<Grade> cutPageDataByString(int page,int pageSize,String querySql,String queryStr){
    	List<Grade> graList = new ArrayList<Grade>();
        Grade gra = null;
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
            	gra = new Grade();
            	gra.grade_id = rs.getInt("grade_id");
                gra.grade_identifier = rs.getString("grade_identifier");
                gra.grade_value = rs.getDouble("grade_value");
                gra.grade_content = rs.getString("grade_content");
                gra.grade_user = rs.getInt("grade_user");
                gra.grade_type = rs.getInt("grade_type");
                gra.grade_deleted = rs.getBoolean("grade_deleted");
                gra.cdtopic_id = rs.getInt("cdtopic_id");
                gra.teacher_id = rs.getInt("teacher_id");
                gra.created_at = rs.getTimestamp("created_at");
                gra.updated_at = rs.getTimestamp("updated_at");
                gra.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		graList.add(gra);
            	}
            	else if(gra.grade_identifier.indexOf(queryStr)!=-1||
            			gra.grade_content.indexOf(queryStr)!=-1) {
            		graList.add(gra);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取评分分页信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("获取评分分页信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        if(queryStr.length()==0) {
        	return graList;
        }else {
        	int count = queryByConditionByString(querySql,queryStr).size();
        	int start = page*pageSize-pageSize;
        	int end;
        	if(start == (count/pageSize)*pageSize) {
        		end = start+count%pageSize;
        		return graList.subList(start, end);
        	}else {
        		end = start+pageSize;
        		return graList.subList(start, end);
        	}
        }
    }
    
    //返回分页数据（是否删除+评分者ID+评分课题ID+评分教师ID）（boolean型的2表示不考虑该条件）
    public List<Grade> cutPageData(int page,int pageSize,int grade_deleted,int grade_user,int cdtopic_id,int teahcer_id,String queryStr){
    	if(grade_deleted==2&&grade_user==0&&cdtopic_id==0&&teahcer_id==0&&queryStr.length()==0) {
    		return cutPageDataByString(page,pageSize,"select * from grade limit ?,?",queryStr);
    	}else {
    		String querySql = "select * from grade where";
    		if(grade_deleted!=2)	querySql += " grade_deleted = "+grade_deleted+" and";
    		if(grade_user!=0)		querySql += " grade_user = "+grade_user+" and";
    		if(cdtopic_id!=0)		querySql += " cdtopic_id = "+cdtopic_id+" and";
    		if(teahcer_id!=0)		querySql += " teahcer_id = "+teahcer_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += "limit ?,?";
    		return cutPageDataByString(page,pageSize,querySql,queryStr);
    	}
    }
    
    //从数据库获取所有评分信息返回评分表
    public List<Grade> getGradeInfo() {
        List<Grade> graList = new ArrayList<Grade>();
        Grade gra = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from grade";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                gra = new Grade();
                gra.grade_id = queryRS.getInt("grade_id");
                gra.grade_identifier = queryRS.getString("grade_identifier");
                gra.grade_value = queryRS.getDouble("grade_value");
                gra.grade_content = queryRS.getString("grade_content");
                gra.grade_user = queryRS.getInt("grade_user");
                gra.grade_type = queryRS.getInt("grade_type");
                gra.grade_deleted = queryRS.getBoolean("grade_deleted");
                gra.cdtopic_id = queryRS.getInt("cdtopic_id");
                gra.teacher_id = queryRS.getInt("teacher_id");
                gra.created_at = queryRS.getTimestamp("created_at");
                gra.updated_at = queryRS.getTimestamp("updated_at");
                gra.deleted_at = queryRS.getTimestamp("deleted_at");
                graList.add(gra);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取评分信息失败！");
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
            	logger.error("获取评分信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return graList;
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
