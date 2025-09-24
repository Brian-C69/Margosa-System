<%-- 
    Document   : addVisitor
    Created on : Jul 9, 2023, 11:41:46 AM
    Author     : Bernard
--%>
<%@page import="model.Resident"%>
<%@page import="model.Family"%>
<%@page import="dao.VisitorDao"%>

<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    Family family = (Family) request.getSession().getAttribute("family");
    if (resident == null) {
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    // Retrieve the stored form values if an error occurred
    String visitorName = (String) request.getAttribute("storedVisitorName");
    String visitorPhoneNum = (String) request.getAttribute("storedVisitorPhoneNum");
    String visitorVehicleNum = (String) request.getAttribute("storedVisitorVehicleNum");
    
    // Check for null values and set them to empty strings
    visitorName = (visitorName != null) ? visitorName : "";
    visitorPhoneNum = (visitorPhoneNum != null) ? visitorPhoneNum : "";
    visitorVehicleNum = (visitorVehicleNum != null) ? visitorVehicleNum : "";
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Add Visitor</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        
        <div class="container">
            <div class="wrapper">
                <h1>Add Visitor</h1>
                <%-- Display Error Message --%>
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                   if (errorMessage != null) {%>
                    <div class="alert alert-danger" role="alert">
                        <%= errorMessage%>
                    </div>
                <% }%>
                <form action="ResidentAddVisitorServlet" method="post">
                    <div class="form-group">
                        <label>Visitor Name</label>
                        <input type="text" name="visitorName" class="form-control" value="<%= visitorName %>" required>
                    </div>    

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="visitorPhoneNum" class="form-control" value="<%= visitorPhoneNum %>" required>
                    </div>                  

                    <div class="form-group">
                        <label>Vehicle Number</label>
                        <input type="text" name="visitorVehicleNum" class="form-control" value="<%= visitorVehicleNum %>" required>
                    </div> 

                    <div class="form-group pt-2">
                        <input type="submit" class="btn btn-primary" value="Add">
                        <a href="residentVisitor.jsp" class="btn btn-secondary">Back</a>
                    </div>
                </form>
            </div>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
