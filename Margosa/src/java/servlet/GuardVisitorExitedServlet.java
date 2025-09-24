package servlet;

import dao.VisitorDao;
import connection.SqlCon;
import model.Guard;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GuardVisitorExitedServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int vid = Integer.parseInt(request.getParameter("vid"));
        
        try {
            VisitorDao visitorDao = new VisitorDao(SqlCon.getConnection());
            visitorDao.updateVisitorExit(vid);
            response.sendRedirect("GuardEnteredVisitors.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception and display an error message
            request.setAttribute("errorMessage", "Failed to mark visitor as exited");
            request.getRequestDispatcher("GuardEnteredVisitors.jsp").forward(request, response);
        }
    }
}
