<%-- 
    Document   : AdminPanel
    Created on : Jul 11, 2023, 10:14:35 PM
    Author     : Bernard
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Admin Panel</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <% if (admin != null && session.getAttribute("admin") != null) {%>
            <h1>Hello <%= admin.getName()%>!</h1>
            <% }%>
        </div>
        <div class="container text-center">
            <p>
            <a href="CommitteePanel.jsp"><button type="button" class="btn btn-primary">Committee Panel</button></a>
            <a href="GuardPanel.jsp"><button type="button" class="btn btn-primary">Guard Panel</button></a>
            </p>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
