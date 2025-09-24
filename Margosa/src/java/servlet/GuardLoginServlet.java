package servlet;

import dao.GuardDao;
import model.Guard;
import connection.SqlCon;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class GuardLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username").toLowerCase(); 
            String password = request.getParameter("password");
            
            GuardDao guardDao = new GuardDao(SqlCon.getConnection());
            Guard guard = guardDao.guardLogin(username, password);

            if (guard != null) {
                request.getSession().setAttribute("guard", guard);
                response.sendRedirect("GuardHome.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("guard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to log in");
            request.getRequestDispatcher("guard.jsp").forward(request, response);
        }
    }
}
