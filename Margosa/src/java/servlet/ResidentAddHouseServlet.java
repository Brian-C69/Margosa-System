package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.House;
import dao.HouseDao;
import connection.SqlCon;
import model.Family;
import model.Resident;

public class ResidentAddHouseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get the Family object from the session attribute
            Resident resident = (Resident) request.getSession().getAttribute("resident");
            Family family = (Family) request.getSession().getAttribute("family");
            
            if (resident == null || family == null) {
                request.setAttribute("errorMessage", "You must be logged in");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Collect the houseNum and houseStreet from the form
            String houseNum = request.getParameter("houseNum");
            String houseStreet = request.getParameter("houseStreet");

            // Create a new House object
            House house = new House();
            house.setHouseNum(houseNum);
            house.setHouseStreet(houseStreet);
            house.setFid(family.getFid()); // Set the fid from the Family object

            // Use HouseDao to add the house
            HouseDao houseDao = new HouseDao(connection.SqlCon.getConnection());
            houseDao.addHouse(house);

            // Redirect the user back to house.jsp after successful insert
            response.sendRedirect("house.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
