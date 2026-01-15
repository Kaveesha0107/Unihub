package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.user;
import services.UserService;
import services.universityService;

@WebServlet("/accountSettings")
public class accountSettings extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public accountSettings() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userID");
        
		UserService us = new UserService();
		user user = us.getUserById(userId);
		user.getBase64Image();
		
        request.setAttribute("user", user);
        request.getRequestDispatcher("accountSettings.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
