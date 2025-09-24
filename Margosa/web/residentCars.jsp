<%-- 
    Document   : residentCars
    Created on : Jul 8, 2023, 1:21:59 PM
    Author     : Bernard
--%>

<%@page import="java.util.List"%>
<%@page import="model.Resident"%>
<%@page import="model.Family"%>
<%@page import="model.House"%>
<%@page import="model.Car"%>
<%@page import="dao.ResidentDao"%>
<%@page import="dao.CarDao"%>

<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    Family family = (Family) request.getSession().getAttribute("family");
    if (resident == null) {
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    CarDao carDao = new CarDao(connection.SqlCon.getConnection());
    List<Car> cars = carDao.getCarsByFamilyId(family.getFid());
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | My Cars</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Family Car Panel</h1>
        </div>
        <div class="container text-center">
            <p>
                <a href="family.jsp" class="btn btn-secondary">Back</a>
                <a href="addCar.jsp" class="btn btn-primary">Add Car</a>
            </p>
        </div>
        <div class="container ">
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Brand</th>
                        <th scope="col">Model</th>
                        <th scope="col">Color</th>
                        <th scope="col">Car Plate</th>
                        <th scope="col">Type</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (cars != null) {
                            int id = 1;
                            for (Car car : cars) {%>
                    <tr>
                        <td><%= id%></td>
                        <td><%= car.getCarBrand()%></td>
                        <td><%= car.getCarModel()%></td>
                        <td><%= car.getCarColor()%></td>
                        <td><%= car.getCarPlateNum()%></td>
                        <td><%= car.getCarType()%></td>
                        <td><a class="btn btn-danger btn-sm" href="ResidentCarRemoveServlet?cid=<%= car.getCid() %>">Remove</a></td>
                    </tr>
                    <% id++;
                                    }
                                }%>
                </tbody>
            </table>    
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
