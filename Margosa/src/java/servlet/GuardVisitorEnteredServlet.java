package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.SqlCon;
import dao.VisitorDao;

public class GuardVisitorEnteredServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String visitorIdStr = request.getParameter("vid");
        int vid = Integer.parseInt(visitorIdStr);

        try {
            VisitorDao visitorDao = new VisitorDao(SqlCon.getConnection());
            visitorDao.updateVisitorEntry(vid);

            // Redirect back to the GuardCreatedVisitors.jsp page
            response.sendRedirect("GuardCreatedVisitors.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception or display an error message to the user
        }
    }
}
