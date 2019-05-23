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
        //得到要下载的文件名
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
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/createTopic/teacherReportOfStudent.jsp\";</script>");
            }else if(location.equals("studentMyReport")==true) {
            	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/student/designStep/studentMyReport.jsp\";</script>");
            }
            /*response.getWriter().write("<script> history.go(-1) </script>");*/
            return;
        }
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
            	logger.info("文件 "+realname+" 删除成功！");
            	session.setAttribute("message", "课题报告 "+realname+" 删除成功！");
                if(location.equals("teacherReportOfStudent")==true) {
                	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/createTopic/teacherReportOfStudent.jsp\";</script>");
                }else if(location.equals("studentMyReport")==true) {
                	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/student/designStep/studentMyReport.jsp\";</script>");
                }
            } else {
            	logger.warn("文件 "+realname+" 删除失败！");
            	session.setAttribute("message", "遇到未知原因，课题报告 "+realname+" 删除失败！");
                if(location.equals("teacherReportOfStudent")==true) {
                	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/teacher/createTopic/teacherReportOfStudent.jsp\";</script>");
                }else if(location.equals("studentMyReport")==true) {
                	response.getWriter().println("<script>window.location.href = \"/CSMS/SWZJ/student/designStep/studentMyReport.jsp\";</script>");
                }
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
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
