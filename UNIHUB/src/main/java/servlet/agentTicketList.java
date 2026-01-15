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
import javax.servlet.http.HttpSession;

import model.Ticket;
import services.TticketService;

@WebServlet("/agentTicketList")
public class agentTicketList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public agentTicketList() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		int uniId = (int)session.getAttribute("uniId");
		List<Ticket> tl = new ArrayList<Ticket>();
		TticketService ts = new TticketService();
		tl = ts.getTicketsForAgent(uniId);
		request.setAttribute("ticketList", tl);
		RequestDispatcher dispatcher=request.getRequestDispatcher("agentTicketManagement.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
