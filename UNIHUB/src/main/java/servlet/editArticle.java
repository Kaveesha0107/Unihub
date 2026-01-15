package servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.fasterxml.jackson.databind.ObjectMapper;

import model.Article;
import services.articleService;

@WebServlet("/editArticle")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Max 10MB upload
public class editArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public editArticle() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		articleService as = new articleService();
		String idParam = request.getParameter("id");
		if (idParam == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing article id");
			return;
		}

		int id;
		try {
			id = Integer.parseInt(idParam);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid article id");
			return;
		}
		Article article = as.getArticleById(id);
		if (article == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Article not found");
			return;
		}
		// Set response content type to JSON
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Convert article object to JSON
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(article);

		// Send JSON to the client
		response.getWriter().write(json);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// Read form fields from multipart request
		String idParam = getFormFieldValue(request, "id");
		String title = getFormFieldValue(request, "title");
		String summary = getFormFieldValue(request, "summary");
		String content = getFormFieldValue(request, "content");

		// Validate required fields
		if (idParam == null || title == null || summary == null || content == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing form data");
			return;
		}

		int id;
		try {
			id = Integer.parseInt(idParam);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid article id");
			return;
		}

		articleService as = new articleService();

		// Load existing article by ID
		Article article = as.getArticleById(id);
		if (article == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Article not found");
			return;
		}

		// Update article fields
		article.setTitle(title);
		article.setSummery(summary); // Assuming your model uses 'summery'
		article.setContent(content);

		// Handle image upload (optional)
		Part imagePart = request.getPart("image");
		if (imagePart != null && imagePart.getSize() > 0) {
			try (InputStream is = imagePart.getInputStream()) {
				byte[] imageBytes = is.readAllBytes();
				article.setImage(imageBytes); // Make sure your Article model has this field
			} catch (IOException e) {
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to process image");
				return;
			}
		}

		// Update article in database
		as.updateArticle(article);

	}

	/**
	 * Helper method to read a form field value from multipart request.
	 */
	private String getFormFieldValue(HttpServletRequest request, String fieldName)
			throws IOException, ServletException {
		Part part = request.getPart(fieldName);
		if (part != null) {
			try (InputStream inputStream = part.getInputStream()) {
				java.util.Scanner scanner = new java.util.Scanner(inputStream, "UTF-8").useDelimiter("\\A");
				return scanner.hasNext() ? scanner.next() : null;
			}
		}
		return null;
	}
}
