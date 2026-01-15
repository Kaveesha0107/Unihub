package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.university;
import model.universityAgent;
import services.agentService;
import services.universityService;

@WebServlet("/addAgent")
public class addAgent extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public addAgent() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		university uni = new university();
		universityAgent agent = new universityAgent();
		
		uni.setName(request.getParameter("universityName"));
		uni.setLocation(request.getParameter("universityAddress"));
		
		agent.setFirstName(request.getParameter("fname"));
		agent.setLastName(request.getParameter("lname"));
		agent.setEmail(request.getParameter("agentEmail"));
		agent.setPassword(request.getParameter("password"));
		agent.setPhone(request.getParameter("agentPhone"));
		
		universityService us = new universityService();
		us.addUni(uni);
		
		university addeduni = new university();
		addeduni = us.uniByName(uni.getName());
		
		agent.setUniversityId(addeduni.getUniversityId());
		
		agentService agentS = new agentService();
		agentS.addAgent(agent);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("adminDash.jsp");
        dispatcher.forward(request, response);
	}

}
