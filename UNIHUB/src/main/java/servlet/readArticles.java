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

@WebServlet("/readArticles")
public class readArticles extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public readArticles() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        articleService service = new articleService();
        
        // Get latest 3 articles for carousel
        List<Article> latestArticles = service.getAllArticles();
        request.setAttribute("latestArticles", latestArticles);
        
        // Send the articles to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("articles.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
