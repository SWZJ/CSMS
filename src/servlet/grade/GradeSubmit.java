package servlet.grade;

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

import JZW.Grade;



@WebServlet("/grade/GradeSubmit")
public class GradeSubmit extends HttpServlet {

	private static final long serialVersionUID = -9013342246731046934L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String grade_identifier = request.getParameter("grade_identifier");
		double grade_value = Double.valueOf(request.getParameter("grade_value"));
		String grade_content = request.getParameter("grade_content");
		int grade_user = Integer.valueOf(request.getParameter("grade_user"));
		int grade_type = Integer.valueOf(request.getParameter("grade_type"));
		int foreign_id = Integer.valueOf(request.getParameter("foreign_id"));

		Grade gra = new Grade();
		boolean isOK = gra.CreateGrade(grade_identifier, grade_value, grade_content, grade_user, grade_type, foreign_id);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isOK", isOK);
		map.put("errorMes","遇到未知问题，评分失败！");
		map.put("successMes","评分成功！");
		
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