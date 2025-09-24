package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Resident;

public class ResidentLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            if (request.getSession().getAttribute("resident") != null) {
                Resident resident = (Resident) request.getSession().getAttribute("resident");
                request.getSession().removeAttribute("resident");
                request.getSession().removeAttribute("family");

                // Get the current date and time
                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String logoutTime = dateFormat.format(now);

                System.out.println("Resident " + resident.getUsername() + " Logged Out at " + logoutTime);
                request.setAttribute("successMessage", "You have logged out");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        }
    }
}
