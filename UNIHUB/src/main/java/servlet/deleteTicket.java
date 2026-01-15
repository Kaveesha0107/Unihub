package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Ticket;
import services.TticketService;

@WebServlet("/deleteTicket")
public class deleteTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public deleteTicket() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String idParam = request.getParameter("ticketId");
	    if (idParam != null) {
	        try {
	            int id = Integer.parseInt(idParam);

	            TticketService ts = new TticketService();
	            ts.deleteTicketById(id);

	            // Redirect to avoid form resubmission issues
	            response.sendRedirect("userTicketList");
	            return;

	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	            // Optionally set an error message in session or request
	        }
	    }
	    // If ticketId missing or invalid, just redirect to ticket list
	    response.sendRedirect("userTicketList");
	}


}
