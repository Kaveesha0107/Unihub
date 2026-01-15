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

@WebServlet("/userTicketList")
public class userTicketList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public userTicketList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
		Integer userID = (Integer) session.getAttribute("userID");
		
		TticketService ts = new TticketService();
		List<Ticket> ticketList = new ArrayList<Ticket>();
		ticketList = ts.getAllTicketsByUserId(userID);
		
		request.setAttribute("ticketList", ticketList);
		RequestDispatcher dispatcher=request.getRequestDispatcher("userTicketList.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
