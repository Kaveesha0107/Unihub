package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.TticketService;

@WebServlet("/markResolved")
public class markResolved extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public markResolved() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ticketIdParam = request.getParameter("ticketId");

        if (ticketIdParam == null) {
            response.sendRedirect("agentTickets");
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdParam);

            TticketService ticketService = new TticketService();
            ticketService.changeTicketStatusToResolved(ticketId);


        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect("agentDash.jsp");
    }

}
