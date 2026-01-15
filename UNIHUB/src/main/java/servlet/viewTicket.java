package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Article;
import model.Response;
import model.Ticket;
import services.ResponseService;
import services.TticketService;
import services.articleService;

@WebServlet("/viewTicket")
public class viewTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public viewTicket() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String ticketIdParam = request.getParameter("ticketId");

        if (ticketIdParam == null) {
            response.sendRedirect("agentTickets");
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdParam);

            TticketService ticketService = new TticketService();
            Ticket ticket = ticketService.getTicketById(ticketId);

            if (ticket == null) {
                request.setAttribute("errorMessage", "Ticket not found.");
                request.getRequestDispatcher("agentTicketList").forward(request, response);
                return;
            }

            ResponseService responseService = new ResponseService();
            Response resp = responseService.getResponseById(ticketId); 
            
            request.setAttribute("ticket", ticket);
            request.setAttribute("response", resp);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewTicket.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("agentTicketList");
        }

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
