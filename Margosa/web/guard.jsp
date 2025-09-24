<%--
    Document   : guard
    Created on : Jul 12, 2023, 6:30:00 PM
    Author     : Bernard
--%>
<%@page import="model.Guard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Guard guard = (Guard) request.getSession().getAttribute("guard");
    if (guard != null) {
        response.sendRedirect("GuardHome.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Guard Login</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 pb-5">
            <h1>Guard Login</h1>
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
            <form action="GuardLoginServlet" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="form-group pt-2">
                    <label>Password</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <div class="form-group pt-2">
                    <input type="submit" class="btn btn-primary" value="Login">
                </div>
            </form>
        </div>
        </div>    
            <jsp:include page="includes/footer.html"/>
    </body>
</html>
