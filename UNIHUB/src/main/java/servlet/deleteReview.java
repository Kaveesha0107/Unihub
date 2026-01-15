package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import services.reviewService;

@WebServlet("/deleteReview")
public class deleteReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public deleteReview() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get logged-in user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userID");

        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null || reviewIdStr.trim().isEmpty()) {
            response.sendRedirect("readReviews?error=Invalid review ID");
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdStr);

            reviewService reviewService = new reviewService();

            boolean deleted = reviewService.deleteReview(reviewId);

            if (deleted) {
                response.sendRedirect("readReviews?message=Review deleted successfully");
            } else {
                response.sendRedirect("readReviews?error=Failed to delete review");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("readReviews?error=Invalid review ID");
        }
	}

}
