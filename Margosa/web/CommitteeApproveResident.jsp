<%-- 
    Document   : CommitteeApproveResident
    Created on : Jul 13, 2023, 10:30:00 PM
    Author     : Bernard
--%>
<%@page import="java.util.List"%>
<%@page import="model.Resident"%>
<%@page import="dao.ResidentDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Committee"%>
<%@page import="connection.SqlCon"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%
    Committee committee = (Committee) request.getSession().getAttribute("committee");
    if (committee == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("committee.jsp").forward(request, response);
        return;
    }

    ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
    List<Resident> notApprovedResidents = residentDao.getNotApprovedResidents();
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Approve Residents</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Residents Pending Approval</h1>
        </div>
        <div class="container text-center">
            <p>
                <a href="ResidentPanel.jsp" class="btn btn-secondary">Back</a>
            </p>
        </div>
        <div class="container">
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Index</th>
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Birthday</th>
                        <th scope="col">Age</th>
                        <th scope="col">Email</th>
                        <th scope="col">Phone Number</th>
                        <th scope="col">Username</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% int index = 1;
                    for (Resident resident : notApprovedResidents) {
                    LocalDate birthday = resident.getBirthday().toLocalDate();
                    LocalDate currentDate = LocalDate.now();
                    Period age = Period.between(birthday, currentDate);%>
                        <tr>
                            <td scope="row"><%= index++ %></td>
                            <td><%= resident.getFirstName() %></td>
                            <td><%= resident.getLastName() %></td>
                            <td><%= resident.getGender() %></td>
                            <td><%= resident.getBirthday() %></td>
                            <td><%= age.getYears() %></td>
                            <td><%= resident.getEmail() %></td>
                            <td><%= resident.getPhoneNum() %></td>
                            <td><%= resident.getUsername() %></td>
                            <td><a href="CommitteeApproveResidentServlet?rid=<%= resident.getRid() %>" class="btn btn-success">Approve</a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
