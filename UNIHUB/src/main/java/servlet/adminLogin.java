package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.admin;
import services.adminService;

@WebServlet("/adminLogin")
public class adminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public adminLogin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		admin admin = new admin();
		admin.setEmail(request.getParameter("email"));
		admin.setPassword(request.getParameter("password"));
		
		adminService as = new adminService();
		boolean status = as.validate(admin);
		
		if(status) {
			admin loggedAdmin = as.getAdminByEmail(admin);
			
			HttpSession session = request.getSession();
			session.setAttribute("name", loggedAdmin.getFullName());
			session.setAttribute("role", "admin");
			session.setAttribute("adminId", loggedAdmin.getAdminId());
			session.setAttribute("email", loggedAdmin.getEmail());
			
			response.sendRedirect("adminDash");
		} else {
			RequestDispatcher dispatcher=request.getRequestDispatcher("adminLogin.jsp");
			dispatcher.forward(request, response);
		}
	}

}
