<%-- 
    Document   : familyDetails
    Created on : Jul 8, 2023, 1:02:20 PM
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

    String houseNumber = (String) session.getAttribute("houseNumber");
    String houseStreet = (String) session.getAttribute("houseStreet");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Family Details</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Family Details</h1>
        </div>
        <div class="container text-center">
            <p>
                <a href="family.jsp" class="btn btn-secondary">Back</a>
            </p>
        </div>  
        
        <div class="container">
            <% if (family != null) { %>
            <h2>Family Information</h2>
            <p>Family ID: <%= family.getFid() %></p>
            <p>Family Name: <%= family.getFamilyName() %></p>
            <p>Family PIN: <%= family.getFamilyPin() %></p>
            <% } %>
        </div>
        <div class="container">
         <% if (houseNumber != null && houseStreet != null) { %>
                <h2>House Information</h2>
                <p>House Number: <%= houseNumber %></p>
                <p>House Street: <%= houseStreet %></p>
            <% } %>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
