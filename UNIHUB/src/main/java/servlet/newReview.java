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

import model.Review;
import model.university;
import services.reviewService;
import services.universityService;

@WebServlet("/newReview")
public class newReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public newReview() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		universityService us = new universityService();
		List<university> unis = new ArrayList<university>();
		unis = us.getAllUnis();
		
		request.setAttribute("unis", unis);
		RequestDispatcher dispatcher=request.getRequestDispatcher("newReview.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get logged-in user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userID");

        // Get form parameters
        String reviewType = request.getParameter("reviewType");
        String websiteAspect = request.getParameter("websiteAspect");
        String uniIdStr = request.getParameter("uniId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String ratingStr = request.getParameter("rating");

        // Basic validation (you can enhance this)
        if (reviewType == null || title == null || content == null || ratingStr == null ||
            title.trim().isEmpty() || content.trim().isEmpty() || ratingStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("newReview.jsp").forward(request, response);
            return;
        }

        int rating;
        try {
            rating = Integer.parseInt(ratingStr);
            if (rating < 1 || rating > 5) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Rating must be between 1 and 5.");
            request.getRequestDispatcher("reviewForm.jsp").forward(request, response);
            return;
        }

        Integer uniId = null;
        if ("agent".equalsIgnoreCase(reviewType)) {
            if (uniIdStr == null || uniIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please select a university agent.");
                request.getRequestDispatcher("reviewForm.jsp").forward(request, response);
                return;
            }
            try {
                uniId = Integer.parseInt(uniIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid university agent selected.");
                request.getRequestDispatcher("reviewForm.jsp").forward(request, response);
                return;
            }
        }

        // Create Review object
        Review review = new Review();
        review.setUserId(userId);
        review.setReviewType(reviewType);
        review.setTitle(title.trim());
        review.setContent(content.trim());
        review.setRating(rating);

        if ("website".equalsIgnoreCase(reviewType)) {
            review.setWebsiteAspect(websiteAspect);
            review.setUniId(null);
        } else if ("agent".equalsIgnoreCase(reviewType)) {
            review.setUniId(uniId);
            review.setWebsiteAspect(null);
        }

        // Save review via service
        reviewService reviewService = new reviewService();
        reviewService.addReview(review);
        
        RequestDispatcher dispatcher=request.getRequestDispatcher("userDash.jsp");
		dispatcher.forward(request, response);
        
    }
	

}
