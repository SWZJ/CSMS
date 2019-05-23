package JZW;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import java.util.Date;
 
public class Message {
	private int message_id;				//消息主键
    private String message_identifier;	//消息编号
    private int message_type;		//消息类型
    private String message_summary;		//消息概述
    private String message_content;		//消息内容
    private boolean message_readed;		//消息是否已阅读
    private boolean message_deleted;	//消息是否已删除
    private int sender_id;				//发送者外键
    private int receiver_id;			//接收者外键
    private Date created_at;			//新增时间
    private Date updated_at;			//修改时间
    private Date deleted_at;			//删除时间
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
 
    public Message() {}
 
    public int getID() {
    	return message_id;
    }
    
    public void setID(int message_id) {
    	this.message_id = message_id;
    }
    
    public String getIden() {
        return message_identifier;
    }
 
    public void setIden(String message_identifier) {
        this.message_identifier = message_identifier;
    }
 
    public String getTypeStr() {
    	switch(message_type) {
    	case 0:return "dot bg-info";
    	case 1:return "dot bg-success";
    	case 2:return "dot bg-danger";
    	case 3:return "dot bg-primary";
    	case 4:return "dot bg-warning";
    	default:return "dot bg-info";
    	}
    }
    
    public int getType() {
    	return message_type;
    }
 
    public void setType(int message_type) {
        this.message_type = message_type;
    }
 
    public String getSummary() {
    	return message_summary;
    }
    
    public void setSummary(String message_summary) {
    	this.message_summary = message_summary;
    }
    
    public String getContent() {
    	return message_content;
    }
    
    public void setContent(String message_content) {
    	this.message_content = message_content;
    }
    
    public String getReadedStr() {
    	if(message_readed == true) {
    		return "已阅读";
    	}else {
    		return "未阅读";
    	}
    }
    
    public boolean getReaded() {
        return message_readed;
    }
 
    public void setReaded(boolean message_readed) {
        this.message_readed = message_readed;
    }
    
    public String getIsDeleteStr() {
    	if(message_deleted == true) {
    		return "已删除";
    	}else {
    		return "未删除";
    	}
    }
    
    public boolean getIsDeleted() {
    	return message_deleted;
    }
    
    public void setIsDeleted(boolean message_deleted) {
    	this.message_deleted = message_deleted;
    }
 
    public String getSender() {
    	if(sender_id!=0) {
    		return new User().queryUserByID(sender_id).getName();
    	}else {
    		return "";
    	}
    }
    
    public int getSenderID() {
        return sender_id;
    }
 
    public void setSenderID(int sender_id) {
        this.sender_id = sender_id;
    }
    
    public String getReceiver() {
    	if(receiver_id!=0) {
    		return new User().queryUserByID(receiver_id).getName();
    	}else {
    		return "";
    	}
    }
    
    public int getReceiverID() {
        return receiver_id;
    }
 
    public void setReceiverID(int receiver_id) {
        this.receiver_id = receiver_id;
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
 
    //添加消息信息
	public boolean CreateMessage(String message_identifier,String message_type,String message_summary,String message_content,int sender_id,int receiver_id,Date created_at) {
		String insertSql = 
        		"insert into message("
        			+ "message_identifier,"
        			+ "message_type,"
        			+ "message_summary,"
        			+ "message_content,"
        			+ "sender_id,"
	        		+ "receiver_id,"
	        		+ "created_at) "
        		+ "values(?,?,?,?,?,?,?)";
        Connection conn = conn();
        PreparedStatement ps = null;
        try {
        	ps = conn.prepareStatement(insertSql);
        	ps.setString(1, message_identifier);
        	if(!message_type.equals(""))	ps.setString(2, message_type);
        	ps.setString(3, message_summary);
        	ps.setString(4, message_content);
        	if(sender_id != 0)		ps.setInt(5, sender_id);	else 	ps.setNull(5, Types.INTEGER);
        	if(receiver_id != 0)	ps.setInt(6, receiver_id);	else 	ps.setNull(6, Types.INTEGER);
        	ps.setTimestamp(7, new Timestamp(created_at.getTime()));
            ps.executeUpdate();
        } catch (Exception e1) {
            e1.printStackTrace();
            logger.error("数据库语句检查或执行出错！添加消息失败："+message_identifier+" "+message_type+" "+message_summary+" "+message_content+" "+sender_id+" "+receiver_id);
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("添加消息"+message_identifier+" "+message_type+" "+message_summary+" "+message_content+" "+sender_id+" "+receiver_id+"后数据库关闭出错！");
            }
        }
        logger.error("添加消息成功："+message_identifier+" "+message_type+" "+message_summary+" "+message_content+" "+sender_id+" "+receiver_id);
        return true;
    }
 
