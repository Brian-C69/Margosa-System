
<%-- 
        Document   : residentVisitor
        Created on : Jul 9, 2023, 11:39:01 AM
        Author     : Bernard
    --%>
    <%@page import="java.util.List"%>
    <%@page import="model.Resident"%>
    <%@page import="model.Family"%>
    <%@page import="model.Visitor"%>
    <%@page import="dao.VisitorDao"%>
    <%@page import="connection.SqlCon"%>
    <%
        Resident resident = (Resident) request.getSession().getAttribute("resident");
        Family family = (Family) request.getSession().getAttribute("family");

        if (resident == null) {
            request.setAttribute("errorMessage", "You must be logged in");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        VisitorDao visitorDao = new VisitorDao(SqlCon.getConnection());
        List<Visitor> visitors = visitorDao.getVisitorsByFamilyId(family.getFid());
    %>

    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <jsp:include page="includes/headers.html"/>
            <title>MyMargosaApp | Visitors</title>
        </head>
        <body>
            <jsp:include page="includes/navbar.jsp"/>
            <div class="container pt-5"></div>
            <div class="container pt-5"></div>
            <div class="container pt-5 my-4 p-5 text-center rounded">
                <h1>Family Visitor Panel</h1>
            </div>
            <div class="container text-center">
                <p>
                    <a href="family.jsp" class="btn btn-secondary">Back</a>
                    <a href="addVisitor.jsp" class="btn btn-primary">Add Visitor</a>
                </p>
            </div>
            <div class="container">
                <table class="table table-light">
                    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Visitor Name</th>
            <th scope="col">Phone Number</th>
            <th scope="col">Vehicle Number</th>
            <th scope="col">Added Date</th>
            <th scope="col">Added Time</th>
            <th scope="col">QR Code</th>
        </tr>
    </thead>
    <tbody>
        <% if (visitors != null) {
            int id = 1;
            for (Visitor visitor : visitors) {%>
        <tr>
            <td><%= id %></td>
            <td><%= visitor.getVisitorName() %></td>
            <td><%= visitor.getVisitorPhoneNum() %></td>
            <td><%= visitor.getVisitorVehicleNum() %></td>
            <td><%= visitor.getVisitorAddedDate() %></td>
            <td><%= visitor.getVisitorAddedTime() %></td>
            <td><a href="visitorCode.jsp?vid=<%= visitor.getVid () %>" class="btn btn-primary">QR Code</a></td>
        </tr>
        <% id++;
            }
        } %>
    </tbody>
                </table>    
            </div>
            <jsp:include page="includes/footer.html"/>
        </body>
    </html>
