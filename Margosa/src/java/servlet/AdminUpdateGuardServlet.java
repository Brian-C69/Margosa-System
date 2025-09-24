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

public class AdminUpdateGuardServlet extends HttpServlet {

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
            String gidParam = request.getParameter("gid");
            if (gidParam == null || gidParam.isEmpty()) {
                // Handle invalid ID case
                response.sendRedirect("GuardPanel.jsp");
                return;
            }
            // Get the guard ID parameter
            int gid = Integer.parseInt(gidParam);

            // Get the updated guard details from the form
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneNum = request.getParameter("phoneNum");

            // Create a new Guard object with the updated details
            Guard guard = new Guard(gid, username, password, name, email, phoneNum);

            // Create a GuardDao and update the guard details
            GuardDao guardDao = new GuardDao(connection.SqlCon.getConnection());
            guardDao.updateGuard(guard);

            // Redirect back to the Guard Panel with success message
            request.setAttribute("successMessage", "Guard updated successfully.");
            response.sendRedirect("GuardPanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update guard.");
            request.getRequestDispatcher("AdminEditGuard.jsp").forward(request, response);
        }
    }
}
