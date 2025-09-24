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

public class AdminUpdateCommitteeServlet extends HttpServlet {

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
            String comIdParam = request.getParameter("comid");
            if (comIdParam == null || comIdParam.isEmpty()) {
                // Handle invalid ID case
                response.sendRedirect("CommitteePanel.jsp");
                return;
            }
            // Get the committee ID parameter
            int comid = Integer.parseInt(comIdParam);

            // Get the updated committee details from the form
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneNum = request.getParameter("phoneNum");
            String role = request.getParameter("role");

            // Create a new Committee object with the updated details
            Committee committee = new Committee(comid, username, password, name, email, phoneNum, role);

            // Create a CommitteeDao and update the committee details
            CommitteeDao committeeDao = new CommitteeDao(connection.SqlCon.getConnection());
            committeeDao.updateCommittee(committee);

            // Redirect back to the Committee Panel with success message
            request.setAttribute("successMessage", "Committee updated successfully.");
            response.sendRedirect("CommitteePanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update committee.");
            request.getRequestDispatcher("AdminEditCommittee.jsp").forward(request, response);
        }
    }
}
