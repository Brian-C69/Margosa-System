<%--
    Document   : house
    Created on : Jul 8, 2023, 1:21:59 PM
    Author     : Bernard
--%>

<%@page import="java.util.List"%>
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

    HouseDao houseDao = new HouseDao(connection.SqlCon.getConnection());
    List<House> houses = houseDao.getHousesByFamilyId(family.getFid());
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="includes/headers.html"/>
    <title>MyMargosaApp | Family Houses</title>
</head>
<body>
    <jsp:include page="includes/navbar.jsp"/>
    <div class="container pt-5"></div>
    <div class="container pt-5"></div>
    <div class="container pt-5 my-4 p-5 text-center rounded">
        <h1>Family House Panel</h1>
    </div>
    <div class="container text-center">
        <p>
            <a href="family.jsp" class="btn btn-secondary">Back</a>
            <a href="addHouse.jsp" class="btn btn-primary">Add House</a>
        </p>
    </div>
    <div class="container">
        <table class="table table-light">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">House Number</th>
                    <th scope="col">Street</th>
                </tr>
            </thead>
            <tbody>
                <% if (houses != null) {
                    int index = 1;
                    for (House house : houses) { %>
                    <tr>
                        <td><%= index %></td>
                        <td><%= house.getHouseNum() %></td>
                        <td><%= house.getHouseStreet() %></td>
                    </tr>
                    <% index++;
                    }
                } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="includes/footer.html"/>
</body>
</html>
