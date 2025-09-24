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

public class AdminRemoveGuardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if admin is logged in
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            request.setAttribute("errorMessage", "You must be logged in as an admin.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
            return;
        }

        try {
            String guardIdParam = request.getParameter("gid");
            if (guardIdParam == null || guardIdParam.isEmpty()) {
                // Handle invalid ID case
                response.sendRedirect("GuardPanel.jsp");
                return;
            }
            // Get the guard ID parameter
            int gid = Integer.parseInt(guardIdParam);

            // Create a GuardDao and delete the guard
            GuardDao guardDao = new GuardDao(connection.SqlCon.getConnection());
            guardDao.deleteGuard(gid);

            // Redirect back to the Guard Panel with success message
            request.setAttribute("successMessage", "Guard deleted successfully.");
            response.sendRedirect("GuardPanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to delete guard.");
            request.getRequestDispatcher("GuardPanel.jsp").forward(request, response);
        }
    }
}
