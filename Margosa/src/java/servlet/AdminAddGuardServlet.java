package servlet;

import dao.GuardDao;
import connection.SqlCon;
import model.Admin;
import model.Guard;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminAddGuardServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if admin is logged in
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            request.setAttribute("errorMessage", "You must be logged in as an admin.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
            return;
        }

        try {
            // Get the form data
            String username = request.getParameter("username").toLowerCase(); // Convert username to lowercase
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneNum = request.getParameter("phoneNum");

            // Create a new Guard object
            Guard guard = new Guard();
            guard.setUsername(username);
            guard.setPassword(password);
            guard.setName(name);
            guard.setEmail(email);
            guard.setPhoneNum(phoneNum);

            // Create a GuardDao and add the guard
            GuardDao guardDao = new GuardDao(SqlCon.getConnection());
            guardDao.addGuard(guard);

            // Redirect back to the Guard Panel with success message
            request.setAttribute("successMessage", "Guard added successfully.");
            response.sendRedirect("GuardPanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to add guard.");
            request.getRequestDispatcher("AdminAddGuard.jsp").forward(request, response);
        }
    }
}
