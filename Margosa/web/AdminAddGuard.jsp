<%-- 
    Document   : AdminAddGuard
    Created on : Jul 12, 2023, 2:15:44 PM
    Author     : Bernard
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>

<%
    Admin admin = (Admin) request.getSession().getAttribute("admin");
    // Check if admin is logged in
    if (admin == null) {
        request.setAttribute("errorMessage", "You must be logged in as an admin.");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Add Guard</title>
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
                <h1>Add Guard</h1>
            <form action="AdminAddGuardServlet" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phoneNum" class="form-control" required>
                </div>
                <div class="form-group pt-2">
                    <input type="submit" value="Add Guard" class="btn btn-primary">
                    <a href="GuardPanel.jsp" class="btn btn-secondary"> back</a>
                </div>
            </form>
        </div>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>

