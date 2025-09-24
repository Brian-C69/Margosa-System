package servlet;

import dao.CommitteeDao;
import connection.SqlCon;
import model.Admin;
import model.Committee;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminRemoveCommitteeServlet extends HttpServlet {

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
            String comIdParam = request.getParameter("comid");
            if (comIdParam == null || comIdParam.isEmpty()) {
                // Handle invalid ID case
                response.sendRedirect("CommitteePanel.jsp");
                return;
            }
            // Get the committee ID parameter
            int comid = Integer.parseInt(comIdParam);

            // Create a CommitteeDao and delete the committee
            CommitteeDao committeeDao = new CommitteeDao(connection.SqlCon.getConnection());
            committeeDao.deleteCommittee(comid);

            // Redirect back to the Committee Panel with success message
            request.setAttribute("successMessage", "Committee deleted successfully.");
            response.sendRedirect("CommitteePanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to delete committee.");
            request.getRequestDispatcher("CommitteePanel.jsp").forward(request, response);
        }
    }
}
