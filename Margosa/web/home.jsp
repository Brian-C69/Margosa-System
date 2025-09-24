<%@page import="model.House"%>
<%@page import="dao.HouseDao"%>
<%@page import="model.Resident"%>
<%@page import="model.Family"%>
<%@page import="dao.FamilyDao"%>
<%@page import="connection.SqlCon"%>
<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    Boolean loginSuccess = (Boolean) request.getSession().getAttribute("loginSuccess");
   
    if (loginSuccess != null && loginSuccess && resident != null) {
        FamilyDao familyDao = new FamilyDao(SqlCon.getConnection());
        Family family = familyDao.getFamilyByResidentId(resident.getRid());

        if (family != null) {
            // Resident is assigned to a family
            session.setAttribute("family", family);
            
            // Retrieve the house details based on the resident's HID
            HouseDao houseDao = new HouseDao(SqlCon.getConnection());
            House house = houseDao.getHouseByHID(resident.getHid());
            
            // Set the house object in the session attribute
            session.setAttribute("house", house);

        } else {
            // Resident is not assigned to a family
            // Redirect to the joinOrCreateFamily.jsp page to join or create a family
            response.sendRedirect("joinOrCreateFamily.jsp");
            System.out.println(resident.getUsername() + " has not been assigned a family, redirecting now");
            return; // Add return statement here to stop further execution of the code
        }
    } else {
        // Handle the case when the resident is not logged in
        // Redirect to the login page or display an error message
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return; // Add return statement here to stop further execution of the code
    }
    
    // Retrieve the house details based on the resident's HID (even if family is null)
    HouseDao houseDao = new HouseDao(SqlCon.getConnection());
    House house = houseDao.getHouseByHID(resident.getHid());
    
    // Set the house object in the session attribute
    session.setAttribute("house", house);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <% if (resident != null && session.getAttribute("family") != null) { %>
            <h1>Hello <%= resident.getUsername() %>!</h1>
            <% } %>
            <h1>Welcome to <i class="bi bi-house-heart"></i> MyMSBSApp</h1>
            <h5>Connecting MSBS Community, Together!</h5>
            <!-- Display Error Message -->
            <% String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage%>
            </div>
            <% }%>
            <!-- Display Success Message -->
            <% String successMessage = (String) request.getAttribute("successMessage");
                if (successMessage != null) {%>
            <div class="alert alert-success" role="alert">
                <%= successMessage%>
            </div>
            <% }%>
        </div>
        <div class="container text-center">
            <p>
                <a href="family.jsp" class="btn btn-success">My Family</a>
                <a href="resetPassword.jsp" class="btn btn-warning">Reset Password</a>
                <a href="ResidentLogoutServlet" class="btn btn-danger">Logout</a>
            </p>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
