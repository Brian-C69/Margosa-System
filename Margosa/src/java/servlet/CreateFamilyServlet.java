package servlet;

import connection.SqlCon;
import dao.FamilyDao;
import dao.ResidentDao;
import model.Family;
import model.Resident;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateFamilyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String familyName = request.getParameter("familyName");
            String familyPin = request.getParameter("familyPin");

            // Validate the PIN format
            if (!isValidPin(familyPin)) {
                request.setAttribute("errorMessage", "Invalid PIN format. Please enter a 6-digit number.");
                request.setAttribute("familyNameInput", familyName); // Retain the correct family name
                request.getRequestDispatcher("createFamily.jsp").forward(request, response);
                return;
            }

            Connection con = SqlCon.getConnection();

            // Assuming you have a Resident object stored in the session
            Resident resident = (Resident) request.getSession().getAttribute("resident");

            // Create a new Family object
            Family family = new Family();
            family.setFamilyName(familyName);
            family.setFamilyPin(familyPin);

            // Save the Family object to the database
            FamilyDao familyDao = new FamilyDao(con);
            familyDao.addFamily(family);

            // Retrieve the generated FID from the database
            int generatedFid = getGeneratedFid(con, familyName);

            System.out.println("Generated FID: " + generatedFid); // Print the generated FID

            // Update the FID of the Resident to associate them with the newly created family
            resident.setFid(generatedFid);

            System.out.println("Resident RID: " + resident.getRid()); // Print the resident's RID

            // Update the resident's family ID in the database
            ResidentDao residentDao = new ResidentDao(con);
            residentDao.updateFamilyId(resident.getRid(), generatedFid);

            // Redirect to the home page or any other page you desire
            request.setAttribute("successMessage", "Sucessfully Created a Family");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private boolean isValidPin(String pin) {
        // Use regular expression to validate 6-digit number
        String pinPattern = "^[0-9]{6}$";
        return Pattern.matches(pinPattern, pin);
    }
    
    private int getGeneratedFid(Connection con, String familyName) throws SQLException {
        int generatedFid = 0;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT FID FROM Family WHERE FAMILYNAME = '" + familyName + "'");
        if (rs.next()) {
            generatedFid = rs.getInt("FID");
        }
        rs.close();
        stmt.close();
        return generatedFid;
    }
}
