<%-- 
    Document   : admin
    Created on : Jul 11, 2023, 8:53:00 PM
    Author     : Bernard
--%>
<%@page import="model.Admin"%>
<% 
    Admin admin = (Admin) request.getSession().getAttribute("admin");
    if (admin != null) {
        response.sendRedirect("adminPanel.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Admin Login</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 pb-5">
            <h1>Admin Login</h1>
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
            <form action="AdminLoginServlet" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" required>
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
            </form>
         </div>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
