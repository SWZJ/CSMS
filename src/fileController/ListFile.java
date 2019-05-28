package fileController;
 
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
* @ClassName: ListFileServlet
* @Description: 列出所有下载文件
*
*/ 
@WebServlet("/servlet/ListFile")
public class ListFile extends HttpServlet {

	private static final long serialVersionUID = -1331776217653061493L;
	
	public Map<String,String> getFileMap(HttpServletRequest request, HttpServletResponse response,String branch,int id,String queryStr){
        //获取上传文件的目录
		String path = request.getSession().getServletContext().getRealPath("/");
		String uploadFilePath = path+"/WEB-INF/upload/"+branch;
        /*String uploadFilePath = this.getServletContext().getRealPath("/WEB-INF/upload/"+branch);*/
        if(id != 0)	uploadFilePath+="/"+id;
        File file = new File(uploadFilePath);
        //如果目录不存在
        if(!file.exists()){
            //创建目录
            file.mkdirs();
        }
        //存储要下载的文件名
        Map<String,String> fileNameMap = new HashMap<String,String>();
        //递归遍历filepath目录下的所有文件和目录，将文件的文件名存储到map集合中
        listfile(new File(uploadFilePath),fileNameMap,queryStr);//File既可以代表一个文件也可以代表一个目录
        //将Map集合发送到listfile.jsp页面进行显示
        return fileNameMap;
	}

    public void listfile(File file,Map<String,String> map,String queryStr){
        //如果file代表的不是一个文件，而是一个目录
        if(!file.isFile()){
            //列出该目录下的所有文件和目录
            File files[] = file.listFiles();
            //遍历files[]数组
            for(File f : files){
                //递归
                listfile(f,map,queryStr);
            }
        }else{
			/*处理文件名，上传后的文件是以uuid_文件名的形式去重新命名的，去除文件名的uuid_部分
			file.getName().indexOf("_")检索字符串中第一次出现"_"字符的位置，如果文件名类似于：9349249849-88343-8344_阿_凡_达.avi
			那么file.getName().substring(file.getName().indexOf("_")+1)处理之后就可以得到阿_凡_达.avi部分*/
            String realName = file.getName().substring(file.getName().indexOf("_")+1);
            //file.getName()得到的是文件的原始名称，这个名称是唯一的，因此可以作为key，realName是处理过后的名称，有可能会重复
            if(queryStr.equals("")==true) {
            	map.put(file.getName(), realName);
            }else {
            	if(realName.indexOf(queryStr)!=-1) {
            		map.put(file.getName(), realName);
            	}
            }
        }
    }
 
}
