<%@page import="model.Resident"%>
<% 
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    if (resident == null || resident.getFid() > 0) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Join or Create Family</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Hi <%= resident.getUsername() %>!</h1>
            <h2>Create or join a family to get started.</h2>
            <p>Please choose one of the following options:</p>
            <div class="btn-group">
                <a href="createFamily.jsp" class="btn btn-primary">Create new Family</a>
                <a href="joinFamily.jsp" class="btn btn-success">Join existing Family</a>
            </div>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
