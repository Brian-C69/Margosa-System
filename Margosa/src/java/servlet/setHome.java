package servlet;

import dao.HouseDao;
import dao.ResidentDao;
import model.House;
import model.Resident;
import connection.SqlCon;
import dao.FamilyDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Family;

public class setHome extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        // Retrieve house number and street from the request parameters
        String houseNum = request.getParameter("houseNum");
        String houseStreet = request.getParameter("houseStreet");

        // Retrieve the family's FID from the session using the family object
        Family family = (Family) request.getSession().getAttribute("family");
        int fid = family.getFid();

        // Create a new House object with the house number, street, and FID
        House house = new House();
        house.setHouseNum(houseNum);
        house.setHouseStreet(houseStreet);
        house.setFid(fid);

        // Get the HouseDao instance
        HouseDao houseDao = new HouseDao(SqlCon.getConnection());

        // Add the house to the database and retrieve the generated HID
        int hid = houseDao.addHouse(house);

        // Update the family's HID in the database
        family.setHid(hid);

        // Get the FamilyDao instance
        FamilyDao familyDao = new FamilyDao(SqlCon.getConnection());

        // Update the family's HID in the database
        familyDao.updateFamilyHID(fid, hid);

        // Update the resident's HID in the database
        Resident resident = (Resident) request.getSession().getAttribute("resident");
        resident.setHid(hid);

        // Get the ResidentDao instance
        ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());

        // Update the resident's HID in the database
        residentDao.updateResident(resident);

        // Set the success message as a request attribute
        request.setAttribute("successMessage", "Set Home Address Successful");

        // Forward the request to the home.jsp page
        request.getRequestDispatcher("home.jsp").forward(request, response);
    } catch (Exception e) {
        // Handle any exceptions that occur
        e.printStackTrace();
        // Set an error message as a request attribute
        request.setAttribute("errorMessage", "An error occurred while setting home address");
        // Forward the request to an error page
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}
}
