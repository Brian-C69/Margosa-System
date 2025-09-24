package servlet;

import connection.SqlCon;
import dao.FamilyDao;
import dao.ResidentDao;
import model.Resident;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class JoinFamilyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fidString = request.getParameter("fid");
            String familyPin = request.getParameter("pin");

            // Verify if the fid is a valid number
            if (!fidString.matches("\\d+")) {
                request.setAttribute("errorMessage", "Invalid Family ID. Family ID must be a number");
                request.setAttribute("fidInput", fidString); // Retain the fidInput value
                request.getRequestDispatcher("joinFamily.jsp").forward(request, response);
                return;
            }

            int fid = Integer.parseInt(fidString);

            // Verify if the familyPin is a 6-digit number
            if (!familyPin.matches("\\d{6}")) {
                request.setAttribute("errorMessage", "Invalid Family PIN. Family PIN must be a 6-digit number");
                request.setAttribute("fidInput", fidString); // Retain the fidInput value
                request.getRequestDispatcher("joinFamily.jsp").forward(request, response);
                return;
            }

            Connection con = SqlCon.getConnection();
            FamilyDao familyDao = new FamilyDao(con);

            // Check if the Family ID and familyPin are correct
            ResultSet rs = familyDao.getFamilyById(fid);
            if (!rs.next()) {
                request.setAttribute("errorMessage", "Family ID not found. Please enter a valid Family ID");
                request.setAttribute("fidInput", ""); // Set fidInput to empty string
                request.getRequestDispatcher("joinFamily.jsp").forward(request, response);
                return;
            }

            String dbFamilyPin = rs.getString("FAMILYPIN");
            if (!familyPin.equals(dbFamilyPin)) {
                request.setAttribute("errorMessage", "Incorrect Family PIN");
                request.setAttribute("fidInput", fidString); // Retain the fidInput value
                request.getRequestDispatcher("joinFamily.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            Resident resident = (Resident) session.getAttribute("resident");

            // Check if the resident is visiting the page for the first time
            boolean isFirstTimeVisit = (resident == null);

            // Update the resident's family ID
            ResidentDao residentDao = new ResidentDao(con);
            residentDao.updateFamilyId(resident.getRid(), fid);

            // Assign HID to the resident if family's HID is not null
            int hid = rs.getInt("HID");
            if (hid > 0) {
                residentDao.updateHouseId(resident.getRid(), hid);
                resident.setHid(hid);
            }

            resident.setFid(fid);
            session.setAttribute("resident", resident);

            // Get the current date and time
            LocalDateTime dateTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String joinDateTime = dateTime.format(formatter);

            // Get the family name
            String familyName = rs.getString("FAMILYNAME");

            if (!isFirstTimeVisit) {
                // Resident has already visited the page before
                System.out.println(resident.getUsername() + " has joined " + familyName + " on " + joinDateTime);
            }

            // Redirect to the home page or any other page you desire
            request.setAttribute("successMessage", "Successfully joined a family");
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
