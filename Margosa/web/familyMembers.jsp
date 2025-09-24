<%-- 
    Document   : familyMembers
    Created on : Jul 8, 2023, 9:29:03 PM
    Author     : Bernard
--%>
<%@page import="model.Family"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ResidentDao"%>
<%@page import="model.Resident"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>

<%
    try {
        Family family = (Family) request.getSession().getAttribute("family");
        Resident resident = (Resident) request.getSession().getAttribute("resident");
        List<Resident> familyMembers = null;
        if (resident == null) {
            request.setAttribute("errorMessage", "You must be logged in");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            ResidentDao residentDao = new ResidentDao(connection.SqlCon.getConnection());
            familyMembers = residentDao.getResidentsByFamilyId(family.getFid());
        }
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>My Family Members</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>My Family Members</h1>
        </div>
        <div class="container text-center">
            <p>
                <a href="family.jsp" class="btn btn-secondary">Back</a>
            </p>
        </div>
        <div class="container">
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Birthday</th>
                        <th scope="col">Age</th>
                        <th scope="col">Email</th>
                        <th scope="col">Phone Number</th>
                        <th scope="col">Username</th>
                    </tr>
                </thead>
                <tbody>
                    <% int counter = 1;
                       for (Resident member : familyMembers) { 
                           LocalDate birthday = member.getBirthday().toLocalDate();
                           LocalDate currentDate = LocalDate.now();
                           Period age = Period.between(birthday, currentDate);
                           %>
                    <tr>
                        <td><%= counter %></td>
                        <td><%= member.getFirstName() %></td>
                        <td><%= member.getLastName() %></td>
                        <td><%= member.getGender() %></td>
                        <td><%= member.getBirthday() %></td>
                        <td><%= age.getYears() %></td>
                        <td><%= member.getEmail() %></td>
                        <td><%= member.getPhoneNum() %></td>
                        <td><%= member.getUsername() %></td>
                    </tr>
                    <% counter++;
                       } %>
                </tbody>
            </table>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
