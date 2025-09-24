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

public class AdminAddCommitteeServlet extends HttpServlet {

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
            String username = request.getParameter("username").toLowerCase(); 
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneNum = request.getParameter("phoneNum");
            String role = request.getParameter("role");

            // Create a new Committee object
            Committee committee = new Committee();
            committee.setUsername(username);
            committee.setPassword(password);
            committee.setName(name);
            committee.setEmail(email);
            committee.setPhoneNum(phoneNum);
            committee.setRole(role);

            // Create a CommitteeDao and add the committee
            CommitteeDao committeeDao = new CommitteeDao(SqlCon.getConnection());
            committeeDao.addCommittee(committee);

            // Redirect back to the Committee Panel with success message
            request.setAttribute("successMessage", "Committee added successfully.");
            response.sendRedirect("CommitteePanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to add committee.");
            request.getRequestDispatcher("AdminAddCommittee.jsp").forward(request, response);
        }
    }
}
