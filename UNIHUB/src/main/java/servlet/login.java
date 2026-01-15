package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.user;
import services.UserService;

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//create customer obj
				user user=new user();
				user.setEmail(request.getParameter("email"));
				user.setPassword(request.getParameter("password"));
				
				UserService service= new UserService();
				boolean status=service.validate(user);
				
				if(status) {
					user loggeduser=service.getOne(user);
					
					if(loggeduser.getProfileImage() != null) {
						loggeduser.getBase64Image();
					}
					
					
					HttpSession session = request.getSession();
					session.setAttribute("userID", loggeduser.getUserId());
					session.setAttribute("username", loggeduser.getFirstname());
					session.setAttribute("email", loggeduser.getEmail());
					session.setAttribute("role", "user");
					
					RequestDispatcher dispatcher=request.getRequestDispatcher("userDash.jsp");
					dispatcher.forward(request, response);
					
				}else{
					RequestDispatcher dispatcher=request.getRequestDispatcher("login.jsp");
					dispatcher.forward(request, response);
				}
				
	}

}
