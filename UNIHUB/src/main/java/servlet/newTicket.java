package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Ticket;
import model.university;
import services.TticketService;
import services.universityService;

@WebServlet("/newTicket")
public class newTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public newTicket() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		universityService us = new universityService();
		List<university> unis = new ArrayList<university>();
		unis = us.getAllUnis();
		
		request.setAttribute("unis", unis);
		RequestDispatcher dispatcher=request.getRequestDispatcher("newTicket.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Ticket ticket = new Ticket();
		ticket.setUserId(Integer.parseInt(request.getParameter("userId")));
		ticket.setUniversityId(Integer.parseInt(request.getParameter("university")));
        ticket.setSubject(request.getParameter("subject"));
		ticket.setMessage(request.getParameter("description"));
		ticket.setCategory( request.getParameter("category"));
		ticket.setDepartment(request.getParameter("department"));

		TticketService ts = new TticketService();
		ts.addTicket(ticket);
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("userDash.jsp");
		dispatcher.forward(request, response);
		
	}

}
