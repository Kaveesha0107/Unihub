package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.ResponseService;
import services.TticketService;

@WebServlet("/deleteResponse")
public class deleteResponse extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public deleteResponse() {
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
            
            ResponseService rs = new ResponseService();
            rs.deleteResponseByTicketId(ticketId);
            
            TticketService ts = new TticketService();
            ts.changeTicketStatusToOpens(ticketId);

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Invalid ticket ID.");
        }

        response.sendRedirect("agentDash.jsp");
    
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String responseIdParam = request.getParameter("responseId");
		String ticketIdParam = request.getParameter("ticketId");

        if (responseIdParam == null || responseIdParam.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Invalid response ID.");
            response.sendRedirect("agentTickets"); // Or wherever you want to redirect
            return;
        }

        try {
            int responseId = Integer.parseInt(responseIdParam);
            int ticketId = Integer.parseInt(ticketIdParam);
            ResponseService responseService = new ResponseService();
            responseService.deleteResponseByResponseId(responseId);

            TticketService ts = new TticketService();
            ts.changeTicketStatusToOpens(ticketId);
           

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Invalid response ID format.");
        }

        response.sendRedirect("agentDash.jsp");
	}

}
