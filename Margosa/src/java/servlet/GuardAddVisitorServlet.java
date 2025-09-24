package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Guard;
import model.Visitor;
import dao.VisitorDao;
import connection.SqlCon;

public class GuardAddVisitorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Guard guard = (Guard) request.getSession().getAttribute("guard");
        if (guard == null) {
            request.setAttribute("errorMessage", "You must be logged in");
            request.getRequestDispatcher("guard.jsp").forward(request, response);
            return;
        }

        try {
            String visitorName = request.getParameter("visitorName");
            String visitorPhoneNum = request.getParameter("visitorPhoneNum");
            String visitorVehicleNum = request.getParameter("visitorVehicleNum");
            String houseStreet = request.getParameter("houseStreet");
            String houseNum = request.getParameter("houseNum");

            // Validate visitorPhoneNum
            visitorPhoneNum = visitorPhoneNum.replaceAll("\\s", "").replaceAll("\\+", "");
            // Remove "60" prefix if present and prepend "0"
            if (visitorPhoneNum.startsWith("60")) {
                visitorPhoneNum = "0" + visitorPhoneNum.substring(2);
            }

            // Check if phone number consists only of numeric values
            if (!visitorPhoneNum.matches("\\d+")) {
                request.setAttribute("errorMessage", "Invalid visitor phone number format");
                // Retain user input values in request attributes
                request.setAttribute("storedVisitorName", visitorName);
                request.setAttribute("storedVisitorVehicleNum", visitorVehicleNum);
                request.getRequestDispatcher("GuardAddVisitor.jsp").forward(request, response);
                return;
            }

            // Check the minimum and maximum length based on the prefix
            int minLength = visitorPhoneNum.startsWith("0") ? 10 : 9;
            int maxLength = visitorPhoneNum.startsWith("0") ? 11 : 9;
            if (visitorPhoneNum.length() < minLength || visitorPhoneNum.length() > maxLength) {
                request.setAttribute("errorMessage", "Invalid visitor phone number length");
                // Retain user input values in request attributes
                request.setAttribute("storedVisitorName", visitorName);
                request.setAttribute("storedVisitorVehicleNum", visitorVehicleNum);
                request.getRequestDispatcher("GuardAddVisitor.jsp").forward(request, response);
                return;
            }

            // Validate visitorVehicleNum
            visitorVehicleNum = visitorVehicleNum.replaceAll("\\s", "").toUpperCase();
            if (!visitorVehicleNum.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]+$")) {
                request.setAttribute("errorMessage", "Invalid visitor vehicle number format");
                // Retain user input values in request attributes
                request.setAttribute("storedVisitorName", visitorName);
                request.setAttribute("storedVisitorPhoneNum", visitorPhoneNum);
                request.getRequestDispatcher("GuardAddVisitor.jsp").forward(request, response);
                return;
            }

            // Get the current date and time
            java.util.Date currentDate = new java.util.Date();
            Date visitorAddedDate = new Date(currentDate.getTime());
            Time visitorAddedTime = new Time(currentDate.getTime());

            // Create a new Visitor object
            Visitor visitor = new Visitor();
            visitor.setVisitorName(visitorName);
            visitor.setVisitorPhoneNum(visitorPhoneNum);
            visitor.setVisitorVehicleNum(visitorVehicleNum);
            visitor.setVisitorAddedDate(visitorAddedDate);
            visitor.setVisitorAddedTime(visitorAddedTime);
            visitor.setVisitorEntryDate(visitorAddedDate); // Setting entry date same as added date
            visitor.setVisitorEntryTime(visitorAddedTime); // Setting entry time same as added time
            visitor.setHouseNum(houseNum);
            visitor.setHouseStreet(houseStreet);

            // Use VisitorDao to add the visitor and handle FID and House insertion
            VisitorDao visitorDao = new VisitorDao(SqlCon.getConnection());
            visitorDao.guardAddVisitor(visitor, houseStreet, houseNum);

            // Redirect the user back to GuardCreatedVisitors.jsp
            response.sendRedirect("GuardEnteredVisitors.jsp");
            System.out.println("Guard Added new Visitor "+ visitorName);
            
        } catch (Exception e) {
            e.printStackTrace();

            // Retain user input values in request attributes
            request.setAttribute("storedVisitorName", request.getParameter("visitorName"));
            request.setAttribute("storedVisitorPhoneNum", request.getParameter("visitorPhoneNum"));
            request.setAttribute("storedVisitorVehicleNum", request.getParameter("visitorVehicleNum"));
            request.getRequestDispatcher("GuardAddVisitor.jsp").forward(request, response);
        }
    }
}
