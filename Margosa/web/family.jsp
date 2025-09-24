<%--
    Document   : family.jsp
    Created on : Jul 2, 2023, 2:31:22 AM
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
    
    String houseNumber = null;
    String houseStreet = null;
    
    if (resident == null) {
        // Handle the case when the resident is not logged in
        // Redirect to the login page or display an error message
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } else {
        // Resident is logged in
        // Check if resident's HID is null or 0
        if (resident.getHid() < 0) {
            // Resident is not assigned to a house
            // Redirect to the setHouse.jsp page to prompt for the house address
            request.getRequestDispatcher("setHouse.jsp").forward(request, response);
        } else {
            // Resident is assigned to a house
            // Retrieve the resident's HID from the database
            ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
            Integer residentHID = residentDao.getResidentHID(resident.getRid());
            
            // Check if residentHID is null or 0
            if (residentHID == null || residentHID == 0) {
                // Resident's HID is null in the database
                // Prompt them to set the house address
                request.getRequestDispatcher("setHouse.jsp").forward(request, response);
            } else {
                // Retrieve the house details based on the HID
                HouseDao houseDao = new HouseDao(SqlCon.getConnection());
                House house = houseDao.getHouseByHID(residentHID);
                
                // Check if the house details are found
                if (house != null) {
                    // Save the house details in variables
                    houseNumber = house.getHouseNum();
                    houseStreet = house.getHouseStreet();
                    
                    session.setAttribute("houseNumber", houseNumber);
                    session.setAttribute("houseStreet", houseStreet);
                }
            }
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Family</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Family Panel</h1>
        </div>
        
        <div class="container pt-5 text-center">
            <p>
                <a href="familyMembers.jsp" class="btn btn-success">My Family Members</a>
                <a href="house.jsp" class="btn btn-primary">My House</a>
                <a href="residentCars.jsp" class="btn btn-info">My Cars</a>
                <a href="residentVisitor.jsp" class="btn btn-warning">My Visitors</a>
                <a href="familyDetails.jsp" class="btn btn-dark">Family Details</a>
                <a href="home.jsp" class="btn btn-secondary ">Back</a>
            </p>
        </div> 
        <jsp:include page="includes/footer.html"/>
    </body>
</html>