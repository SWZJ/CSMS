package fileController;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;


@WebServlet("/servlet/DeleteFileServlet")
public class DeleteFileServlet extends HttpServlet {

	private static final long serialVersionUID = 6938309603829401799L;
	
	private static Logger logger = Logger.getLogger(DeleteFileServlet.class);	//输出日志

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);  
		//获取当前url位置
		String location = request.getParameter("location")==null?"":request.getParameter("location");
		//获取文件夹分支索引
		String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
		//获取索引ID
		int id = request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
        //得到要删除的文件名
        String fileName = request.getParameter("filename");
        //上传的文件都是保存在/WEB-INF/upload目录下的子目录当中
        String fileSaveRootPath=this.getServletContext().getRealPath("/WEB-INF/upload/"+branch+"/"+id);
        String fileSaveRootPathcopy = "E://CSMS-public/upload/"+branch+"/"+id;
        //通过文件名找出文件的所在目录
        String path = findFileSavePathByFileName(fileName,fileSaveRootPath);
        String pathcopy = findFileSavePathByFileName(fileName,fileSaveRootPathcopy);
        //得到要删除的文件
        File file = new File(path + "\\" + fileName);
        File filecopy = new File(pathcopy + "\\" + fileName);
        //处理文件名
        String realname = fileName.substring(fileName.indexOf("_")+1);
        //如果文件不存在
        if(!file.exists()){
        	logger.warn("文件 "+realname+" 资源未找到或已被删除。");
            session.setAttribute("message", "操作失败！文件 "+realname+" 资源未找到或已被删除！！");
            if(location.equals("teacherReportOfStudent")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/studentTopic/teacherReportOfStudent.jsp\";</script>");
            }else if(location.equals("studentMyReport")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/student/designStep/studentMyReport.jsp\";</script>");
            }else if(location.equals("teacherCDTopicDetail")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/myTopic/teacherCDTopicDetail.jsp?id="+id+"\";</script>");
            }else if(location.equals("topicDetail")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/admin/audit/topicDetail.jsp?id="+id+"\";</script>");
            }else if(location.equals("cdtopicDetail")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicDetail.jsp?id="+id+"\";</script>");
            }
            return;
        }
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
            	logger.info("文件 "+realname+" 删除成功！");
            	session.setAttribute("message", "报告 "+realname+" 删除成功！");
            } else {
            	logger.warn("文件 "+realname+" 删除失败！");
            	session.setAttribute("message", "遇到未知原因，报告 "+realname+" 删除失败！");
            }
            if(location.equals("teacherReportOfStudent")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/studentTopic/teacherReportOfStudent.jsp\";</script>");
            }else if(location.equals("studentMyReport")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/student/designStep/studentMyReport.jsp\";</script>");
            }else if(location.equals("teacherCDTopicDetail")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/myTopic/teacherCDTopicDetail.jsp?id="+id+"\";</script>");
            }else if(location.equals("topicDetail")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/admin/audit/topicDetail.jsp?id="+id+"\";</script>");
            }else if(location.equals("cdtopicDetail")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicDetail.jsp?id="+id+"\";</script>");
            }
        }
        if(filecopy.exists() && filecopy.isFile()) {
        	filecopy.delete();
        }
        //清理空文件夹
        clear(new File(fileSaveRootPathcopy));
        clear(new File(fileSaveRootPath));
    }
    

    public String findFileSavePathByFileName(String filename,String saveRootPath){
        int hashcode = filename.hashCode();
        int dir1 = hashcode&0xf;  //0--15
        int dir2 = (hashcode&0xf0)>>4;  //0-15
        String dir = saveRootPath + "\\" + dir1 + "\\" + dir2;  //upload\2\3  upload\3\5
        /*File file = new File(dir);
        if(!file.exists()){
            //创建目录
            file.mkdirs();
        }*/
        return dir;
    }
    
    //清理空文件夹
	public static void clear(File dir){
        File[] dirs = dir.listFiles();
        for(int i = 0; i < dirs.length; i++){
            if(dirs[i].isDirectory() ){
                clear(dirs[i]);
            }
        }
        if(dir.isDirectory() && dir.delete())
        	logger.info("空文件夹 "+dir+" 清理成功");
    }
	
	/** 
	 *  根据路径删除指定的目录或文件，无论存在与否 
	 *@param sPath  要删除的目录或文件 
	 *@return 删除成功返回 true，否则返回 false。 
	 */  
	public boolean DeleteFolder(String sPath) {  
	    boolean flag = false;  
	    File file = new File(sPath);  
	    // 判断目录或文件是否存在  
	    if (!file.exists()) {  // 不存在返回 false  
	        return flag;  
	    } else {  
	        // 判断是否为文件  
	        if (file.isFile()) {  // 为文件时调用删除文件方法  
	            return deleteFile(sPath);  
	        } else {  // 为目录时调用删除目录方法  
	            return deleteDirectory(sPath);  
	        }  
	    }  
	}
	
	/** 
	 * 删除单个文件 
	 * @param   sPath    被删除文件的文件名 
	 * @return 单个文件删除成功返回true，否则返回false 
	 */  
	public boolean deleteFile(String sPath) {  
	    boolean flag = false;  
	    File file = new File(sPath);  
	    // 路径为文件且不为空则进行删除  
	    if (file.isFile() && file.exists()) {  
	        file.delete();  
	        flag = true;  
	    }  
	    return flag;  
	}
	
	/** 
	 * 删除目录（文件夹）以及目录下的文件 
	 * @param   sPath 被删除目录的文件路径 
	 * @return  目录删除成功返回true，否则返回false 
	 */  
	public boolean deleteDirectory(String sPath) {  
	    //如果sPath不以文件分隔符结尾，自动添加文件分隔符  
	    if (!sPath.endsWith(File.separator)) {  
	        sPath = sPath + File.separator;  
	    }  
	    File dirFile = new File(sPath);  
	    //如果dir对应的文件不存在，或者不是一个目录，则退出  
	    if (!dirFile.exists() || !dirFile.isDirectory()) {  
	        return false;  
	    }  
	    boolean flag = true;  
	    //删除文件夹下的所有文件(包括子目录)  
	    File[] files = dirFile.listFiles();  
	    for (int i = 0; i < files.length; i++) {  
	        //删除子文件  
	        if (files[i].isFile()) {  
	            flag = deleteFile(files[i].getAbsolutePath());  
	            if (!flag) break;  
	        } //删除子目录  
	        else {  
	            flag = deleteDirectory(files[i].getAbsolutePath());  
	            if (!flag) break;  
	        }  
	    }  
	    if (!flag) return false;  
	    //删除当前目录  
	    if (dirFile.delete()) {  
	    	logger.info("目录 "+sPath+" 删除成功");
	        return true;  
	    } else {  
	    	logger.info("目录 "+sPath+" 删除失败");
	        return false;  
	    }
	}
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
