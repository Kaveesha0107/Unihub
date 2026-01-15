package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.user;
import services.UserService;

@WebServlet("/userManagementDash")
public class userManagementDash extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public userManagementDash() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserService us = new UserService();
		List<user> userList = us.getAllUsers();
		
		int userCount = us.userCount();
		request.setAttribute("userList", userList);
		request.setAttribute("userCount", userCount);
		request.getRequestDispatcher("userManagementDash.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
