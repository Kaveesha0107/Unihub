package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Review;
import utils.dbConnect;

public class reviewService {
	public void addReview(Review review) {
	    String sql = "INSERT INTO reviews(user_id, review_type, website_aspect, uni_id, title, content, rating) VALUES (?, ?, ?, ?, ?, ?, ?)";

	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, review.getUserId());
	        ps.setString(2, review.getReviewType());

	        // websiteAspect can be null if reviewType is 'agent'
	        if ("website".equalsIgnoreCase(review.getReviewType())) {
	            ps.setString(3, review.getWebsiteAspect());
	        } else {
	            ps.setNull(3, java.sql.Types.VARCHAR);
	        }

	        // uniId can be null if reviewType is 'website'
	        if ("agent".equalsIgnoreCase(review.getReviewType()) && review.getUniId() != null) {
	            ps.setInt(4, review.getUniId());
	        } else {
	            ps.setNull(4, java.sql.Types.INTEGER);
	        }

	        ps.setString(5, review.getTitle());
	        ps.setString(6, review.getContent());
	        ps.setInt(7, review.getRating());

	        ps.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();

	    } catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
	}
	
	public List<Review> getReviewsByUserId(int userId) {
	    List<Review> reviews = new ArrayList<>();
	    String sql = "SELECT * FROM reviews WHERE user_id = ? ORDER BY created_at DESC";

	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, userId);

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Review review = new Review();
	                review.setReviewId(rs.getInt("review_id"));
	                review.setUserId(rs.getInt("user_id"));
	                review.setReviewType(rs.getString("review_type"));

	                String websiteAspect = rs.getString("website_aspect");
	                if (rs.wasNull()) {
	                    review.setWebsiteAspect(null);
	                } else {
	                    review.setWebsiteAspect(websiteAspect);
	                }

	                int uniId = rs.getInt("uni_id");
	                if (rs.wasNull()) {
	                    review.setUniId(null);
	                } else {
	                    review.setUniId(uniId);
	                }

	                review.setTitle(rs.getString("title"));
	                review.setContent(rs.getString("content"));
	                review.setRating(rs.getInt("rating"));
	                review.setCreatedAt(rs.getTimestamp("created_at"));

	                reviews.add(review);
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return reviews;
	}
	
	public Review getReviewById(int id) {
	    String sql = "SELECT * FROM reviews WHERE review_id = ?";
	    Review review = null;

	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, id);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                review = new Review();
	                review.setReviewId(rs.getInt("review_id"));
	                review.setUserId(rs.getInt("user_id"));
	                review.setReviewType(rs.getString("review_type"));

	                String websiteAspect = rs.getString("website_aspect");
	                if (rs.wasNull()) {
	                    review.setWebsiteAspect(null);
	                } else {
	                    review.setWebsiteAspect(websiteAspect);
	                }

	                int uniId = rs.getInt("uni_id");
	                if (rs.wasNull()) {
	                    review.setUniId(null);
	                } else {
	                    review.setUniId(uniId);
	                }

	                review.setTitle(rs.getString("title"));
	                review.setContent(rs.getString("content"));
	                review.setRating(rs.getInt("rating"));
	                review.setCreatedAt(rs.getTimestamp("created_at"));
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        // You can handle or rethrow this exception as needed
	    }

	    return review;
	}
	
	public void updateReview(Review review) {
	    String sql = "UPDATE reviews SET review_type = ?, website_aspect = ?, uni_id = ?, title = ?, content = ?, rating = ? WHERE review_id = ?";

	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, review.getReviewType());

	        if ("website".equalsIgnoreCase(review.getReviewType())) {
	            ps.setString(2, review.getWebsiteAspect());
	            ps.setNull(3, java.sql.Types.INTEGER);
	        } else if ("agent".equalsIgnoreCase(review.getReviewType())) {
	            ps.setNull(2, java.sql.Types.VARCHAR);
	            if (review.getUniId() != null) {
	                ps.setInt(3, review.getUniId());
	            } else {
	                ps.setNull(3, java.sql.Types.INTEGER);
	            }
	        } else {
	            ps.setNull(2, java.sql.Types.VARCHAR);
	            ps.setNull(3, java.sql.Types.INTEGER);
	        }

	        ps.setString(4, review.getTitle());
	        ps.setString(5, review.getContent());
	        ps.setInt(6, review.getRating());
	        ps.setInt(7, review.getReviewId());

	        int rowsUpdated = ps.executeUpdate();

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public boolean deleteReview(int reviewId) {
	    String sql = "DELETE FROM reviews WHERE review_id = ?";
	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, reviewId);
	        int rows = ps.executeUpdate();
	        return rows > 0;
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public int countReviews() {
	    String sql = "SELECT COUNT(review_id) AS total FROM reviews";
	    int count = 0;

	    try (Connection conn = dbConnect.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        if (rs.next()) {
	            count = rs.getInt("total");
	        }

	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return count;
	}

	public List<Review> getAllReviews() {
	    List<Review> reviews = new ArrayList<>();
	    String sql = "SELECT * FROM reviews ORDER BY created_at DESC";

	    try (Connection con = dbConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Review review = new Review(); 
	                review.setReviewId(rs.getInt("review_id"));
	                review.setUserId(rs.getInt("user_id"));
	                review.setReviewType(rs.getString("review_type"));

	                String websiteAspect = rs.getString("website_aspect");
	                if (rs.wasNull()) {
	                    review.setWebsiteAspect(null);
	                } else {
	                    review.setWebsiteAspect(websiteAspect);
	                }

	                int uniId = rs.getInt("uni_id");
	                if (rs.wasNull()) {
	                    review.setUniId(null);
	                } else {
	                    review.setUniId(uniId);
	                }

	                review.setTitle(rs.getString("title"));
	                review.setContent(rs.getString("content"));
	                review.setRating(rs.getInt("rating"));
	                review.setCreatedAt(rs.getTimestamp("created_at"));

	                reviews.add(review);
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    return reviews;
	}

}
