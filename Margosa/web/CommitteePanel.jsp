<%-- 
    Document   : CommitteePanel
    Created on : Jul 12, 2023, 2:23:30 AM
    Author     : Bernard
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CommitteeDao"%>
<%@page import="model.Committee"%>
<%@page import="java.util.List"%>
<%@page import="model.Admin"%>

<%
    Admin admin = (Admin) request.getSession().getAttribute("admin");
    // Check if admin is logged in
    if (admin == null) {
        request.setAttribute("errorMessage", "You must be logged in as an admin.");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        return;
    }

    // Retrieve list of committees from the database
    CommitteeDao committeeDao = new CommitteeDao(connection.SqlCon.getConnection());
    List<Committee> committees = committeeDao.getAllCommittees();
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Committee Panel</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Committee Panel</h1>
        </div>
        <div class="container text-center">
            <p>
                <a href="AdminPanel.jsp" class="btn btn-secondary">Back</a>
                <a href="AdminAddCommittee.jsp" class="btn btn-primary">Add Committee</a>
            </p>
        </div>
        <div class="container">
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">COMID</th>
                        <th scope="col">Username</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Phone Number</th>
                        <th scope="col">Role</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < committees.size(); i++) {
                        Committee committee = committees.get(i);
                    %>
                        <tr>
                            <td><%= i + 1 %></td>
                            <td><%= committee.getComid() %></td>
                            <td><%= committee.getUsername() %></td>
                            <td><%= committee.getName() %></td>
                            <td><%= committee.getEmail() %></td>
                            <td><%= committee.getPhoneNum() %></td>
                            <td><%= committee.getRole() %></td>
                            <td>
                                <a href="AdminEditCommittee.jsp?comid=<%= committee.getComid() %>" class="btn btn-primary">Edit</a>
                                <a href="AdminRemoveCommitteeServlet?comid=<%= committee.getComid() %>" class="btn btn-danger">Remove</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
