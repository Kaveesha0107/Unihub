package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.TticketService;
import services.UserService;
import services.articleService;
import services.reviewService;
import services.universityService;

@WebServlet("/adminDash")
public class adminDash extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public adminDash() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService us = new UserService();
		int userCount = us.userCount();
		
		universityService unis = new universityService();
		int uniCount = unis.uniCount();
		
		reviewService rs = new reviewService();
		int reviewCount = rs.countReviews();
		
		articleService as = new articleService();
		int articleCount = as.getArticleCount();
		
		TticketService ts = new TticketService();
		int openTicketCount = ts.countOpenTickets();
		int inProgressTicketCount = ts.countInProgressTickets();
		int resolvedTicketCount = ts.countResolvedTickets();
		
		request.setAttribute("openTicketCount", openTicketCount);
		request.setAttribute("inProgressTicketCount", inProgressTicketCount);
		request.setAttribute("resolvedTicketCount", resolvedTicketCount);
		request.setAttribute("userCount", userCount);
		request.setAttribute("uniCount", uniCount);
		request.setAttribute("reviewCount", reviewCount);
		request.setAttribute("articleCount", articleCount);
		request.getRequestDispatcher("adminDash.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
