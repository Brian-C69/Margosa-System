package servlet;

import connection.SqlCon;
import dao.ResidentDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Resident;

public class ResidentLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");
        try (PrintWriter out = response.getWriter()) {

            String input = request.getParameter("input").toLowerCase(); // Convert input (username) to lowercase
            String password = request.getParameter("password");
            try {
                ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
                Resident resident = residentDao.residentLogin(input, password);

                if (resident != null) {
                    // Check if the account is approved
                    if (resident.isApproved()) {
                        request.getSession().setAttribute("resident", resident);

                        // Get the current date and time
                        Date now = new Date();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String loginTime = dateFormat.format(now);

                        System.out.println("Resident " + resident.getUsername() + " logged in at " + loginTime);
                        response.sendRedirect("home.jsp");
                        request.getSession().setAttribute("loginSuccess", true);
                    } else {
                        // Account is not approved
                        // Display error message on login page
                        request.setAttribute("errorMessage", "Login Failed! Account is not yet approved.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    // Display error message on login page
                    request.setAttribute("errorMessage", "Login Failed! Incorrect username/email or password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}
