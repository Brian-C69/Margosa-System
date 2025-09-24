<%-- 
    Document   : GuardPanel
    Created on : Jul 12, 2023, 2:39:30 AM
    Author     : Bernard
--%>
<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.GuardDao"%>
<%@page import="model.Guard"%>
<%@page import="java.util.List"%>

<%
    Admin admin = (Admin) request.getSession().getAttribute("admin");
    // Check if admin is logged in
    if (admin == null) {
        request.setAttribute("errorMessage", "You must be logged in as an admin.");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        return;
    }

    // Retrieve list of guards from the database
    GuardDao guardDao = new GuardDao(connection.SqlCon.getConnection());
    List<Guard> guards = guardDao.getAllGuards();
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Guard Panel</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Guard Panel</h1>
        </div>
        <div class="container text-center">
            <p>
                <a href="AdminPanel.jsp" class="btn btn-secondary">Back</a>
                <a href="AdminAddGuard.jsp" class="btn btn-primary">Add Guard</a>
            </p>
        </div>
        <div class="container">
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">GID</th>
                        <th scope="col">Username</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Phone Number</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < guards.size(); i++) {
                        Guard guard = guards.get(i);
                    %>
                        <tr>
                            <td><%= i + 1 %></td>
                            <td><%= guard.getGid() %></td>
                            <td><%= guard.getUsername() %></td>
                            <td><%= guard.getName() %></td>
                            <td><%= guard.getEmail() %></td>
                            <td><%= guard.getPhoneNum() %></td>
                            <td>
                                <a href="AdminEditGuard.jsp?gid=<%= guard.getGid() %>" class="btn btn-primary">Edit</a>
                                <a href="AdminRemoveGuardServlet?gid=<%= guard.getGid() %>" class="btn btn-danger">Remove</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
