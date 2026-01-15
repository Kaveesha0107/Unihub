package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Review;
import services.reviewService;

@WebServlet("/allReviews")
public class allReviews extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public allReviews() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reviewService rs = new reviewService();
		int reviewCount = rs.countReviews();
		
		List<Review> reviewList = rs.getAllReviews();
		
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("reviewCount", reviewCount);
		request.getRequestDispatcher("viewAllRewiews.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
