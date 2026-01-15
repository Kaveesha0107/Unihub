package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateArticle")
public class updateArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public updateArticle() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idParam = request.getParameter("id");
	    if (idParam == null || idParam.isEmpty()) {
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing article id");
	        return;
	    }

	    int id;
	    try {
	        id = Integer.parseInt(idParam);
	    } catch (NumberFormatException e) {
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid article id");
	        return;
	    }

	    String title = request.getParameter("title");
	    String summary = request.getParameter("summary"); // or "summery" if your field is named that
	    String content = request.getParameter("content");

	    System.out.println(title);
	    System.out.println(summary);
	    System.out.println(content);
		doGet(request, response);
	}

}
