package servlet;

import connection.SqlCon;
import dao.ResidentDao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResidentRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String password = request.getParameter("password");
            String confirm_password = request.getParameter("confirm_password");

            if (!password.equals(confirm_password)) {
                request.setAttribute("errorMessage", "Passwords Do Not Match");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedEmail", request.getParameter("email"));
                request.setAttribute("storedPhone", request.getParameter("phone"));
                request.setAttribute("storedUsername", request.getParameter("username"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            Connection con = SqlCon.getConnection();

            // Check if username already exists
            String username = request.getParameter("username").toLowerCase(); // Convert username to lowercase
            ResidentDao residentDao = new ResidentDao(con);
            if (residentDao.isUsernameTaken(username)) {
                request.setAttribute("errorMessage", "Username is Already Taken");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedEmail", request.getParameter("email"));
                request.setAttribute("storedPhone", request.getParameter("phone"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check if username contains spaces
            if (username.contains(" ")) {
                request.setAttribute("errorMessage", "Username cannot contain spaces");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedEmail", request.getParameter("email"));
                request.setAttribute("storedPhone", request.getParameter("phone"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check if email already exists
            String email = request.getParameter("email");
            if (residentDao.isEmailUsed(email)) {
                request.setAttribute("errorMessage", "Email is already used");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedPhone", request.getParameter("phone"));
                request.setAttribute("storedUsername", request.getParameter("username"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            String phone = request.getParameter("phone");

// Remove spaces and "+" symbol
            phone = phone.replaceAll("\\s", "").replaceAll("\\+", "");

// Check if phone number consists only of numeric values
            if (!phone.matches("\\d+")) {
                request.setAttribute("errorMessage", "Invalid phone number format");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedEmail", request.getParameter("email"));
                request.setAttribute("storedUsername", request.getParameter("username"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

// Check if phone number begins with "0" or "60"
            if (!phone.startsWith("0") && !phone.startsWith("60")) {
                request.setAttribute("errorMessage", "Invalid phone number format");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedEmail", request.getParameter("email"));
                request.setAttribute("storedUsername", request.getParameter("username"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

// Remove "60" prefix if present and prepend "0"
            if (phone.startsWith("60")) {
                phone = "0" + phone.substring(2);
            }

// Check the maximum length based on the prefix
            int maxLength = phone.startsWith("0") ? 11 : 9;
            if (phone.length() < 10 || phone.length() > maxLength) {
                request.setAttribute("errorMessage", "Invalid phone number length");
                // Store user input values in request attributes
                request.setAttribute("storedFirstname", request.getParameter("firstname"));
                request.setAttribute("storedLastname", request.getParameter("lastname"));
                request.setAttribute("storedGender", request.getParameter("gender"));
                request.setAttribute("storedEmail", request.getParameter("email"));
                request.setAttribute("storedUsername", request.getParameter("username"));
                request.setAttribute("storedBirthday", request.getParameter("birthday"));

                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check if birthday is a future date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = null;
            try {
                selectedDate = dateFormat.parse(request.getParameter("birthday"));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            if (selectedDate != null) {
                Date currentDate = new Date();
                if (selectedDate.after(currentDate)) {
                    request.setAttribute("errorMessage", "Invalid date. Please select a date before today.");
                    // Store user input values in request attributes
                    request.setAttribute("storedFirstname", request.getParameter("firstname"));
                    request.setAttribute("storedLastname", request.getParameter("lastname"));
                    request.setAttribute("storedGender", request.getParameter("gender"));
                    request.setAttribute("storedEmail", request.getParameter("email"));
                    request.setAttribute("storedPhone", request.getParameter("phone"));
                    request.setAttribute("storedUsername", request.getParameter("username"));
                    request.setAttribute("storedBirthday", request.getParameter("birthday"));

                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            }

            PreparedStatement st;

            st = con.prepareStatement("INSERT INTO resident (FirstName, LastName, Gender, Email, PhoneNum, Username, Password, Birthday) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

            st.setString(1, request.getParameter("firstname"));
            st.setString(2, request.getParameter("lastname"));
            st.setString(3, request.getParameter("gender"));
            st.setString(4, email);
            st.setString(5, phone);
            st.setString(6, username);
            st.setString(7, password);
            st.setString(8, request.getParameter("birthday"));

            st.executeUpdate();

            // Get the current date and time
            Date now = new Date();
            String registrationTime = dateFormat.format(now);

            System.out.println("New Resident Registered Successfully. Username: " + username + ", Registered at: " + registrationTime);

            request.setAttribute("successMessage", "Register Success! Pending Committee Approval");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
