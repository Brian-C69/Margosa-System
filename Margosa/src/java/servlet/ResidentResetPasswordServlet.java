package servlet;

import connection.SqlCon;
import dao.ResidentDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Resident;

public class ResidentResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {

            String password = request.getParameter("password");
            Resident resident = (Resident) request.getSession().getAttribute("resident");
            
            if (resident == null) {
                // Handle the case when resident is null (not logged in)
                request.setAttribute("errorMessage", "You must be logged in");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return; // Stop further execution
            }
            
            int rid = resident.getRid();
            
            try {
                ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
                residentDao.resetPassword(password, rid);

            } catch (Exception e) {
                e.printStackTrace();
            }

            request.setAttribute("successMessage", "Password Reset Successful!");
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
