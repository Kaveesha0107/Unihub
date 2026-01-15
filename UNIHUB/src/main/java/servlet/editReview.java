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

@WebServlet("/editReview")
public class editReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public editReview() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reviewIdParam = request.getParameter("reviewId");
        if (reviewIdParam == null || reviewIdParam.trim().isEmpty()) {
            response.sendRedirect("readReviews"); // or error page
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdParam);
            reviewService reviewService = new reviewService();
            Review review = reviewService.getReviewById(reviewId);

            if (review == null) {
                response.sendRedirect("readReviews");
                return;
            }
            universityService us = new universityService();
    		List<university> unis = new ArrayList<university>();
    		unis = us.getAllUnis();
    		
    		request.setAttribute("unis", unis);
            request.setAttribute("review", review);
            request.getRequestDispatcher("editReview.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("readReviews");
        }
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
        String reviewIdStr = request.getParameter("reviewId");
        String reviewType = request.getParameter("reviewType");
        String websiteAspect = request.getParameter("websiteAspect");
        String uniIdStr = request.getParameter("uniId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String ratingStr = request.getParameter("rating");

        // Basic validation
        if (reviewIdStr == null || reviewIdStr.trim().isEmpty() ||
            reviewType == null || title == null || content == null || ratingStr == null ||
            title.trim().isEmpty() || content.trim().isEmpty() || ratingStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("editReview.jsp").forward(request, response);
            return;
        }

        int reviewId;
        int rating;
        try {
            reviewId = Integer.parseInt(reviewIdStr);
            rating = Integer.parseInt(ratingStr);
            if (rating < 1 || rating > 5) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid review ID or rating.");
            request.getRequestDispatcher("editReview.jsp").forward(request, response);
            return;
        }

        Integer uniId = null;
        if ("agent".equalsIgnoreCase(reviewType)) {
            if (uniIdStr == null || uniIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please select a university agent.");
                request.getRequestDispatcher("editReview.jsp").forward(request, response);
                return;
            }
            try {
                uniId = Integer.parseInt(uniIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid university agent selected.");
                request.getRequestDispatcher("editReview.jsp").forward(request, response);
                return;
            }
        }

        // Create Review object with updated data
        Review review = new Review();
        review.setReviewId(reviewId);
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

        // Update review via service
        reviewService reviewService = new reviewService();
        reviewService.updateReview(review);
        
        response.sendRedirect("readReviews?message=Review updated successfully");

	}

}
