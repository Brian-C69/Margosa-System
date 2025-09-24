<%-- 
    Document   : login
    Created on : Jun 29, 2023, 5:13:07 PM
    Author     : Bernard
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="connection.SqlCon"%>
<%@page import="model.Resident"%>
<% 
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    if (resident != null) {
        response.sendRedirect("home.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Login</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 pb-5">
            <h1>Login</h1>
        </div>
        
        <div class="container">
         <div class="wrapper">
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
            <form action="ResidentLoginServlet" method="post">
                <div class="form-group">
                    <label>Username or Email</label>
                    <input type="text" name="input" class="form-control" required>
                    <span class="invalid-feedback"></span>
                </div>    

                <div class="form-group pt-2">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required>
                    <span class="invalid-feedback"></span>
                </div>

                <div class="form-group pt-2">
                    <input type="submit" class="btn btn-primary" value="Login">
                </div>
                <p class="pt-3">Don't have an account? <a href="register.jsp">Sign up now</a>.</p>
            </form>
         </div>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
