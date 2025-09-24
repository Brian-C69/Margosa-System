package servlet;

import dao.CarDao;
import model.Car;
import model.Family;
import model.Resident;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResidentAddCarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Resident resident = (Resident) request.getSession().getAttribute("resident");
            Family family = (Family) request.getSession().getAttribute("family");

            if (resident == null || family == null) {
                request.setAttribute("errorMessage", "You must be logged in");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            String carBrand = capitalizeFirstLetter(request.getParameter("carBrand"));
            String carModel = capitalizeFirstLetter(request.getParameter("carModel"));
            String carColor = capitalizeFirstLetter(request.getParameter("carColor"));
            String carPlateNum = request.getParameter("carPlateNum").replaceAll("\\s", "").toUpperCase();
            String carType = capitalizeFirstLetter(request.getParameter("carType"));

            // Check if carPlateNum contains at least one letter and one number
            if (!carPlateNum.matches(".*[a-zA-Z].*") || !carPlateNum.matches(".*\\d.*")) {
                request.setAttribute("errorMessage", "Invalid car plate number");
                request.setAttribute("carBrand", carBrand);
                request.setAttribute("carModel", carModel);
                request.setAttribute("carColor", carColor);
                request.setAttribute("carType", carType);
                request.getRequestDispatcher("addCar.jsp").forward(request, response);
                return;
            }

            Car car = new Car();
            car.setCarBrand(carBrand);
            car.setCarModel(carModel);
            car.setCarColor(carColor);
            car.setCarPlateNum(carPlateNum);
            car.setCarType(carType);
            car.setFid(family.getFid());

            CarDao carDao = new CarDao(connection.SqlCon.getConnection());
            carDao.addCar(car);

            response.sendRedirect("residentCars.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception as desired, such as displaying an error message
            request.setAttribute("errorMessage", "An error occurred while adding the car");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    private String capitalizeFirstLetter(String input) {
        if (input != null && !input.isEmpty()) {
            return input.substring(0, 1).toUpperCase() + input.substring(1);
        }
        return input;
    }
}