    //删除消息信息
    public boolean deleteMessageByID(int message_id) {
        Connection conn = conn();
        String deleteSql = "delete from message where message_id=" + message_id;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(deleteSql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("数据库语句检查或执行出错！删除消息 "+message_id+" 失败。");
            return false;
        } finally {
            try {
                ps.close();
                conn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("删除消息 "+message_id+" 后数据库关闭出错！");
            }
        }
        logger.info("删除消息 "+message_id+" 成功。");
        return true;
    }
 
    //查询消息信息
    public List<Message> queryMessage(String querySql) {
        List<Message> mesList = new ArrayList<Message>();
        Message mes = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            queryStatement = queryConn.prepareStatement(querySql);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
            	mes = new Message();
                mes.message_id = queryRS.getInt("message_id");
                mes.message_identifier = queryRS.getString("message_identifier");
                mes.message_type = queryRS.getInt("message_type");
                mes.message_summary = queryRS.getString("message_summary");
                mes.message_content = queryRS.getString("message_content");
                mes.message_readed = queryRS.getBoolean("message_readed");
                mes.message_deleted = queryRS.getBoolean("message_deleted");
                mes.sender_id = queryRS.getInt("sender_id");
                mes.receiver_id = queryRS.getInt("receiver_id");
                mes.created_at = queryRS.getTimestamp("created_at");
                mes.updated_at = queryRS.getTimestamp("updated_at");
                mes.deleted_at = queryRS.getTimestamp("deleted_at");
                mesList.add(mes);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！消息查询失败。");
            return mesList;
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("查询消息后数据库关闭出错！");
            }
        }
        return mesList;
    }
    
    
    //查询消息信息（按主键查找）
    public Message queryMessageByID(int message_id) {
        String querySql = "select * from message where message_id="+"'"+message_id+"'";
        if(queryMessage(querySql).size()!=0) {
        	return queryMessage(querySql).get(0);
        }else {
        	return new Message();
        }
    }
 
    //查询消息信息（按编号查找）
    public List<Message> queryMessageByIden(String message_identifier) {
    	String querySql = "select * from student where message_identifier="+"'"+message_identifier+"'";
    	return queryMessage(querySql);
    }
    
    //查询消息信息（按类型查找）
    public List<Message> queryMessageByType(String message_type) {
    	String querySql = "select * from message where message_type="+"'"+message_type+"'";
        return queryMessage(querySql);
    }
    
    //查询消息信息（按是否阅读查找）
    public List<Message> queryMessageByReaded(boolean message_readed) {
    	int readed = message_readed?1:0;
    	String querySql = "select * from message where message_readed="+"'"+readed+"'";
        return queryMessage(querySql);
    }
    
    //查询消息信息（按发送者查找）
    public List<Message> queryMessageBySenderID(int sender_id) {
    	String querySql = "select * from message where sender_id="+"'"+sender_id+"'";
        return queryMessage(querySql);
    }
    
    //查询消息信息（按接收者查找）
    public List<Message> queryMessageByReceiverID(int receiver_id) {
    	String querySql = "select * from message where receiver_id="+"'"+receiver_id+"'";
        return queryMessage(querySql);
    }
    
    //查询消息信息（按接收者和是否阅读查找）
    public List<Message> queryMessageOfNew(int receiver_id,boolean message_readed) {
    	int readed = message_readed?1:0;
    	String querySql = "select * from message where receiver_id="+"'"+receiver_id+"' and message_readed="+"'"+readed+"'";
        return queryMessage(querySql);
    }
    
    //查询消息信息（按是否已删除查找）
    public List<Message> queryMessageByIsDeleted(boolean message_deleted) {
    	int deleted = message_deleted?1:0;
    	String querySql = "select * from message where message_deleted="+"'"+deleted+"'";
        return queryMessage(querySql);
    }
    
    //修改消息信息
    public boolean updateMessage(Message mes,String message_identifier,int message_type,String message_summary,String message_content,int sender_id,int receiver_id,Date updated_at) {
    	
    	String updateStr = "";
    	int count = 0;//记录是否有修改
        Connection conn = conn();
        //信息有改动时才修改
        if(message_identifier.equals(mes.message_identifier) == false) {
        	count++;
            String updateSql = "update message set message_identifier='"+message_identifier+"' where message_id=" + mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 编号:"+mes.message_identifier+"->"+message_identifier;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 编号"+mes.message_identifier+"为"+message_identifier+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(message_type!=mes.message_type) {
        	count++;
        	String updateSql = "update message set message_type='"+message_type+"' where message_id=" + mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 类型:"+mes.message_type+"->"+message_type;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 类型"+mes.message_type+"为"+message_type+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(message_summary.equals(mes.message_summary) == false) {
        	count++;
        	String updateSql = "update message set message_summary='"+message_summary+"' where message_id=" + mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 概述:"+mes.message_summary+"->"+message_summary;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 概述"+mes.message_summary+"为"+message_summary+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(message_content.equals(mes.message_content) == false) {
        	count++;
        	String updateSql = "update message set message_content='"+message_content+"' where message_id=" + mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 内容:"+mes.message_content+"->"+message_content;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 内容"+mes.message_content+"为"+message_content+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
 
        if(sender_id != mes.sender_id) {
        	count++;
        	String updateSql = "update message set sender_id='"+sender_id+"' where message_id=" + mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 发送者ID:"+mes.sender_id+"->"+sender_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 发送者ID"+mes.sender_id+"为"+sender_id+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(receiver_id != mes.receiver_id) {
        	count++;
        	String updateSql = "update message set receiver_id='"+receiver_id+"' where message_id=" + mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
                updateStr += " 接收者ID:"+mes.receiver_id+"->"+receiver_id;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 接收者ID"+mes.receiver_id+"为"+receiver_id+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        if(updated_at != mes.updated_at&&count != 0) {
        	String updateSql = "update message set updated_at = ? where message_id="+ mes.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(updated_at.getTime()));
                ps.executeUpdate();
                ps.close();
                updateStr += " 修改时间:"+mes.updated_at+"->"+updated_at;
            } catch (SQLException e1) {
            	logger.error("数据库语句检查或执行出错！修改消息 "+mes.message_id+" 修改时间"+mes.updated_at+"为"+updated_at+"失败。");
                e1.printStackTrace();
                return false;
            }
        }
        
        try {
            conn.close();
        } catch (SQLException e1) {
            e1.printStackTrace();
            logger.error("修改消息 "+mes.message_id+" 信息"+updateStr+"后数据库关闭出错！");
        }
        if(count != 0 ) {
        	logger.info("修改消息 "+mes.message_id+" 信息成功！"+updateStr);
        }
        return true;
    }
    
    //标记是否阅读
    public boolean updateMessageOfReaded(boolean message_readed) {
    	int readed = message_readed?1:0;
    	int count = 0;//记录是否有修改
    	Date nowTime = new Date();
        Connection conn = conn();
        //信息有改动时才修改
        if(message_readed != this.message_readed) {
        	count++;
            String updateSql = "update message set message_readed='"+readed+"' where message_id=" + this.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！标记消息 "+this.message_id+" 阅读状态为"+message_readed+"失败！");
                return false;
            }
        }
        if(nowTime != this.updated_at&&count != 0) {
        	String updateSql = "update message set updated_at = ? where message_id="+ this.message_id;
            try {
                PreparedStatement ps = conn.prepareStatement(updateSql);
                ps.setTimestamp(1, new Timestamp(nowTime.getTime()));
                ps.executeUpdate();
                ps.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
                logger.error("数据库语句检查或执行出错！标记消息 "+this.message_id+" 阅读状态为"+message_readed+"后更改修改时间失败！");
                return false;
            }
        }
        try {
            conn.close();
        } catch (SQLException e1) {
        	logger.error("标记消息 "+this.message_id+" 阅读状态为"+message_readed+"后数据库关闭出错！");
            e1.printStackTrace();
        }
        logger.info("标记消息 "+this.message_id+" 阅读状态为"+message_readed+"成功！");
        return true;
    }
    
    //标记接收者所有消息已经阅读
    public boolean updateMessageAllReaded(int receiver_id) {
    	Connection conn = conn();
    	List<Message> mesList = getMessageInfo();
		for(Message message:mesList) {
			message.updateMessageOfReaded(true);
		}
		try {
			conn.close();
			logger.info("标记接收者 "+receiver_id+" 所有消息为已阅读成功！");
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error("数据库关闭出错！标记接收者 "+receiver_id+" 所有消息为已阅读失败！");
			return false;
		}
    }

    //判断编号是否存在
    public boolean isExist_identifier(String message_identifier) {
    	if(queryMessageByIden(message_identifier).size() != 0)	return true;
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
            ps = conn.prepareStatement("select count(*) from message");
            rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！无条件获取消息数据量失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("无条件获取消息数据量后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return count;
    }
    
    //按条件获取消息数据
    public List<Message> queryByConditionByString(String querySql,String queryStr) {
    	List<Message> mesList = new ArrayList<Message>();
        Message mes = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection conn = null;
        try{
        	conn = conn();
            ps = conn.prepareStatement(querySql);
            rs = ps.executeQuery();
            while(rs.next()) {
            	mes = new Message();
                mes.message_id = rs.getInt("message_id");
                mes.message_identifier = rs.getString("message_identifier");
                mes.message_type = rs.getInt("message_type");
                mes.message_summary = rs.getString("message_summary");
                mes.message_content = rs.getString("message_content");
                mes.message_readed = rs.getBoolean("message_readed");
                mes.message_deleted = rs.getBoolean("message_deleted");
                mes.sender_id = rs.getInt("sender_id");
                mes.receiver_id = rs.getInt("receiver_id");
                mes.created_at = rs.getTimestamp("created_at");
                mes.updated_at = rs.getTimestamp("updated_at");
                mes.deleted_at = rs.getTimestamp("deleted_at");
            	if(queryStr.length()==0) {
            		mesList.add(mes);
            	}
            	else if(mes.message_summary.indexOf(queryStr)!=-1||
            			mes.message_content.indexOf(queryStr)!=-1) {
            		mesList.add(mes);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！按条件获取消息信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("按条件获取消息信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return mesList;
    }
    
    //按条件获取消息数据（是否删除+是否阅读+发送者ID+接收者ID）（boolean型的2表示不考虑该条件）
    public List<Message> queryByCondition(int message_deleted,int message_readed,int sender_id,int receiver_id,String queryStr) {
    	if(message_deleted==2&&message_readed==2&&sender_id==0&&receiver_id==0&&queryStr.length()==0) {
    		return queryByConditionByString("select * from message",queryStr);
    	}else {
    		String querySql = "select * from message where";
    		if(message_deleted!=2)	querySql += " message_deleted = "+message_deleted+" and";
    		if(message_readed!=2)	querySql += " message_readed = "+message_readed+" and";
    		if(sender_id!=0)		querySql += " sender_id = "+sender_id+" and";
    		if(receiver_id!=0)		querySql += " receiver_id = "+receiver_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		return queryByConditionByString(querySql,queryStr);
    	}
    }

    //返回分页数据
    public List<Message> cutPageDataByString(int page,int pageSize,String querySql,String queryStr){
    	List<Message> mesList = new ArrayList<Message>();
        Message mes = null;
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
            	mes = new Message();
                mes.message_id = rs.getInt("message_id");
                mes.message_identifier = rs.getString("message_identifier");
                mes.message_type = rs.getInt("message_type");
                mes.message_summary = rs.getString("message_summary");
                mes.message_content = rs.getString("message_content");
                mes.message_readed = rs.getBoolean("message_readed");
                mes.message_deleted = rs.getBoolean("message_deleted");
                mes.sender_id = rs.getInt("sender_id");
                mes.receiver_id = rs.getInt("receiver_id");
                mes.created_at = rs.getTimestamp("created_at");
                mes.updated_at = rs.getTimestamp("updated_at");
                mes.deleted_at = rs.getTimestamp("deleted_at");
                if(queryStr.length()==0) {
            		mesList.add(mes);
            	}
            	else if(mes.message_summary.indexOf(queryStr)!=-1||
            			mes.message_content.indexOf(queryStr)!=-1) {
            		mesList.add(mes);
            	}
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取消息分页信息失败！");
        }finally{
            try {
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException e1) {
            	logger.error("获取消息分页信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        if(queryStr.length()==0) {
        	return mesList;
        }else {
        	int count = queryByConditionByString(querySql,queryStr).size();
        	int start = page*pageSize-pageSize;
        	int end;
        	if(start == (count/pageSize)*pageSize) {
        		end = start+count%pageSize;
        		return mesList.subList(start, end);
        	}else {
        		end = start+pageSize;
        		return mesList.subList(start, end);
        	}
        }
    }
    
    //返回分页数据（是否删除+是否阅读+发送者ID+接收者ID）（boolean型的2表示不考虑该条件）
    public List<Message> cutPageData(int page,int pageSize,int message_deleted,int message_readed,int sender_id,int receiver_id,String queryStr){
    	if(message_deleted==2&&message_readed==2&&sender_id==0&&receiver_id==0&&queryStr.length()==0) {
    		return cutPageDataByString(page,pageSize,"select * from message limit ?,?",queryStr);
    	}else {
    		String querySql = "select * from message where";
    		if(message_deleted!=2)	querySql += " message_deleted = "+message_deleted+" and";
    		if(message_readed!=2)	querySql += " message_readed = "+message_readed+" and";
    		if(sender_id!=0)		querySql += " sender_id = "+sender_id+" and";
    		if(receiver_id!=0)		querySql += " receiver_id = "+receiver_id+" and";
    		querySql = querySql.substring(0, querySql.length()-3);
    		querySql += "limit ?,?";
    		return cutPageDataByString(page,pageSize,querySql,queryStr);
    	}
    }
    
    //从数据库获取所有消息信息返回消息表
    public List<Message> getMessageInfo() {
        List<Message> mesList = new ArrayList<Message>();
        Message mes = null;
        ResultSet queryRS = null;
        PreparedStatement queryStatement = null;
        Connection queryConn = null;
        try{
            queryConn = conn();
            String sqlQuery = "select * from message";
            queryStatement = queryConn.prepareStatement(sqlQuery);
            queryRS = queryStatement.executeQuery();
            while(queryRS.next()) {
                mes = new Message();
                mes.message_id = queryRS.getInt("message_id");
                mes.message_identifier = queryRS.getString("message_identifier");
                mes.message_type = queryRS.getInt("message_type");
                mes.message_summary = queryRS.getString("message_summary");
                mes.message_content = queryRS.getString("message_content");
                mes.message_readed = queryRS.getBoolean("message_readed");
                mes.message_deleted = queryRS.getBoolean("message_deleted");
                mes.sender_id = queryRS.getInt("sender_id");
                mes.receiver_id = queryRS.getInt("receiver_id");
                mes.created_at = queryRS.getTimestamp("created_at");
                mes.updated_at = queryRS.getTimestamp("updated_at");
                mes.deleted_at = queryRS.getTimestamp("deleted_at");
                mesList.add(mes);
            }
        }catch(Exception e2) {
            e2.printStackTrace();
            logger.error("数据库语句检查或执行出错！获取消息信息失败！");
        }finally{
            try {
                queryRS.close();
                queryStatement.close();
                queryConn.close();
            } catch (SQLException e1) {
            	logger.error("获取消息信息后数据库关闭出错！");
                e1.printStackTrace();
            }
        }
        return mesList;
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