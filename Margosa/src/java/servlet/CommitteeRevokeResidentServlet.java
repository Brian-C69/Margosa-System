package servlet;

import connection.SqlCon;
import dao.ResidentDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CommitteeRevokeResidentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int residentId = Integer.parseInt(request.getParameter("rid"));

        try {
            ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
            residentDao.revokeResident(residentId);
            response.sendRedirect("ResidentPanel.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception and display an error message
            request.setAttribute("errorMessage", "Failed to revoke resident.");
            request.getRequestDispatcher("ResidentPanel.jsp").forward(request, response);
        }
    }
}
