package servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class CommitteeLogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            if (request.getSession().getAttribute("committee") != null) {
                request.getSession().invalidate();

                request.setAttribute("successMessage", "You have logged out");
                response.sendRedirect("committee.jsp");
            } else {
                response.sendRedirect("index.jsp");
            } 
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to logout.");
            request.getRequestDispatcher("committee.jsp").forward(request, response);
        }
    }
}
