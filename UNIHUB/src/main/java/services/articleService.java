package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Article;
import utils.dbConnect;

public class articleService {
	public void createArticle(Article article) {
		try {
			String query = "INSERT INTO articles (title, content, summary, image, date_posted) VALUES (?, ?, ?, ?, CURRENT_DATE)";
			PreparedStatement stmt = dbConnect.getConnection().prepareStatement(query);
			stmt.setString(1, article.getTitle());
			stmt.setString(2, article.getContent());
			stmt.setString(3, article.getSummery());
			stmt.setBytes(4, article.getImage()); // Properly handle the InputStream
			stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Article> getAllArticles() {
		List<Article> articles = new ArrayList<Article>();

		try (Connection conn = dbConnect.getConnection()) {
			String sql = "SELECT * FROM articles ORDER BY date_posted DESC";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Article article = new Article();
				article.setId(rs.getInt("id"));
				article.setTitle(rs.getString("title"));
				article.setContent(rs.getString("content"));
				article.setSummery(rs.getString("summary"));
				article.setImage(rs.getBytes("image"));
				article.getBase64Image();
				article.setPostedDate(rs.getDate("date_posted"));
				articles.add(article);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return articles;
	}

	public Article getArticleById(int id) {
		Article article = null;
		String query = "SELECT * FROM articles WHERE id = ?";

		try (Connection conn = dbConnect.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				article = new Article();
				article.setId(rs.getInt("id"));
				article.setTitle(rs.getString("title"));
				article.setContent(rs.getString("content"));
				article.setSummery(rs.getString("summary"));
				article.setImage(rs.getBytes("image"));
				article.getBase64Image();
				article.setPostedDate(rs.getDate("date_posted"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}

		return article;
	}

	public int getArticleCount() {
		String query = "SELECT COUNT(id) FROM articles";
		int count = 0;

		try (Connection conn = dbConnect.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
				ResultSet rs = pstmt.executeQuery()) {

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public List<Article> getAllArticlesAccordingtoID() {
		List<Article> articles = new ArrayList<Article>();

		try (Connection conn = dbConnect.getConnection()) {
			String sql = "SELECT * FROM articles ORDER BY id";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Article article = new Article();
				article.setId(rs.getInt("id"));
				article.setTitle(rs.getString("title"));
				article.setContent(rs.getString("content"));
				article.setSummery(rs.getString("summary"));
				article.setImage(rs.getBytes("image"));
				article.getBase64Image();
				article.setPostedDate(rs.getDate("date_posted"));
				articles.add(article);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return articles;
	}

	public void updateArticle(Article article) {
		String sql = "UPDATE articles SET title = ?, summary = ?, content = ?, image = ? WHERE id = ?";

		try (Connection conn = dbConnect.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, article.getTitle());
			stmt.setString(2, article.getSummery());
			stmt.setString(3, article.getContent());

			byte[] imageBytes = article.getImage();
			if (imageBytes != null) {
				stmt.setBytes(4, imageBytes);
			} else {
				stmt.setNull(4, java.sql.Types.BLOB);
			}

			stmt.setInt(5, article.getId());

			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
	}

	public void deleteArticle(int id) {
		String query = "DELETE FROM articles WHERE id = ?";
		try (Connection conn = dbConnect.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, id);
			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
	}

}
