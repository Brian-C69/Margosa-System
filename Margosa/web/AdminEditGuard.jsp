<%-- 
    Document   : AdminEditGuard
    Created on : Jul 12, 2023, 4:25:10 PM
    Author     : Bernard
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>
<%@page import="model.Guard"%>
<%@page import="dao.GuardDao"%>

<%
    Admin admin = (Admin) request.getSession().getAttribute("admin");
    // Check if admin is logged in
    if (admin == null) {
        request.setAttribute("errorMessage", "You must be logged in as an admin.");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        return;
    }

    // Get the guard ID parameter
    String gidParam = request.getParameter("gid");
    if (gidParam == null || gidParam.isEmpty()) {
        // Handle invalid ID case
        response.sendRedirect("GuardPanel.jsp");
        return;
    }
    int gid = Integer.parseInt(gidParam);

    // Retrieve the guard from the database
    GuardDao guardDao = new GuardDao(connection.SqlCon.getConnection());
    Guard guard = guardDao.getGuardById(gid);

    // Check if the guard exists
    if (guard == null) {
        response.sendRedirect("GuardPanel.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Edit Guard</title>
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
                <h1>Edit Guard</h1>
                <form action="AdminUpdateGuardServlet" method="post">
                    <input type="hidden" name="gid" value="<%= guard.getGid() %>">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" class="form-control" value="<%= guard.getUsername() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="text" name="password" class="form-control" value="<%= guard.getPassword() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" value="<%= guard.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" value="<%= guard.getEmail() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phoneNum" class="form-control" value="<%= guard.getPhoneNum() %>" required>
                    </div>
                    <div class="form-group pt-2">
                        <input type="submit" value="Update Guard" class="btn btn-primary">
                        <a href="GuardPanel.jsp" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
