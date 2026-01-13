package model;

import java.sql.Date;
import java.util.Base64;

public class Article {
	private int id;
	private String title;
	private String content;
	private String summery;
	private byte[] image;
	private Date postedDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getSummery() {
		return summery;
	}

	public void setSummery(String summery) {
		this.summery = summery;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	public Date getPostedDate() {
		return postedDate;
	}

	public void setPostedDate(Date postedDate) {
		this.postedDate = postedDate;
	}

	public String getBase64Image() {
	    if (this.image == null || this.image.length == 0) {
	        return ""; 
	    }
	    return Base64.getEncoder().encodeToString(this.image);
	}


}
