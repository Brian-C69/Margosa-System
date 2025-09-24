package servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class GuardLogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (PrintWriter out = response.getWriter()) {
            if (request.getSession().getAttribute("guard") != null) {
                request.getSession().invalidate();

                request.setAttribute("successMessage", "You have logged out");
                response.sendRedirect("guard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            } 
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to logout.");
            request.getRequestDispatcher("guard.jsp").forward(request, response);
        }
    }
}
