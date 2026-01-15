package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Review;
import model.university;
import services.reviewService;
import services.universityService;

@WebServlet("/readReviews")
public class readReviews extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public readReviews() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get logged-in user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            // Not logged in - redirect or show error
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userID");

        // Fetch reviews by user ID
        reviewService reviewService = new reviewService();
        List<Review> userReviews = reviewService.getReviewsByUserId(userId);
        
        universityService us = new universityService();
		List<university> unis = new ArrayList<university>();
		unis = us.getAllUnis();
		
		request.setAttribute("unis", unis);
        request.setAttribute("userReviews", userReviews);
        request.getRequestDispatcher("readReviews.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
