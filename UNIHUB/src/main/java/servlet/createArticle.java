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

import model.Article;
import services.articleService;

@WebServlet("/createArticle")
@MultipartConfig
public class createArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public createArticle() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set character encoding for non-English characters
        request.setCharacterEncoding("UTF-8");

        Article article = new Article();
        article.setTitle(request.getParameter("title"));
        article.setContent(request.getParameter("content"));
        article.setSummery(request.getParameter("summary"));
        
        Part filePart = request.getPart("image");
        byte[] imageBytes = null;
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                imageBytes = inputStream.readAllBytes(); // Convert stream to byte[]
            }
        }
        
        article.setImage(imageBytes);

        articleService as = new articleService();
        as.createArticle(article);

        // Forward to home.jsp (or any other page as needed)
        RequestDispatcher dispatch = request.getRequestDispatcher("adminDash");
        dispatch.forward(request, response);
    }
}
