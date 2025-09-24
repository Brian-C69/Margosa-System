<%-- 
    Document   : CommitteeHome
    Created on : Jul 12, 2023, 10:15:21 PM
    Author     : Bernard
--%>

<%@page import="model.Committee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Committee committee = (Committee) request.getSession().getAttribute("committee");
    if (committee == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("committee.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Committee Home</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <% if (committee!= null && session.getAttribute("committee") != null) {%>
            <h1>Hello <%= committee.getName()%>!</h1>
            <% }%>
        </div>
        <div class="container text-center">
            <p>
            <a href="ResidentPanel.jsp"><button type="button" class="btn btn-primary">Resident Panel</button></a>
            <a href="CommitteeCarPanel.jsp"><button type="button" class="btn btn-primary">Car Panel</button></a>
            <a href="CommitteeLogoutServlet"><button type="button" class="btn btn-danger">Logout</button></a>
            </p>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
