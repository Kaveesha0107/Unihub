package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Article;
import services.articleService;

@WebServlet("/articleDash")
public class articleDash extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public articleDash() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		articleService service = new articleService();

		int articleCount = service.getArticleCount();
		request.setAttribute("articleCount", articleCount);
		List<Article> articles = service.getAllArticlesAccordingtoID();
		request.setAttribute("articles", articles);

		RequestDispatcher dispatcher = request.getRequestDispatcher("articledash.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
