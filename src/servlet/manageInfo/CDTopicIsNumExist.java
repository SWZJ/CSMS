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

import JZW.CDTopic;



@WebServlet("/manageInfo/CDTopicIsNumExist")
public class CDTopicIsNumExist extends HttpServlet {

	private static final long serialVersionUID = -3717182250087350119L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cdtopic_number = request.getParameter("cdtopic_number");
		CDTopic cdt = new CDTopic();
		boolean isExist = cdt.isExist_number(cdtopic_number);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isExist", isExist);
		map.put("errorMes","课题编号 "+cdtopic_number+" 已经存在！");
		
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