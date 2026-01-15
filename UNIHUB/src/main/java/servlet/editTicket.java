package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Ticket;
import model.university;
import services.TticketService;
import services.universityService;

@WebServlet("/editTicket")
public class editTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public editTicket() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String idParam = request.getParameter("ticketId");
	    if (idParam != null) {
	        int id = Integer.parseInt(idParam);

	        TticketService ts = new TticketService();
	        Ticket ticket = ts.getTicketById(id);
	        universityService us = new universityService();
			List<university> unis = new ArrayList<university>();
			unis = us.getAllUnis();
			
			request.setAttribute("unis", unis);
	        request.setAttribute("ticket", ticket);
	        request.getRequestDispatcher("editTicket.jsp").forward(request, response);
	    } else {
	        response.sendRedirect("userTicketList");
	    }
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Ticket ticket = new Ticket();
		ticket.setTicketId(Integer.parseInt(request.getParameter("ticketId")));
		ticket.setUserId(Integer.parseInt(request.getParameter("userId")));
		ticket.setUniversityId(Integer.parseInt(request.getParameter("universityId")));
        ticket.setSubject(request.getParameter("subject"));
		ticket.setMessage(request.getParameter("message"));
		ticket.setCategory( request.getParameter("category"));
		ticket.setDepartment(request.getParameter("department"));

		TticketService ts = new TticketService();
		ts.updateTicket(ticket);
		
		response.sendRedirect("userTicketList");
	}

}
