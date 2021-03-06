package servlet.manageInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import JZW.Student;


@WebServlet("/manageInfo/StudentIsNumExist")
public class StudentIsNumExist extends HttpServlet {

	private static final long serialVersionUID = -3717182250087350119L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String student_number = request.getParameter("student_number");
		Student stu = new Student();
		boolean isExist = stu.isExist_number(student_number);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isExist", isExist);
		map.put("errorMes","该学号 "+student_number+" 已经存在！");
		
		Gson gson = new Gson();
		String json = gson.toJson(map);
		response.setCharacterEncoding("UTF-8");  
		PrintWriter writer = response.getWriter();
		writer.println(json);
		writer.flush();
		writer.close();
	}
 
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}