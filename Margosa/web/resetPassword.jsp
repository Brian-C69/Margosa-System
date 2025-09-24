<%-- 
    Document   : resetPassword
    Created on : Jul 7, 2023, 9:02:45 PM
    Author     : Bernard
--%>
<%@page import="model.Resident"%>
<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    
    if (resident == null) {
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Reset Password</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 pb-5">
            <h1>Reset Password</h1>
        </div>
        <div class="container">
            <div class="wrapper">
            <form action="ResidentResetPasswordServlet" method="post">
                <div class="form-group pt-2">
                    <label>New Password</label>
                    <input type="password" class="form-control" name="password" required>
                    <span class="invalid-feedback"></span>
                </div>
                <div class="form-group pt-3">
                <button type="submit" class="btn btn-primary">Reset</button>
                <a href="home.jsp" class="btn btn-secondary">Back</a>
                </div>
            </form>
        </div>
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
