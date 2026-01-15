package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Article;
import services.articleService;

@WebServlet("/specificArticle")
public class specificArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public specificArticle() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idParam = request.getParameter("id");
		if (idParam != null) {
            int id = Integer.parseInt(idParam);
            // Fetch the article by ID from your data source
            articleService as = new articleService();
            Article article = as.getArticleById(id);
            request.setAttribute("article", article);
            request.getRequestDispatcher("specificArticle.jsp").forward(request, response);
        } else {
            response.sendRedirect("articles.jsp"); // fallback if no id
        }
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
