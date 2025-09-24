<%-- 
    Document   : createFamily
    Created on : Jul 1, 2023, 10:46:59 PM
    Author     : Bernard
--%>
<%@page import="model.Resident"%>
<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    if (resident == null) {
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } else {
        if (resident.getFid() > 0) {
            request.setAttribute("errorMessage", "You already have a family");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Create Family</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
        <script>
            function limitInputLength(input, maxLength) {
                if (input.value.length > maxLength) {
                    input.value = input.value.slice(0, maxLength); // Truncate the input to the maximum length
                }
                input.maxLength = maxLength; // Set the maxLength property to limit the input programmatically
            }
        </script>


    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>  
        <div class="container">
            <div class="wrapper">
            <h1>Create a New Family</h1>
            <p>Enter a Family Name and 6 Digit PIN to Create a family:</p>
            <% String errorMessage = (String) request.getAttribute("errorMessage");
                String familyNameInput = (String) request.getAttribute("familyNameInput");
                if (errorMessage != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage%>
            </div>
            <% }%>
            <form action="CreateFamilyServlet" method="post">
                <div class="form-group">
                    <label for="familyName">Family Name</label>
                    <input type="text" class="form-control" id="familyName" name="familyName" value="<%= request.getAttribute("familyNameInput") != null ? request.getAttribute("familyNameInput") : ""%>" required>
                    <span class="invalid-feedback"></span>
                </div>
                <div class="form-group pt-2">
                    <label for="familyPin">Family PIN (<b>6 Digit ONLY</b>)</label>
                    <input type="password" pattern="[0-9]*" inputmode="numeric" class="form-control" id="familyPin" name="familyPin" oninput="limitInputLength(this, 6)" required>
                    <span class="invalid-feedback"></span>
                </div>
                <div class="form-group pt-2">
                <button type="submit" class="btn btn-primary">Create Family</button>
                <a href="joinOrCreateFamily.jsp" class="btn btn-danger">Back</a>
                <p class="pt-3">Already have an Existing Family? <a href="joinFamily.jsp">Join existing Family</a>.</p>
                </div>
            </form>
        </div>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
