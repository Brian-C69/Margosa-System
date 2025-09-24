package servlet;

import dao.CarDao;
import model.Car;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResidentCarRemoveServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String carIdParam = request.getParameter("cid");
            if (carIdParam == null || carIdParam.isEmpty()) {
                // Handle invalid car ID case
                response.sendRedirect("residentCars.jsp");
                return;
            }

            int cid = Integer.parseInt(carIdParam);

            CarDao carDao = new CarDao(connection.SqlCon.getConnection());
            carDao.deleteCar(cid);

            response.sendRedirect("residentCars.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception as desired, such as displaying an error message
            request.setAttribute("errorMessage", "An error occurred while removing the car");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}
