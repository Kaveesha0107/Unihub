package model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int userId;          
    private String reviewType;  
    private String websiteAspect; // if reviewType == "website", e.g. "UI", "Performance"
    private Integer uniId;        // if reviewType == "agent", the university agent's ID
    private String title;
    private String content;
    private int rating;           // 1 to 5 stars
    private Timestamp createdAt;

    // Constructors
    public Review() {}

    // Getters and Setters

    public int getReviewId() {
        return reviewId;
    }
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getReviewType() {
        return reviewType;
    }
    public void setReviewType(String reviewType) {
        this.reviewType = reviewType;
    }

    public String getWebsiteAspect() {
        return websiteAspect;
    }
    public void setWebsiteAspect(String websiteAspect) {
        this.websiteAspect = websiteAspect;
    }

    public Integer getUniId() {
        return uniId;
    }
    public void setUniId(Integer uniId) {
        this.uniId = uniId;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

}
