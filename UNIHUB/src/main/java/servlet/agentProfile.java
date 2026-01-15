package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.university;
import model.universityAgent;
import services.agentService;
import services.universityService;

@WebServlet("/agentProfile")
public class agentProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public agentProfile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("agentId") == null) {
	            response.sendRedirect("agentlogin.jsp");
	            return;
	        }

	        int agentId = (int) session.getAttribute("agentId");

	        agentService agentService = new agentService();
	        universityService universityService = new universityService();

	        universityAgent agent = agentService.getAgentById(agentId);
	        if (agent == null) {
	            response.sendRedirect("agentlogin.jsp");
	            return;
	        }
	        agent.getBase64Image();

	        university university = universityService.getUniById(agent.getUniversityId());

	        request.setAttribute("agent", agent);
	        request.setAttribute("university", university);

	        request.getRequestDispatcher("agentProfile.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
