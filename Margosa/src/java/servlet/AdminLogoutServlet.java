package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Admin;

public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            if (request.getSession().getAttribute("admin") != null) {
                request.getSession().invalidate();

                request.setAttribute("successMessage", "You have logged out");
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch(Exception e){
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to logout.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }
}
