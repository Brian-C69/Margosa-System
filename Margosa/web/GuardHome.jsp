<%-- 
    Document   : GuardHome
    Created on : Jul 12, 2023, 10:15:12 PM
    Author     : Bernard
--%>

<%@page import="model.Guard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Guard guard = (Guard) request.getSession().getAttribute("guard");
    if (guard == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("guard.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Guard Home</title>
    </head>
    <body>
<jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <% if (guard!= null && session.getAttribute("guard") != null) {%>
            <h1>Hello <%= guard.getName()%>!</h1>
            <% }%>
        </div>
        <div class="container text-center">
            <p>
            <a href="GuardCreatedVisitors.jsp"><button type="button" class="btn btn-primary">Visitor Panel</button></a>
            <a href="GuardCarPanel.jsp"><button type="button" class="btn btn-primary">Resident Car Panel</button></a>
            <a href="GuardLogoutServlet"><button type="button" class="btn btn-danger">Logout</button></a>
            </p>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
