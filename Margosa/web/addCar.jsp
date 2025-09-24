<%-- 
    Document   : addCar
    Created on : Jul 8, 2023, 3:07:26 PM
    Author     : Bernard
--%>
<%@page import="connection.SqlCon"%>
<%@page import="model.Resident"%>
<%@page import="model.Family"%>
<%@page import="model.House"%>
<%@page import="dao.ResidentDao"%>
<%@page import="dao.HouseDao"%>

<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    Family family = (Family) request.getSession().getAttribute("family");
    if (resident == null) {
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Create Family</title>
        <style>.wrapper{
            width: 360px;
            padding: 20px;
        }</style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>

        <div class="container">
            <div class="wrapper">
                <h1>Add Car</h1>
                <!-- Display Error Message -->
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage%>
                </div>
                <% }%>
                <form action="ResidentAddCarServlet" method="post">
                    <div class="form-group">
                        <label>Car Brand (e.g. Perodua, Honda, Audi)</label>
                        <input type="text" name="carBrand" class="form-control" required value="<%= (request.getAttribute("carBrand") != null) ? request.getAttribute("carBrand") : ""%>">
                        <span class="invalid-feedback"></span>
                    </div>    

                    <div class="form-group">
                        <label>Car Model (e.g. Myvi, City, TTS)</label>
                        <input type="text" name="carModel" class="form-control" required value="<%= (request.getAttribute("carModel") != null) ? request.getAttribute("carModel") : ""%>">
                        <span class="invalid-feedback"></span>
                    </div>                  

                    <div class="form-group">
                        <label>Car Color (e.g. Silver, White, Blue)</label>
                        <input type="text" name="carColor" class="form-control" required value="<%= (request.getAttribute("carColor") != null) ? request.getAttribute("carColor") : ""%>">
                        <span class="invalid-feedback"></span>
                    </div> 

                    <div class="form-group">
                        <label>Car Plate Number (e.g. WNE866, WA2256B, VGA1122)</label>
                        <input type="text" name="carPlateNum" class="form-control" required value="<%= (request.getAttribute("carPlateNum") != null) ? request.getAttribute("carPlateNum") : ""%>">
                        <span class="invalid-feedback"></span>
                    </div> 

                    <div class="form-group">
                        <label>Car Type (e.g. Sedan, SUV, Van)</label>
                        <input type="text" name="carType" class="form-control" required value="<%= (request.getAttribute("carType") != null) ? request.getAttribute("carType") : ""%>">
                        <span class="invalid-feedback"></span>
                    </div>

                    <div class="form-group pt-2">
                        <input type="submit" class="btn btn-primary" value="Add">
                        <a href="residentCars.jsp" class="btn btn-secondary">Back</a>
                    </div>

                </form>
            </div>
        </div>

        <jsp:include page="includes/footer.html"/>
    </body>
</html>

