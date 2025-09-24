package servlet;

import connection.SqlCon;
import dao.AdminDao;
import dao.ResidentDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Admin;
import model.Resident;

public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");

        try (PrintWriter out = response.getWriter()) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            try {
                AdminDao adminDao = new AdminDao(SqlCon.getConnection());
                Admin admin = adminDao.adminLogin(username, password);

                if (admin != null) {
                    request.getSession().setAttribute("admin", admin);
                    response.sendRedirect("AdminPanel.jsp");
                } else {
                    request.setAttribute("errorMessage", "Login Failed! Incorrect username or password!");
                    request.getRequestDispatcher("admin.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
