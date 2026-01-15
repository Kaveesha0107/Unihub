package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.user;
import services.UserService;

@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddUser() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		user users = new user();
        users.setFirstname(request.getParameter("firstname"));
        users.setLastname(request.getParameter("lastname"));
        users.setPhone(request.getParameter("phone"));
        users.setEmail(request.getParameter("email"));
        users.setPassword(request.getParameter("password"));

        UserService service = new UserService();
        service.regUser(users);

        // Store user in session
        request.getSession().setAttribute("currentUser", users);

        // Forward to profile page
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
	}

}
