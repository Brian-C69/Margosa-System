package servlet;

import dao.CommitteeDao;
import model.Committee;
import connection.SqlCon;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CommitteeLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            String username = request.getParameter("username").toLowerCase(); 
            String password = request.getParameter("password");
            
            CommitteeDao committeeDao = new CommitteeDao(SqlCon.getConnection());
            Committee committee = committeeDao.committeeLogin(username, password);

            if (committee != null) {
                request.getSession().setAttribute("committee", committee);
                response.sendRedirect("CommitteeHome.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("committee.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to log in");
            request.getRequestDispatcher("committee.jsp").forward(request, response);
        }
    }
}
