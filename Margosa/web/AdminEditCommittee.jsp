<%-- 
    Document   : AdminEditCommittee
    Created on : Jul 12, 2023, 4:25:10 PM
    Author     : Bernard
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>
<%@page import="model.Committee"%>
<%@page import="dao.CommitteeDao"%>

<%
    Admin admin = (Admin) request.getSession().getAttribute("admin");
    // Check if admin is logged in
    if (admin == null) {
        request.setAttribute("errorMessage", "You must be logged in as an admin.");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        return;
    }

    // Get the committee ID parameter
    String comIdParam = request.getParameter("comid");
    if (comIdParam == null || comIdParam.isEmpty()) {
        // Handle invalid ID case
        response.sendRedirect("CommitteePanel.jsp");
        return;
    }
    int comid = Integer.parseInt(comIdParam);

    // Retrieve the committee from the database
    CommitteeDao committeeDao = new CommitteeDao(connection.SqlCon.getConnection());
    Committee committee = committeeDao.getCommitteeById(comid);

    // Check if the committee exists
    if (committee == null) {
        response.sendRedirect("CommitteePanel.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Edit Committee</title>
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
                <h1>Edit Committee</h1>
                <form action="AdminUpdateCommitteeServlet" method="post">
                    <input type="hidden" name="comid" value="<%= committee.getComid() %>">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" class="form-control" value="<%= committee.getUsername() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="text" name="password" class="form-control" value="<%= committee.getPassword() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" value="<%= committee.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" value="<%= committee.getEmail() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phoneNum" class="form-control" value="<%= committee.getPhoneNum() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" name="role" class="form-control" value="<%= committee.getRole() %>" required>
                    </div>
                    <div class="form-group pt-2">
                        <input type="submit" value="Update Committee" class="btn btn-primary">
                        <a href="CommitteePanel.jsp" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
