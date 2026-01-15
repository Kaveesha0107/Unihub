package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.university;
import model.universityAgent;
import services.agentService;
import services.universityService;

@WebServlet("/agentLogin")
public class agentLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public agentLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		universityAgent agent = new universityAgent();
		agent.setEmail(request.getParameter("email"));
		agent.setPassword(request.getParameter("password"));

		agentService agentS = new agentService();
		boolean status = agentS.validate(agent);

		if (status) {
			universityAgent loggedAgent = agentS.getOne(agent);
			universityService us = new universityService();
			university uni = us.getUniById(loggedAgent.getUniversityId());
			
			HttpSession session = request.getSession();
			session.setAttribute("agentId", loggedAgent.getAgentId());
			session.setAttribute("fname", loggedAgent.getFirstName());
			session.setAttribute("lname", loggedAgent.getLastName());
			session.setAttribute("email", loggedAgent.getEmail());
			session.setAttribute("uniId", loggedAgent.getUniversityId());
			session.setAttribute("phone", loggedAgent.getPhone());
			
			if(loggedAgent.getProfilePhoto() != null) {
				loggedAgent.getBase64Image();
				session.setAttribute("profiliPhoto", loggedAgent.getProfilePhoto());
			}
			
			session.setAttribute("uniName", uni.getName());
			session.setAttribute("role", "agent");
			RequestDispatcher dispatcher=request.getRequestDispatcher("agentDash.jsp");
			dispatcher.forward(request, response);
		} else {
			request.setAttribute("errorMessage", "Invalid email or password.");
			request.getRequestDispatcher("agentlogin.jsp").forward(request, response);
		}
	}
}
